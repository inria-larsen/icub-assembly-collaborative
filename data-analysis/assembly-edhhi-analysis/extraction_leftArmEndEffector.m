% LeftArmEndEffector data extraction
% Script to extract and find good subjects for LeftArmEndEffector data.
%
% authors: Anthony Voilque & Serena Ivaldi (serena.ivaldi@inria.fr)

%function [] = extraction_leftArmEndEffector(all_subjects)

if(exist('Data/extraction/leftArmEndEffector')==0)
    mkdir('Data/extraction/leftArmEndEffector');
end


for i=1:3 % Trial
    
    manip_LAEE_good=[];
    
    % Find good subjects for each trial
    for sub=1:length(all_subjects)
        
        missing_data=0;
        T={};
        path_LAEE = strcat('Data/dump_manip',num2str(i),'/',num2str(all_subjects(sub)),'/leftArmEndEffector/data.log');
        
        % Is the data file existing ?
        if(exist(path_LAEE)==0)
            disp(strcat('MANIP',num2str(i),': skipping',num2str(all_subjects(sub)), ' - no leftArmEndEffector file'));
            continue;
        end
        
        % Is the data file empty ?
        if(exist(path_LAEE)==2)
            T=textread(strcat('Data/dump_manip',num2str(i),'/',num2str(all_subjects(sub)),'/leftArmEndEffector/data.log'),'%s','delimiter','\n');
            file_size=size(T,1);
            if(file_size<10)
                disp(strcat('MANIP',num2str(i),': skipping',num2str(all_subjects(sub)),' - leftArmEndEffector empty file'));
                continue;
            end
            manip_LAEE_good = [manip_LAEE_good all_subjects(sub)];
        end
        
        
    end
    
    % Extraction
    dlmwrite(strcat('Data/extraction/leftArmEndEffector/manip',num2str(i),'_LAEE_good'),manip_LAEE_good,'delimiter',' ');
    
    for sub=1:length(manip_LAEE_good)
        LAEE=[];
        
        %read data for each subject
        LAEE=dlmread(strcat('Data/dump_manip',num2str(i),'/',num2str(manip_LAEE_good(sub)),'/leftArmEndEffector/data.log'));
        fx=LAEE(:,3);
        fy=LAEE(:,4);
        fz=LAEE(:,5);
        force=sqrt(LAEE(:,3).^2+LAEE(:,4).^2+LAEE(:,5).^2);
        
        tx=LAEE(:,6);
        ty=LAEE(:,7);
        tz=LAEE(:,8);
        torque=sqrt(LAEE(:,6).^2+LAEE(:,7).^2+LAEE(:,8).^2);
        
        % and order it by subject
        path=strcat('Data/extraction/leftArmEndEffector/',num2str((manip_LAEE_good(sub))));
        
        if(exist(path)==0)
            mkdir('Data/extraction/leftArmEndEffector/',num2str((manip_LAEE_good(sub))));
        end
        
        dlmwrite(strcat('Data/extraction/leftArmEndEffector/',num2str(manip_LAEE_good(sub)),'/fx_manip',num2str(i)),fx,'delimiter',' ')
        dlmwrite(strcat('Data/extraction/leftArmEndEffector/',num2str(manip_LAEE_good(sub)),'/fy_manip',num2str(i)),fy,'delimiter',' ')
        dlmwrite(strcat('Data/extraction/leftArmEndEffector/',num2str(manip_LAEE_good(sub)),'/fz_manip',num2str(i)),fz,'delimiter',' ')
        dlmwrite(strcat('Data/extraction/leftArmEndEffector/',num2str(manip_LAEE_good(sub)),'/force_manip',num2str(i)),force,'delimiter',' ')
        
        dlmwrite(strcat('Data/extraction/leftArmEndEffector/',num2str(manip_LAEE_good(sub)),'/tx_manip',num2str(i)),tx,'delimiter',' ')
        dlmwrite(strcat('Data/extraction/leftArmEndEffector/',num2str(manip_LAEE_good(sub)),'/ty_manip',num2str(i)),ty,'delimiter',' ')
        dlmwrite(strcat('Data/extraction/leftArmEndEffector/',num2str(manip_LAEE_good(sub)),'/tz_manip',num2str(i)),tz,'delimiter',' ')
        dlmwrite(strcat('Data/extraction/leftArmEndEffector/',num2str(manip_LAEE_good(sub)),'/torque_manip',num2str(i)),torque,'delimiter',' ')
        
    end
end
