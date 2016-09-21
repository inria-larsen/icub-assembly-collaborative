%% Subjects informations for arm end effector
% Script to sort subjects by trial according to their profile.
%
% authors: Anthony Voilque & Serena Ivaldi (serena.ivaldi@inria.fr)

profiles=load('Data/subjects_profiles');
N_sub=length(profiles);





%% Age

age_subjects=[profiles(:,1) profiles(:,4)];

if(exist('Data/extraction/leftArmEndEffector/age')==0)
        mkdir('Data/extraction/leftArmEndEffector/age');
end

for manip=1:3
    
    % Left arm end effector
    
    good_sub=[];
    good_sub=load(strcat('Data/extraction/leftArmEndEffector/manip',num2str(manip),'_LAEE_good'));
    
    age_subjects_good=[];
  
    for sub=1:N_sub
        k=find(good_sub==age_subjects(sub,1));
        if k>=1
            age_subjects_good=[age_subjects_good; age_subjects(sub,:)]; % if the subject is in the good-ones list, his number and age are written 
        end
    end
    
    dlmwrite(strcat('Data/extraction/leftArmEndEffector/age/manip',num2str(manip),'_age_subjects_good'),age_subjects_good,'delimiter',' ');
        
    
    
    % Right arm end effector
    if(exist('Data/extraction/rightArmEndEffector/age')==0)
        mkdir('Data/extraction/rightArmEndEffector/age');
    end
    good_sub=[];
    good_sub=load(strcat('Data/extraction/rightArmEndEffector/manip',num2str(manip),'_RAEE_good'));
    
    age_subjects_good=[];
  
    for sub=1:N_sub
        k=find(good_sub==age_subjects(sub,1));
        if k>=1
            age_subjects_good=[age_subjects_good; age_subjects(sub,:)]; % if the subject is in the good-ones list, his number and age are written 
        end
    end
    
    dlmwrite(strcat('Data/extraction/rightArmEndEffector/age/manip',num2str(manip),'_age_subjects_good'),age_subjects_good,'delimiter',' ');
    
end





%% Gender

gender_subjects=[profiles(:,1) profiles(:,2)];

if(exist('Data/extraction/leftArmEndEffector/gender')==0)
        mkdir('Data/extraction/leftArmEndEffector/gender');
end

for manip=1:3
    
    % Left arm end effector
    
    good_sub=[];
    good_sub=load(strcat('Data/extraction/leftArmEndEffector/manip',num2str(manip),'_LAEE_good'));
    
    gender_subjects_good=[];
  
    for sub=1:N_sub
        k=find(good_sub==gender_subjects(sub,1));
        if k>=1
            gender_subjects_good=[gender_subjects_good; gender_subjects(sub,:)]; % if the subject is in the good-ones list, his number and gender are written 
        end
    end
    
    dlmwrite(strcat('Data/extraction/leftArmEndEffector/gender/manip',num2str(manip),'_gender_subjects_good'),gender_subjects_good,'delimiter',' ');
        
    
    
    % Right arm end effector
    if(exist('Data/extraction/rightArmEndEffector/gender')==0)
        mkdir('Data/extraction/rightArmEndEffector/gender');
    end
    good_sub=[];
    good_sub=load(strcat('Data/extraction/rightArmEndEffector/manip',num2str(manip),'_RAEE_good'));
    
    gender_subjects_good=[];
  
    for sub=1:N_sub
        k=find(good_sub==gender_subjects(sub,1));
        if k>=1
            gender_subjects_good=[gender_subjects_good; gender_subjects(sub,:)]; % if the subject is in the good-ones list, his number and gender are written 
        end
    end
    
    dlmwrite(strcat('Data/extraction/rightArmEndEffector/gender/manip',num2str(manip),'_gender_subjects_good'),gender_subjects_good,'delimiter',' ');
    
end




%% Extroversion

extro_subjects=[profiles(:,1) profiles(:,6)];

if(exist('Data/extraction/leftArmEndEffector/extroversion')==0)
        mkdir('Data/extraction/leftArmEndEffector/extroversion');
end

