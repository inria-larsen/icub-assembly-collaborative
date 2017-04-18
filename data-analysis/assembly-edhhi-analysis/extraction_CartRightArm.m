% CartRightArm data extraction
% Script to extract and find good subjects for CartRightArm data.
%
% authors: Anthony Voilque & Serena Ivaldi (serena.ivaldi@inria.fr)

function [] = extraction_CartRightArm(all_subjects)

if(exist('Data/extraction/CartRightArm')==0)
    mkdir('Data/extraction/CartRightArm');
end


for i=1:3 % Trial
    
    manip_CRA_good=[];
    
    % Find good subjects for each trial
    for sub=1:length(all_subjects)
        
        missing_data=0;
        T={};
        path_CRA = strcat('Data/dump_manip',num2str(i),'/',num2str(all_subjects(sub)),'/CartRightArm/data.log');
        
        % Is the data file existing ?
        if(exist(path_CRA)==0)
            disp(strcat('MANIP',num2str(i),': skipping',num2str(all_subjects(sub)), ' - no CartRightArm file'));
            continue;
        end
        
        % Is the data file empty ?
        if(exist(path_CRA)==2)
            T=textread(strcat('Data/dump_manip',num2str(i),'/',num2str(all_subjects(sub)),'/CartRightArm/data.log'),'%s','delimiter','\n');
            file_size=size(T,1);
            if(file_size<10)
                disp(strcat('MANIP',num2str(i),': skipping',num2str(all_subjects(sub)),' - CartRightArm empty file'));
                continue;
            end
            manip_CRA_good = [manip_CRA_good all_subjects(sub)];
        end
        
        
    end
    
    % Extraction
    dlmwrite(strcat('Data/extraction/CartRightArm/manip',num2str(i),'_CRA_good'),manip_CRA_good,'delimiter',' ');
    
    for sub=1:length(manip_CRA_good)
        CRA=[];
        
        %read data for each subject
        CRA=dlmread(strcat('Data/dump_manip',num2str(i),'/',num2str(manip_CRA_good(sub)),'/CartRightArm/data.log'));
        posx=CRA(:,3);
        posy=CRA(:,4);
        posz=CRA(:,5);
        quat1=CLA(:,6);
        quat2=CLA(:,7);
        quat3=CLA(:,8);
        quat4=CLA(:,9);
        
        % and order it by subject
        path=strcat('Data/extraction/CartRightArm/',num2str((manip_CRA_good(sub))));
        
        if(exist(path)==0)
            mkdir('Data/extraction/CartRightArm/',num2str((manip_CRA_good(sub))));
        end
        
        dlmwrite(strcat('Data/extraction/CartRightArm/',num2str(manip_CRA_good(sub)),'/posx_manip',num2str(i)),posx,'delimiter',' ')
        dlmwrite(strcat('Data/extraction/CartRightArm/',num2str(manip_CRA_good(sub)),'/posy_manip',num2str(i)),posy,'delimiter',' ')
        dlmwrite(strcat('Data/extraction/CartRightArm/',num2str(manip_CRA_good(sub)),'/posz_manip',num2str(i)),posz,'delimiter',' ')
        dlmwrite(strcat('Data/extraction/CartLeftArm/',num2str(manip_CRA_good(sub)),'/quat1_manip',num2str(i)),quat1,'delimiter',' ')
        dlmwrite(strcat('Data/extraction/CartLeftArm/',num2str(manip_CRA_good(sub)),'/quat2_manip',num2str(i)),quat2,'delimiter',' ')
        dlmwrite(strcat('Data/extraction/CartLeftArm/',num2str(manip_CRA_good(sub)),'/quat3_manip',num2str(i)),quat3,'delimiter',' ')
        dlmwrite(strcat('Data/extraction/CartLeftArm/',num2str(manip_CRA_good(sub)),'/quat4_manip',num2str(i)),quat4,'delimiter',' ')
        
    end
end