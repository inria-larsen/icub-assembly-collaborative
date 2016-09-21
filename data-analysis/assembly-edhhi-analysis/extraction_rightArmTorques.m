% RightArmTorques data extraction
% Script to extract and find good subjects for RightArmTorques data.
%
% authors: Anthony Voilque & Serena Ivaldi (serena.ivaldi@inria.fr)

function [] = extraction_rightArmTorques(all_subjects, N_subjects)

if(exist('Data/extraction/rightArmTorques')==0)
    mkdir('Data/extraction/rightArmTorques');
end


for i=1:3 % Trial
    
    manip_RAT_good=[];
    
    % Find good subjects for each trial
    for sub=1:N_subjects
        
        missing_data=0;
        T={};
        path_RAT = strcat('Data/dump_manip',num2str(i),'/',num2str(all_subjects(sub)),'/rightArmTorques/data.log');
        
        % Is the data file existing ?
        if(exist(path_RAT)==0)
            disp(strcat('MANIP',num2str(i),': skipping',num2str(all_subjects(sub)), ' - no rightArmTorques file'));
            continue;
        end
        
        % Is the data file empty ?
        if(exist(path_RAT)==2)
            T=textread(strcat('Data/dump_manip',num2str(i),'/',num2str(all_subjects(sub)),'/rightArmTorques/data.log'),'%s','delimiter','\n');
            file_size=size(T,1);
            if(file_size<10)
                disp(strcat('MANIP',num2str(i),': skipping',num2str(all_subjects(sub)),' - rightArmTorques empty file'));
                continue;
            end
            manip_RAT_good = [manip_RAT_good all_subjects(sub)];
        end
        
        
    end
    
    % Extraction
    dlmwrite(strcat('Data/extraction/rightArmTorques/manip',num2str(i),'_RAT_good'),manip_RAT_good,'delimiter',' ');
    
    for sub=1:length(manip_RAT_good)
        RAT=[];
        
        %read data for each subject
        RAT=dlmread(strcat('Data/dump_manip',num2str(i),'/',num2str(manip_RAT_good(sub)),'/rightArmTorques/data.log'));
        join1=RAT(:,4);
        join2=RAT(:,5);
        join3=RAT(:,6);
        join4=RAT(:,7);
        join5=RAT(:,8);
        join6=RAT(:,9);
        join7=RAT(:,10);
        
        % and order it by subject
        path=strcat('Data/extraction/rightArmTorques/',num2str((manip_RAT_good(sub))));
        
        if(exist(path)==0)
            mkdir('Data/extraction/rightArmTorques/',num2str((manip_RAT_good(sub))));
        end
        
        dlmwrite(strcat('Data/extraction/rightArmTorques/',num2str(manip_RAT_good(sub)),'/join1_manip',num2str(i)),join1,'delimiter',' ')
        dlmwrite(strcat('Data/extraction/rightArmTorques/',num2str(manip_RAT_good(sub)),'/join2_manip',num2str(i)),join2,'delimiter',' ')
        dlmwrite(strcat('Data/extraction/rightArmTorques/',num2str(manip_RAT_good(sub)),'/join3_manip',num2str(i)),join3,'delimiter',' ')
        dlmwrite(strcat('Data/extraction/rightArmTorques/',num2str(manip_RAT_good(sub)),'/join4_manip',num2str(i)),join4,'delimiter',' ')
        dlmwrite(strcat('Data/extraction/rightArmTorques/',num2str(manip_RAT_good(sub)),'/join5_manip',num2str(i)),join5,'delimiter',' ')
        dlmwrite(strcat('Data/extraction/rightArmTorques/',num2str(manip_RAT_good(sub)),'/join6_manip',num2str(i)),join6,'delimiter',' ')
        dlmwrite(strcat('Data/extraction/rightArmTorques/',num2str(manip_RAT_good(sub)),'/join7_manip',num2str(i)),join7,'delimiter',' ')
    end
end
