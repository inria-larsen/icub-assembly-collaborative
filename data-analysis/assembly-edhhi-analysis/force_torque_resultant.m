function []=force_torque_resultant()

% LEFT

manip=1;
for manip=1:3
    
    good_subjects=load(strcat('Data/extraction/leftArmEndEffector/manip',num2str(manip),'_LAEE_good'));
    N_sub=length(good_subjects);
    
    sub=1;
    for sub=1:N_sub
        
        % Forces resultant
        fx=load(strcat('Data/extraction/leftArmEndEffector/',num2str(good_subjects(sub)),'/fx_manip',num2str(manip)));
        fy=load(strcat('Data/extraction/leftArmEndEffector/',num2str(good_subjects(sub)),'/fy_manip',num2str(manip)));
        fz=load(strcat('Data/extraction/leftArmEndEffector/',num2str(good_subjects(sub)),'/fz_manip',num2str(manip)));
        
        size=length(fx);
        
        i=1;
        for i=1:size
            force(i,1)=sqrt(fx(i,1)^2+fy(i,1)^2+fz(i,1)^2);
        end
        
        dlmwrite(strcat('Data/extraction/leftArmEndEffector/',num2str(good_subjects(sub)),'/force_manip',num2str(manip)),force,'delimiter',' ');

        
        % Torques resultant
        % Forces resultant
        mx=load(strcat('Data/extraction/leftArmEndEffector/',num2str(good_subjects(sub)),'/mx_manip',num2str(manip)));
        my=load(strcat('Data/extraction/leftArmEndEffector/',num2str(good_subjects(sub)),'/my_manip',num2str(manip)));
        mz=load(strcat('Data/extraction/leftArmEndEffector/',num2str(good_subjects(sub)),'/mz_manip',num2str(manip)));
        
        size=length(fx);
        
        i=1;
        for i=1:size
            torque(i,1)=sqrt(mx(i,1)^2+my(i,1)^2+mz(i,1)^2);
        end
        
        dlmwrite(strcat('Data/extraction/leftArmEndEffector/',num2str(good_subjects(sub)),'/torque_manip',num2str(manip)),torque,'delimiter',' ');
        
    end
end





% RIGHT

manip=1;
for manip=1:3
    
    good_subjects=load(strcat('Data/extraction/rightArmEndEffector/manip',num2str(manip),'_RAEE_good'));
    N_sub=length(good_subjects);
    
    sub=1;
    for sub=1:N_sub
        
        % Forces resultant
        fx=load(strcat('Data/extraction/rightArmEndEffector/',num2str(good_subjects(sub)),'/fx_manip',num2str(manip)));
        fy=load(strcat('Data/extraction/rightArmEndEffector/',num2str(good_subjects(sub)),'/fy_manip',num2str(manip)));
        fz=load(strcat('Data/extraction/rightArmEndEffector/',num2str(good_subjects(sub)),'/fz_manip',num2str(manip)));
        
        size=length(fx);
        
        i=1;
        for i=1:size
            force(i,1)=sqrt(fx(i,1)^2+fy(i,1)^2+fz(i,1)^2);
        end
        
        dlmwrite(strcat('Data/extraction/rightArmEndEffector/',num2str(good_subjects(sub)),'/force_manip',num2str(manip)),force,'delimiter',' ');

        
        % Torques resultant
        % Forces resultant
        mx=load(strcat('Data/extraction/rightArmEndEffector/',num2str(good_subjects(sub)),'/mx_manip',num2str(manip)));
        my=load(strcat('Data/extraction/rightArmEndEffector/',num2str(good_subjects(sub)),'/my_manip',num2str(manip)));
        mz=load(strcat('Data/extraction/rightArmEndEffector/',num2str(good_subjects(sub)),'/mz_manip',num2str(manip)));
        
        size=length(fx);
        
        i=1;
        for i=1:size
            torque(i,1)=sqrt(mx(i,1)^2+my(i,1)^2+mz(i,1)^2);
        end
        
        dlmwrite(strcat('Data/extraction/rightArmEndEffector/',num2str(good_subjects(sub)),'/torque_manip',num2str(manip)),torque,'delimiter',' ');
        
    end
end