for manip=1:3
    
    % Left arm end effector
    
    good_sub=[];
    good_sub=load(strcat('Data/extraction/leftArmEndEffector/manip',num2str(manip),'_LAEE_good'));
    
    extro_subjects_good=[];
  
    for sub=1:N_sub
        k=find(good_sub==extro_subjects(sub,1));
        if k>=1
            extro_subjects_good=[extro_subjects_good; extro_subjects(sub,:)]; % if the subject is in the good-ones list, his number and age are written 
        end
    end
    
    dlmwrite(strcat('Data/extraction/leftArmEndEffector/extroversion/manip',num2str(manip),'_extro_subjects_good'),extro_subjects_good,'delimiter',' ');
        
    
    
    % Right arm end effector
    if(exist('Data/extraction/rightArmEndEffector/extroversion')==0)
        mkdir('Data/extraction/rightArmEndEffector/extroversion');
    end
    good_sub=[];
    good_sub=load(strcat('Data/extraction/rightArmEndEffector/manip',num2str(manip),'_RAEE_good'));
    
    extro_subjects_good=[];
  
    for sub=1:N_sub
        k=find(good_sub==extro_subjects(sub,1));
        if k>=1
            extro_subjects_good=[extro_subjects_good; extro_subjects(sub,:)]; % if the subject is in the good-ones list, his number and age are written 
        end
    end
    
    dlmwrite(strcat('Data/extraction/rightArmEndEffector/extroversion/manip',num2str(manip),'_extro_subjects_good'),extro_subjects_good,'delimiter',' ');
    
end



%% Negative attitude

if(exist('Data/extraction/leftArmEndEffector/negativeAtt')==0)
        mkdir('Data/extraction/leftArmEndEffector/negativeAtt');
end

if(exist('Data/extraction/rightArmEndEffector/negativeAtt')==0)
        mkdir('Data/extraction/rightArmEndEffector/negativeAtt');
end


% NARS

if(exist('Data/extraction/leftArmEndEffector/negativeAtt/NARS')==0)
        mkdir('Data/extraction/leftArmEndEffector/negativeAtt/NARS');
end

if(exist('Data/extraction/rightArmEndEffector/negativeAtt/NARS')==0)
        mkdir('Data/extraction/rightArmEndEffector/negativeAtt/NARS');
end

neg_subjects=[];
neg_subjects=[profiles(:,1) profiles(:,7)];

for manip=1:3
    
    % Left arm end effector
    
    good_sub=[];
    good_sub=load(strcat('Data/extraction/leftArmEndEffector/manip',num2str(manip),'_LAEE_good'));
    
    neg_subjects_good=[];
  
    for sub=1:N_sub
        k=find(good_sub==neg_subjects(sub,1));
        if k>=1
            neg_subjects_good=[neg_subjects_good; neg_subjects(sub,:)]; % if the subject is in the good-ones list, his number and age are written 
        end
    end
    
    dlmwrite(strcat('Data/extraction/leftArmEndEffector/negativeAtt/NARS/manip',num2str(manip),'_neg_subjects_good'),neg_subjects_good,'delimiter',' ');
        
    
    
    % Right arm end effector
    if(exist('Data/extraction/rightArmEndEffector/negativeAtt')==0)
        mkdir('Data/extraction/rightArmEndEffector/negativeAtt');
    end
    good_sub=[];
    good_sub=load(strcat('Data/extraction/rightArmEndEffector/manip',num2str(manip),'_RAEE_good'));
    
    neg_subjects_good=[];
  
    for sub=1:N_sub
        k=find(good_sub==neg_subjects(sub,1));
        if k>=1
            neg_subjects_good=[neg_subjects_good; neg_subjects(sub,:)]; % if the subject is in the good-ones list, his number and age are written 
        end
    end
    
    dlmwrite(strcat('Data/extraction/rightArmEndEffector/negativeAtt/NARS/manip',num2str(manip),'_neg_subjects_good'),neg_subjects_good,'delimiter',' ');
    
end


% NS1
if(exist('Data/extraction/leftArmEndEffector/negativeAtt/NS1')==0)
        mkdir('Data/extraction/leftArmEndEffector/negativeAtt/NS1');
end

if(exist('Data/extraction/rightArmEndEffector/negativeAtt/NS1')==0)
        mkdir('Data/extraction/rightArmEndEffector/negativeAtt/NS1');
end

neg_subjects=[];
neg_subjects=[profiles(:,1) profiles(:,8)];

