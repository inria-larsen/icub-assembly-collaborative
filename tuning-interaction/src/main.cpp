/*
  * Copyright (C) 2016  INRIA
  * Author: Anthony Voilque, Serena Ivaldi
  * email: serena.ivaldi@inria.fr
*/

/*
  * Copyright (C) 2011  Department of Robotics Brain and Cognitive Sciences - Istituto Italiano di Tecnologia
  * Author: Marco Randazzo
  * email: marco.randazzo@iit.it
  * Permission is granted to copy, distribute, and/or modify this program
  * under the terms of the GNU General Public License, version 2 or any
  * later version published by the Free Software Foundation.
  *
  * A copy of the license can be found at
  * http://www.robotcub.org/icub/license/gpl.txt
  *
  * This program is distributed in the hope that it will be useful, but
  * WITHOUT ANY WARRANTY; without even the implied warranty of
  * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE. See the GNU General
  * Public License for more details
*/

#include <yarp/os/all.h>
#include <yarp/sig/all.h>
#include <yarp/dev/all.h>
#include <iCub/ctrl/math.h>
#include <iCub/skinDynLib/skinContact.h>
#include <iCub/skinDynLib/skinContactList.h>
#include <string>
#include <fstream>

#include "robot_interfaces.h"

using namespace iCub::skinDynLib;
using namespace yarp::os;
using namespace yarp::sig;
using namespace yarp::dev;
using namespace std;

#define POS  0
#define TRQ  1
//                robot->icmd[rd->id]->setPositionMode(0);
#define jjj 0

// VARIABLES
//--------------------------------------------------------------------------
BufferedPort<iCub::skinDynLib::skinContactList> *port_skin_contacts;
BufferedPort<Vector> *port_left_arm;
BufferedPort<Vector> *port_right_arm;

BufferedPort<Vector> *port_skin_left_arm;
BufferedPort<Vector> *port_skin_right_arm;

robot_interfaces *robot;
bool   stiff;



//change master
//------------------------
void change_master(bool &left_arm_master)
{
	cout<<"MASTER = "<<((left_arm_master==true)?"left":"right")<<endl;
	left_arm_master=(!left_arm_master);
	if (left_arm_master)
	{

		cout<<"MASTER = LEFT"<<endl;

		for (int i=jjj; i<5; i++)
		{
			robot->icmd[LEFT_ARM]->setControlMode(i, VOCAB_CM_TORQUE);
			robot->icmd[RIGHT_ARM]->setControlMode(i, VOCAB_CM_POSITION_DIRECT);
			if (stiff==false) robot->iint[RIGHT_ARM]->setInteractionMode(i,VOCAB_IM_COMPLIANT);
			else              robot->iint[RIGHT_ARM]->setInteractionMode(i,VOCAB_IM_STIFF);
		}
	}
	else
	{
		cout<<"MASTER = RIGHT"<<endl;

		for (int i=jjj; i<5; i++)
		{
			robot->icmd[LEFT_ARM]->setControlMode(i, VOCAB_CM_POSITION_DIRECT);
			if (stiff==false) robot->iint[LEFT_ARM]->setInteractionMode(i,VOCAB_IM_COMPLIANT);
			else              robot->iint[LEFT_ARM]->setInteractionMode(i,VOCAB_IM_STIFF);
			robot->icmd[RIGHT_ARM]->setControlMode(i, VOCAB_CM_TORQUE);
		}
	}
}


//close port
//------------------------
void closePort(Contactable *_port)
{
	if (_port)
	{
		_port->interrupt();
		_port->close();

		delete _port;
		_port = 0;
	}
}

//close all
//------------------------
void closeAll()
{
	for (int i=0; i<5; i++)
	{
		robot->icmd[LEFT_ARM] ->setControlMode(i, VOCAB_CM_POSITION);
		robot->icmd[RIGHT_ARM]->setControlMode(i, VOCAB_CM_POSITION);
		robot->iint[LEFT_ARM] ->setInteractionMode(i,VOCAB_IM_STIFF);
		robot->iint[RIGHT_ARM]->setInteractionMode(i,VOCAB_IM_STIFF);
	}
	closePort(port_skin_contacts);
	closePort(port_left_arm);
	closePort(port_right_arm);
	closePort(port_skin_left_arm);
	closePort(port_skin_right_arm);

}




