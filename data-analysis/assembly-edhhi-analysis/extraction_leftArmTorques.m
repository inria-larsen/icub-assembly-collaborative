% LeftArmTorques data extraction
% Script to extract and find good subjects for LeftArmTorques data.
%
% authors: Anthony Voilque & Serena Ivaldi (serena.ivaldi@inria.fr)

function [] = extraction_leftArmTorques(all_subjects)

if(exist('Data/extraction/leftArmTorques')==0)
    mkdir('Data/extraction/leftArmTorques');
end


for i=1:3 % Trial
    
    manip_LAT_good=[];
    
    % Find good subjects for each trial
    for sub=1:length(all_subjects)
        
        missing_data=0;
        T={};
        path_LAT = strcat('Data/dump_manip',num2str(i),'/',num2str(all_subjects(sub)),'/leftArmTorques/data.log');
        
        % Is the data file existing ?
        if(exist(path_LAT)==0)
            disp(strcat('MANIP',num2str(i),': skipping',num2str(all_subjects(sub)), ' - no leftArmTorques file'));
            continue;
        end
        
        % Is the data file empty ?
        if(exist(path_LAT)==2)
            T=textread(strcat('Data/dump_manip',num2str(i),'/',num2str(all_subjects(sub)),'/leftArmTorques/data.log'),'%s','delimiter','\n');
            file_size=size(T,1);
            if(file_size<10)
                disp(strcat('MANIP',num2str(i),': skipping',num2str(all_subjects(sub)),' - leftArmTorques empty file'));
                continue;
            end
            manip_LAT_good = [manip_LAT_good all_subjects(sub)];
        end
        
        
    end
    
    % Extraction
    dlmwrite(strcat('Data/extraction/leftArmTorques/manip',num2str(i),'_LAT_good'),manip_LAT_good,'delimiter',' ');
    
    for sub=1:lenth(manip_LAT_good)
        LAT=[];
        
        %read data for each subject
        LAT=dlmread(strcat('Data/dump_manip',num2str(i),'/',num2str(manip_LAT_good(sub)),'/leftArmTorques/data.log'));
        join1=LAT(:,4);
        join2=LAT(:,5);
        join3=LAT(:,6);
        join4=LAT(:,7);
        join5=LAT(:,8);
        join6=LAT(:,9);
        join7=LAT(:,10);
        
        % and order it by subject
        path=strcat('Data/extraction/leftArmTorques/',num2str((manip_LAT_good(sub))));
        
        if(exist(path)==0)
            mkdir('Data/extraction/leftArmTorques/',num2str((manip_LAT_good(sub))));
        end
        
        dlmwrite(strcat('Data/extraction/leftArmTorques/',num2str(manip_LAT_good(sub)),'/join1_manip',num2str(i)),join1,'delimiter',' ')
        dlmwrite(strcat('Data/extraction/leftArmTorques/',num2str(manip_LAT_good(sub)),'/join2_manip',num2str(i)),join2,'delimiter',' ')
        dlmwrite(strcat('Data/extraction/leftArmTorques/',num2str(manip_LAT_good(sub)),'/join3_manip',num2str(i)),join3,'delimiter',' ')
        dlmwrite(strcat('Data/extraction/leftArmTorques/',num2str(manip_LAT_good(sub)),'/join4_manip',num2str(i)),join4,'delimiter',' ')
        dlmwrite(strcat('Data/extraction/leftArmTorques/',num2str(manip_LAT_good(sub)),'/join5_manip',num2str(i)),join5,'delimiter',' ')
        dlmwrite(strcat('Data/extraction/leftArmTorques/',num2str(manip_LAT_good(sub)),'/join6_manip',num2str(i)),join6,'delimiter',' ')
        dlmwrite(strcat('Data/extraction/leftArmTorques/',num2str(manip_LAT_good(sub)),'/join7_manip',num2str(i)),join7,'delimiter',' ')
    end
end