for manip=1:3
    
    % Left arm end effector
    
    good_sub=[];
    good_sub=load(strcat('Data/extraction/leftArmEndEffector/manip',num2str(manip),'_LAEE_good'));
    
    neg_subjects_good=[];
  
    for sub=1:N_sub
        k=find(good_sub==neg_subjects(sub,1));
        if k>=1
            neg_subjects_good=[neg_subjects_good; neg_subjects(sub,:)]; % if the subject is in the good-ones list, his number and age are written 
        end
    end
    
    dlmwrite(strcat('Data/extraction/leftArmEndEffector/negativeAtt/NS1/manip',num2str(manip),'_neg_subjects_good'),neg_subjects_good,'delimiter',' ');
        
    
    
    % Right arm end effector
   
    good_sub=[];
    good_sub=load(strcat('Data/extraction/rightArmEndEffector/manip',num2str(manip),'_RAEE_good'));
    
    neg_subjects_good=[];
  
    for sub=1:N_sub
        k=find(good_sub==neg_subjects(sub,1));
        if k>=1
            neg_subjects_good=[neg_subjects_good; neg_subjects(sub,:)]; % if the subject is in the good-ones list, his number and age are written 
        end
    end
    
    dlmwrite(strcat('Data/extraction/rightArmEndEffector/negativeAtt/NS1/manip',num2str(manip),'_neg_subjects_good'),neg_subjects_good,'delimiter',' ');
    
end

% NS2

if(exist('Data/extraction/leftArmEndEffector/negativeAtt/NS2')==0)
        mkdir('Data/extraction/leftArmEndEffector/negativeAtt/NS2');
end

if(exist('Data/extraction/rightArmEndEffector/negativeAtt/NS2')==0)
        mkdir('Data/extraction/rightArmEndEffector/negativeAtt/NS2');
end

neg_subjects=[];
neg_subjects=[profiles(:,1) profiles(:,9)];

for manip=1:3
    
    % Left arm end effector
    
    good_sub=[];
    good_sub=load(strcat('Data/extraction/leftArmEndEffector/manip',num2str(manip),'_LAEE_good'));
    
    neg_subjects_good=[];
  
    for sub=1:N_sub
        k=find(good_sub==neg_subjects(sub,1));
        if k>=1
            neg_subjects_good=[neg_subjects_good; neg_subjects(sub,:)]; % if the subject is in the good-ones list, his number and age are written 
        end
    end
    
    dlmwrite(strcat('Data/extraction/leftArmEndEffector/negativeAtt/NS2/manip',num2str(manip),'_neg_subjects_good'),neg_subjects_good,'delimiter',' ');
        
    
    
    % Right arm end effector
    
    good_sub=[];
    good_sub=load(strcat('Data/extraction/rightArmEndEffector/manip',num2str(manip),'_RAEE_good'));
    
    neg_subjects_good=[];
  
    for sub=1:N_sub
        k=find(good_sub==neg_subjects(sub,1));
        if k>=1
            neg_subjects_good=[neg_subjects_good; neg_subjects(sub,:)]; % if the subject is in the good-ones list, his number and age are written 
        end
    end
    
    dlmwrite(strcat('Data/extraction/rightArmEndEffector/negativeAtt/NS2/manip',num2str(manip),'_neg_subjects_good'),neg_subjects_good,'delimiter',' ');
    
end

% NS3

if(exist('Data/extraction/leftArmEndEffector/negativeAtt/NS3')==0)
        mkdir('Data/extraction/leftArmEndEffector/negativeAtt/NS3');
end

if(exist('Data/extraction/rightArmEndEffector/negativeAtt/NS3')==0)
        mkdir('Data/extraction/rightArmEndEffector/negativeAtt/NS3');
end

neg_subjects=[];
neg_subjects=[profiles(:,1) profiles(:,10)];

for manip=1:3
    
    % Left arm end effector
    
    good_sub=[];
    good_sub=load(strcat('Data/extraction/leftArmEndEffector/manip',num2str(manip),'_LAEE_good'));
    
    neg_subjects_good=[];
  
    for sub=1:N_sub
        k=find(good_sub==neg_subjects(sub,1));
        if k>=1
            neg_subjects_good=[neg_subjects_good; neg_subjects(sub,:)]; % if the subject is in the good-ones list, his number and age are written 
        end
    end
    
    dlmwrite(strcat('Data/extraction/leftArmEndEffector/negativeAtt/NS3/manip',num2str(manip),'_neg_subjects_good'),neg_subjects_good,'delimiter',' ');
        
    
    
    % Right arm end effector
   
    good_sub=[];
    good_sub=load(strcat('Data/extraction/rightArmEndEffector/manip',num2str(manip),'_RAEE_good'));
    
    neg_subjects_good=[];
  
    for sub=1:N_sub
        k=find(good_sub==neg_subjects(sub,1));
        if k>=1
            neg_subjects_good=[neg_subjects_good; neg_subjects(sub,:)]; % if the subject is in the good-ones list, his number and age are written 
        end
    end
    
    dlmwrite(strcat('Data/extraction/rightArmEndEffector/negativeAtt/NS3/manip',num2str(manip),'_neg_subjects_good'),neg_subjects_good,'delimiter',' ');
    
end