//=========================================================
// 			MAIN
//=========================================================
int main(int argc, char * argv[])
{
    ResourceFinder rf;
    rf.setVerbose(true);
    rf.configure(argc,argv);
    //rf.setDefaultContext("empty");
    //rf.setDefaultConfigFile("empty");

    if (rf.check("help"))
    {
        yInfo("help not yet implemented\n");
    }

    //initialize yarp network
    Network yarp;

    if (!yarp.checkNetwork())
    {
        yError("Sorry YARP network does not seem to be available, is the yarp server available?\n");
        return 1;
    }

	// VARIABLES
	//--------------------------------------------------------------------------

	string robotName;
    bool   left_arm_master;
    double encoders_master [16];
    double encoders_slave  [16];
    bool   autoconnect;
    Stamp  info;
    string moduleName;
    bool isOk;
    double rate = 0.02; // 20ms
    double seconds = 15;
    int nStepsDuration = (int)(seconds/0.02);
    bool dontMoveArm = true;
    bool imitation = true;

    double pressure_treshold_filter=1;
    double pressure_treshold=10;

    string portSkinRightArm;
    string portSkinLeftArm;
    string portSkinEvents;

    bool connectToSkinArmsNotEvents = true;


	// INITIALIZATION
	//--------------------------------------------------------------------------

	  robotName="icubGazebo";
    autoconnect = false;
    robot=0;
    left_arm_master=false;
    port_skin_contacts=0;
    stiff = true;
    moduleName = "assemblyTuning";

    portSkinLeftArm = "/"+robotName+"/skin/left_forearm_comp";
    portSkinRightArm = "/"+robotName+"/skin/right_forearm_comp";
    portSkinEvents = "/skinManager/skin_events:o"; //old: "/armSkinDriftComp/skin_events:o"

	robot=new robot_interfaces(LEFT_ARM, RIGHT_ARM);
	robot->setRobotName(robotName);
	robot->init();

	port_skin_contacts = new BufferedPort<skinContactList>;
	port_left_arm = new BufferedPort<Vector>;
	port_right_arm = new BufferedPort<Vector>;
	port_skin_left_arm = new BufferedPort<Vector>;
	port_skin_right_arm = new BufferedPort<Vector>;

	port_skin_contacts->open("/assemblyTuning/skin_contacts:i");
	port_left_arm->open("/assemblyTuning/left_arm:o");
	port_right_arm->open("/assemblyTuning/right_arm:o");
	port_skin_left_arm->open("/assemblyTuning/skin_left_arm:i");
	port_skin_right_arm->open("/assemblyTuning/skin_right_arm:i");


	//connection to skin events
	if (autoconnect)
	{
		cout<<" +++++ Attempting to connect to /armSkinDriftComp/skin_events:o  .."<<endl;
		isOk = Network::connect("/armSkinDriftComp/skin_events:o","/assemblyTuning/skin_contacs:i","tcp",false);
		if(isOk == true)
		{
			cout<<" +++++  Connection with the skin is OK"<<endl;
		}
		else
		{
			cout<<"*** PLEASE CONNECT THE SKIN DRIFT COMPENSATOR ***"<<endl;
			Time::delay(10.0);
			isOk = Network::connect("/armSkinDriftComp/skin_events:o","/assemblyTuning/skin_contacs:i","tcp",false);
			if(isOk==false)
			{
				cout<<"Could not connect to the skin - aborting"<<endl;
				closeAll();
				return 1;
			}
		}
	}

	//connection to tyhe skin of the forearms
	if(autoconnect)
	{

		cout<<" +++++ Attempting to connect to "<<portSkinLeftArm<<".."<<endl;
		isOk = Network::connect(portSkinLeftArm,"/assemblyTuning/skin_left_arm:i","tcp",false);
		if(isOk == true)
		{
			cout<<" +++++  Connection with the skin is OK"<<endl;
		}
		else
		{
			cout<<"*** PLEASE RESTART THE ROBOT ***"<<endl;
			cout<<"Could not connect to the skin - aborting"<<endl;
			closeAll();
			return 1;
		}

		cout<<" +++++ Attempting to connect to "<<portSkinRightArm<<".."<<endl;
		isOk = Network::connect(portSkinRightArm,"/assemblyTuning/skin_right_arm:i","tcp",false);
		if(isOk == true)
		{
			cout<<" +++++  Connection with the skin is OK"<<endl;
		}
		else
		{
			cout<<"*** PLEASE RESTART THE ROBOT ***"<<endl;
			cout<<"Could not connect to the skin - aborting"<<endl;
			closeAll();
			return 1;
		}

	}

	robot->iimp[LEFT_ARM]->setImpedance(0,0.2,0.02);
	robot->iimp[LEFT_ARM]->setImpedance(1,0.2,0.02);
	robot->iimp[LEFT_ARM]->setImpedance(2,0.2,0.02);
	robot->iimp[LEFT_ARM]->setImpedance(3,0.2,0.02);
	robot->iimp[LEFT_ARM]->setImpedance(4,0.1,0.00);

	robot->iimp[RIGHT_ARM]->setImpedance(0,0.2,0.02);
	robot->iimp[RIGHT_ARM]->setImpedance(1,0.2,0.02);
	robot->iimp[RIGHT_ARM]->setImpedance(2,0.2,0.02);
	robot->iimp[RIGHT_ARM]->setImpedance(3,0.2,0.02);
	robot->iimp[RIGHT_ARM]->setImpedance(4,0.1,0.00);

	cout<<"Are you ready to start the initialisation ? (y/n) ";

	string chinput;
	cin >> chinput;
	cout<<endl;

	if(chinput != "y")
	{
		closeAll();
		return 1;
	}


	yInfo("++ MOVING LEFT ARM identical to the right arm ...");
	for (int i=0; i<5; i++)
	{
		double tmp_pos=0.0;
		robot->ienc[RIGHT_ARM]->getEncoder(i,&tmp_pos);
		robot->icmd[LEFT_ARM]->setControlMode(i, VOCAB_CM_POSITION);
		robot->icmd[RIGHT_ARM]->setControlMode(i, VOCAB_CM_POSITION);
		robot->iint[LEFT_ARM]->setInteractionMode(i,VOCAB_IM_STIFF);
		robot->iint[RIGHT_ARM]->setInteractionMode(i,VOCAB_IM_STIFF);
		robot->ipos[LEFT_ARM]->setRefSpeed(i,10);
		robot->ipos[LEFT_ARM]->positionMove(i,tmp_pos);
	}
	double timeout = 0;
	do
	{
		int ok=0;
		for (int i=0; i<5; i++)
		{
			double tmp_pos_l=0;
			double tmp_pos_r=0;
			robot->ienc[LEFT_ARM]->getEncoder(i,&tmp_pos_l);
			robot->ienc[RIGHT_ARM]->getEncoder(i,&tmp_pos_r);
			if (fabs(tmp_pos_l-tmp_pos_r)<1.0) ok++;
		}
		if (ok==5) break;
		yarp::os::Time::delay(1.0);
		timeout++;
	}
	while (timeout < 10); //10 seconds
	if (timeout >=10)
	{
		yError("Unable to reach seafe initial position! Closing module");
		return false;
	}

	// change_master(left_arm_master);

	yInfo("Position tracking started");

  if(imitation) cout<<"\n\n******* GRAB ONE ARM AND THE OTHER WILL COPY *****\n"<<endl;
  else cout<<"\n\n******* GRAB AT LEAST ONE ARM TO MOVE IT *****\n"<<endl;

	cout<<"Are you ready to start moving the robot ? (y/n) ";
	cin >> chinput;
	cout<<endl;

	if(chinput != "y")
	{
		closeAll();
		return 1;
	}


	// RUN (ROUTINE CONTROL)
	//-------------------------------------------------------------


	for(int t=0; t<nStepsDuration; t++)
	{
        int  i_touching_right=0;
		    int  i_touching_left=0;
        int  i_touching_diff=0;
        double pressure_right=0;
        double pressure_left=0;
        double pressure_right_mean=0;
        double pressure_left_mean=0;

        info.update();

        /* reading skin contacts
        skinContactList *skinContacts  = port_skin_contacts->read(false);
        if(skinContacts)
        {
            for(skinContactList::iterator it=skinContacts->begin(); it!=skinContacts->end(); it++){
                if(it->getBodyPart() == LEFT_ARM)
                    i_touching_left += it->getActiveTaxels();
                else if(it->getBodyPart() == RIGHT_ARM)
                    i_touching_right += it->getActiveTaxels();
            }
        }
        i_touching_diff=i_touching_left-i_touching_right;
        */

        //reading skin values from the skin of the forearms
        Vector *skinright = port_skin_right_arm->read(false);
        Vector *skinleft = port_skin_left_arm->read(false);

        // Skin contact properties
        for(int i=3; i<=386; i++)
        {
          if(skinright[i]>pressure_treshold_filter)
          {
            pressure_right+=skinright[i];
            i_touching_right++;
          }
          if(skinleft[i]>pressure_treshold_filter)
          {
            pressure_left+=skinleft[i];
            i_touching_left++;
          }
        }

        // Define which arm is hold
        i_touching_diff=i_touching_left-i_touching_right;

        // Pressure right
        if(i_touching_right>0)
        {
          pressure_right_mean=pressure_right/i_touching_right;
        }
        else pressure_right_mean=0;

        // Pressure left
        if(i_touching_left)
        {
          pressure_left_mean=pressure_left/i_touching_left;
        }
        else pressure_left_mean=0;

        }

		// this is the part where we move the arms
		if(dontMoveArm == false)
		{
      // Imitation mode
      if(imitation == true)
      {


        // Define which arm is the master
        if (abs(i_touching_diff)<5)
        {
            yInfo("nothing!\n");
        }
        else
        if (i_touching_left>i_touching_right)
        {
            yInfo("Touching left arm! \n");
            if (!left_arm_master) change_master(left_arm_master);
        }
        else
        if (i_touching_right>i_touching_left)
        {
            yInfo("Touching right arm! \n");
            if (left_arm_master) change_master(left_arm_master);
        }

        // Left arm master
  			if (left_arm_master == true)
  			{

          // Ecriture des données encodeurs
          robot->ienc[LEFT_ARM] ->getEncoders(encoders_master);
  	   	  robot->ienc[RIGHT_ARM]->getEncoders(encoders_slave);
          ofstream fichier("left_arm_master.txt", ios::out | ios::app);
          if(fichier)
          {
            fichier << encoders_master << encoders_slave << endl;
            fichier.close();
          }
          else  yInfo("Impossible d'ouvrir le fichier left_arm_master.txt ! \n");

          // Ecriture des données pression
          ofstream fichier("left_arm_pressure.txt", ios::out | ios::app);
          if(fichier)
          {
            fichier << pressure_left_mean << endl;
            fichier.close();
          }
          else  yInfo("Impossible d'ouvrir le fichier left_arm_pressure.txt ! \n");

          if(pressure_left_mean > pressure_treshold)
          {
              for (int i=0; i<5; i++)
              {
                double tmp_pos=0.0;
                robot->ienc[LEFT_ARM]->getEncoder(i,&tmp_pos);
                robot->icmd[LEFT_ARM]->setControlMode(i, VOCAB_CM_TORQUE);
                robot->icmd[RIGHT_ARM]->setControlMode(i, VOCAB_CM_POSITION);
                robot->ipos[RIGHT_ARM]->setRefSpeed(i,10);
                robot->ipos[RIGHT_ARM]->positionMove(i,tmp_pos);
              }
              double timeout = 0;
              do
              {
                int ok=0;
                for (int i=0; i<5; i++)
                {
                  double tmp_pos_l=0;
                  double tmp_pos_r=0;
                  robot->ienc[LEFT_ARM]->getEncoder(i,&tmp_pos_l);
                  robot->ienc[RIGHT_ARM]->getEncoder(i,&tmp_pos_r);
                  if (fabs(tmp_pos_l-tmp_pos_r)<1.0) ok++;
                }
                if (ok==5) break;
                yarp::os::Time::delay(1.0);
                timeout++;
              }
              while (timeout < 10); //10 seconds
              if (timeout >=10)
              {
                yError("The RIGHT ARM is unable to reach LEFT ARM position! Closing module");
                return false;
              }
          }
          else
          {
            yInfo("Grasp harder the left arm ! \n");
          }

  				if (port_left_arm->getOutputCount()>0)
  				{
  					port_left_arm->prepare()= Vector(16,encoders_master);
  					port_left_arm->setEnvelope(info);
  					port_left_arm->write();
  				}
  				if (port_right_arm->getOutputCount()>0)
  				{
  					port_right_arm->prepare()= Vector(16,encoders_slave);
  					port_right_arm->setEnvelope(info);
  					port_right_arm->write();
  				}
  				for (int i=jjj; i<5; i++)
  				{
  					robot->ipid[RIGHT_ARM]->setReference(i,encoders_master[i]);
  				}
  			}

        // Right arm master
  			else
  			{
          // Ecriture des données encodeurs
  				robot->ienc[RIGHT_ARM]->getEncoders(encoders_master);
  				robot->ienc[LEFT_ARM] ->getEncoders(encoders_slave);
          ofstream fichier("right_arm_master.txt", ios::out | ios::app);
          if(fichier)
          {
            fichier << encoders_master << encoders_slave << endl;
            fichier.close();
          }
          else  yInfo("Impossible d'ouvrir le fichier right_arm_master.txt ! \n");


          // Ecriture des données pression
          ofstream fichier("right_arm_pressure.txt", ios::out | ios::app);
          if(fichier)
          {
            fichier << pressure_right_mean << endl;
            fichier.close();
          }
          else  yInfo("Impossible d'ouvrir le fichier right_arm_pressure.txt ! \n");

          // Manipulation du bras droit
          if(pressure_right_mean > pressure_treshold)
          {
              for (int i=0; i<5; i++)
              {
                double tmp_pos=0.0;
                robot->ienc[RIGHT_ARM]->getEncoder(i,&tmp_pos);
                robot->icmd[RIGHT_ARM]->setControlMode(i, VOCAB_CM_TORQUE);
                robot->icmd[LEFT_ARM]->setControlMode(i, VOCAB_CM_POSITION);
                robot->ipos[LEFT_ARM]->setRefSpeed(i,10);
                robot->ipos[LEFT_ARM]->positionMove(i,tmp_pos);
              }
              double timeout = 0;
              do
              {
                int ok=0;
                for (int i=0; i<5; i++)
                {
                  double tmp_pos_l=0;
                  double tmp_pos_r=0;
                  robot->ienc[LEFT_ARM]->getEncoder(i,&tmp_pos_l);
                  robot->ienc[RIGHT_ARM]->getEncoder(i,&tmp_pos_r);
                  if (fabs(tmp_pos_l-tmp_pos_r)<1.0) ok++;
                }
                if (ok==5) break;
                yarp::os::Time::delay(1.0);
                timeout++;
              }
              while (timeout < 10); //10 seconds
              if (timeout >=10)
              {
                yError("The LEFT ARM is unable to reach RIGHT ARM position! Closing module");
                return false;
              }
          }
          else
          {
            yInfo("Grasp harder the right arm ! \n");
          }

  				if (port_left_arm->getOutputCount()>0)
  				{
  					port_left_arm->prepare()= Vector(16,encoders_slave);
  					port_left_arm->setEnvelope(info);
  					port_left_arm->write();
  				}
  				if (port_right_arm->getOutputCount()>0)
  				{
  					port_right_arm->prepare()= Vector(16,encoders_master);
  					port_right_arm->setEnvelope(info);
  					port_right_arm->write();
  				}

  				for (int i=jjj; i<5; i++)
  				{
  					robot->ipid[LEFT_ARM]->setReference(i,encoders_master[i]);
  				}

  			}
      }
      else
      {

        // Ecriture des données encodeurs
        robot->ienc[LEFT_ARM] ->getEncoders(encoders_left_arm);
        robot->ienc[RIGHT_ARM]->getEncoders(encoders_right_arm);
        ofstream fichier("left_arm_master.txt", ios::out | ios::app);
        if(fichier)
        {
          fichier << encoders_left_arm << encoders_right_arm << endl;
          fichier.close();
        }
        else  yInfo("Impossible d'ouvrir le fichier left_arm_master.txt ! \n");

        // Ecriture des données pression
        ofstream fichier("left_arm_pressure.txt", ios::out | ios::app);
        if(fichier)
        {
          fichier << pressure_left_mean << endl;
          fichier.close();
        }
        else  yInfo("Impossible d'ouvrir le fichier left_arm_pressure.txt ! \n");

        if(pressure_left_mean > pressure_treshold)
        {
          for(int i=0; i<5; i++)
          {
            robot->icmd[LEFT_ARM]->setControlMode(i, VOCAB_CM_TORQUE);
          }
        }
        else
        {
          for(int i=0; i<5; i++)
          {
            double tmp_pos=0.0;
            robot->ienc[LEFT_ARM]->getEncoder(i,&tmp_pos);
            robot->icmd[LEFT_ARM]->setControlMode(i, VOCAB_CM_POSITION);
            robot->ipos[LEFT_ARM]->setRefSpeed(i,10);
            robot->ipos[LEFT_ARM]->positionMove(i,tmp_pos);
          }
        }

        if(pressure_right_arm > pressure_treshold)
        {
          for(int i=0; i<5; i++)
          {
            robot->icmd[RIGHT_ARM]->setControlMode(i, VOCAB_CM_TORQUE);
          }
        }
        else
        {
          for(int i=0; i<5; i++)
          {
            double tmp_pos=0.0;
            robot->ienc[RIGHT_ARM]->getEncoder(i,&tmp_pos);
            robot->icmd[RIGHT_ARM]->setControlMode(i, VOCAB_CM_POSITION);
            robot->ipos[RIGHT_ARM]->setRefSpeed(i,10);
            robot->ipos[RIGHT_ARM]->positionMove(i,tmp_pos);
          }
        }


      }
    }

		//end of the part where we move the arms

		// control rate (simplifying the robot loop)
		//20ms
		Time::delay(rate);

	}


		cout<<"\n\n******* FINISHED *****\n"<<endl;
		closeAll();




    return 0;
}
