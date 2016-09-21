% CartLeftArm data extraction
% Script to extract and find good subjects for CartLeftArm data.
%
% authors: Anthony Voilque & Serena Ivaldi (serena.ivaldi@inria.fr)

function [] = extraction_CartLeftArm(all_subjects)

if(exist('Data/extraction/CartLeftArm')==0)
    mkdir('Data/extraction/CartLeftArm');
end


for i=1:3 % Trial
    
    manip_CLA_good=[];
    
    % Find good subjects for each trial
    for sub=1:length(all_subjects)
        
        missing_data=0;
        T={};
        path_CLA = strcat('Data/dump_manip',num2str(i),'/',num2str(all_subjects(sub)),'/CartLeftArm/data.log');
        
        % Is the data file existing ?
        if(exist(path_CLA)==0)
            disp(strcat('MANIP',num2str(i),': skipping',num2str(all_subjects(sub)), ' - no CartLeftArm file'));
            continue;
        end
        
        % Is the data file empty ?
        if(exist(path_CLA)==2)
            T=textread(strcat('Data/dump_manip',num2str(i),'/',num2str(all_subjects(sub)),'/CartLeftArm/data.log'),'%s','delimiter','\n');
            file_size=size(T,1);
            if(file_size<10)
                disp(strcat('MANIP',num2str(i),': skipping',num2str(all_subjects(sub)),' - CartLeftArm empty file'));
                continue;
            end
            manip_CLA_good = [manip_CLA_good all_subjects(sub)];
        end
        
        
    end
    
    % Extraction
    dlmwrite(strcat('Data/extraction/CartLeftArm/manip',num2str(i),'_CLA_good'),manip_CLA_good,'delimiter',' ');
    
    for sub=1:length(manip_CLA_good)
        CLA=[];
        
        %read data for each subject
        CLA=dlmread(strcat('Data/dump_manip',num2str(i),'/',num2str(manip_CLA_good(sub)),'/CartLeftArm/data.log'));
        posx=CLA(:,3);
        posy=CLA(:,4);
        posz=CLA(:,5);
        quat1=CLA(:,6);
        quat2=CLA(:,7);
        quat3=CLA(:,8);
        quat4=CLA(:,9);
        
        % and order it by subject
        path=strcat('Data/extraction/CartLeftArm/',num2str((manip_CLA_good(sub))));
        
        if(exist(path)==0)
            mkdir('Data/extraction/CartLeftArm/',num2str((manip_CLA_good(sub))));
        end
        
        dlmwrite(strcat('Data/extraction/CartLeftArm/',num2str(manip_CLA_good(sub)),'/posx_manip',num2str(i)),posx,'delimiter',' ')
        dlmwrite(strcat('Data/extraction/CartLeftArm/',num2str(manip_CLA_good(sub)),'/posy_manip',num2str(i)),posy,'delimiter',' ')
        dlmwrite(strcat('Data/extraction/CartLeftArm/',num2str(manip_CLA_good(sub)),'/posz_manip',num2str(i)),posz,'delimiter',' ')
        dlmwrite(strcat('Data/extraction/CartLeftArm/',num2str(manip_CLA_good(sub)),'/quat1_manip',num2str(i)),quat1,'delimiter',' ')
        dlmwrite(strcat('Data/extraction/CartLeftArm/',num2str(manip_CLA_good(sub)),'/quat2_manip',num2str(i)),quat2,'delimiter',' ')
        dlmwrite(strcat('Data/extraction/CartLeftArm/',num2str(manip_CLA_good(sub)),'/quat3_manip',num2str(i)),quat3,'delimiter',' ')
        dlmwrite(strcat('Data/extraction/CartLeftArm/',num2str(manip_CLA_good(sub)),'/quat4_manip',num2str(i)),quat4,'delimiter',' ')

    end
end