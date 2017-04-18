% RightArmEndEffector data extraction
% Script to extract and find good subjects for RightArmEndEffector data.
%
% authors: Anthony Voilque & Serena Ivaldi (serena.ivaldi@inria.fr)

function [] = extraction_rightArmEndEffector(all_subjects)

if(exist('Data/extraction/rightArmEndEffector')==0)
    mkdir('Data/extraction/rightArmEndEffector');
end


for i=1:3 % Trial
    
    manip_RAEE_good=[];
    
    % Find good subjects for each trial
    for sub=1:length(all_subjects)
        
        missing_data=0;
        T={};
        path_RAEE = strcat('Data/dump_manip',num2str(i),'/',num2str(all_subjects(sub)),'/rightArmEndEffector/data.log');
        
        % Is the data file existing ?
        if(exist(path_RAEE)==0)
            disp(strcat('MANIP',num2str(i),': skipping',num2str(all_subjects(sub)), ' - no rightArmEndEffector file'));
            continue;
        end
        
        % Is the data file empty ?
        if(exist(path_RAEE)==2)
            T=textread(strcat('Data/dump_manip',num2str(i),'/',num2str(all_subjects(sub)),'/rightArmEndEffector/data.log'),'%s','delimiter','\n');
            file_size=size(T,1);
            if(file_size<10)
                disp(strcat('MANIP',num2str(i),': skipping',num2str(all_subjects(sub)),' - rightArmEndEffector empty file'));
                continue;
            end
            manip_RAEE_good = [manip_RAEE_good all_subjects(sub)];
        end
        
        
    end
    
    % Extraction
    dlmwrite(strcat('Data/extraction/rightArmEndEffector/manip',num2str(i),'_RAEE_good'),manip_RAEE_good,'delimiter',' ');
    
    for sub=1:length(manip_RAEE_good)
        RAEE=[];
        
        %read data for each subject
        RAEE=dlmread(strcat('Data/dump_manip',num2str(i),'/',num2str(manip_RAEE_good(sub)),'/rightArmEndEffector/data.log'));
        fx=RAEE(:,3);
        fy=RAEE(:,4);
        fz=RAEE(:,5);
        force=sqrt(RAEE(:,3).^2+RAEE(:,4).^2+RAEE(:,5).^2);
        tx=RAEE(:,6);
        ty=RAEE(:,7);
        tz=RAEE(:,8);
        torque=sqrt(RAEE(:,6).^2+RAEE(:,7).^2+RAEE(:,8).^2);
        
        % and order it by subject
        path=strcat('Data/extraction/rightArmEndEffector/',num2str((manip_RAEE_good(sub))));
        
        if(exist(path)==0)
            mkdir('Data/extraction/rightArmEndEffector/',num2str((manip_RAEE_good(sub))));
        end
        
        dlmwrite(strcat('Data/extraction/rightArmEndEffector/',num2str(manip_RAEE_good(sub)),'/fx_manip',num2str(i)),fx,'delimiter',' ')
        dlmwrite(strcat('Data/extraction/rightArmEndEffector/',num2str(manip_RAEE_good(sub)),'/fy_manip',num2str(i)),fy,'delimiter',' ')
        dlmwrite(strcat('Data/extraction/rightArmEndEffector/',num2str(manip_RAEE_good(sub)),'/fz_manip',num2str(i)),fz,'delimiter',' ')
        dlmwrite(strcat('Data/extraction/rightArmEndEffector/',num2str(manip_RAEE_good(sub)),'/force_manip',num2str(i)),force,'delimiter',' ')
        
        dlmwrite(strcat('Data/extraction/rightArmEndEffector/',num2str(manip_RAEE_good(sub)),'/tx_manip',num2str(i)),tx,'delimiter',' ')
        dlmwrite(strcat('Data/extraction/rightArmEndEffector/',num2str(manip_RAEE_good(sub)),'/ty_manip',num2str(i)),ty,'delimiter',' ')
        dlmwrite(strcat('Data/extraction/rightArmEndEffector/',num2str(manip_RAEE_good(sub)),'/tz_manip',num2str(i)),tz,'delimiter',' ')
        dlmwrite(strcat('Data/extraction/rightArmEndEffector/',num2str(manip_RAEE_good(sub)),'/torque_manip',num2str(i)),torque,'delimiter',' ')
        
    end
end
