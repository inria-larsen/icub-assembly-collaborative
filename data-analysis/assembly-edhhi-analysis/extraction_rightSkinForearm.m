% rightSkinForearm data extraction
% Script to extract and find good subjects for rightSkinForearm data.
%
% authors: Anthony Voilque & Serena Ivaldi (serena.ivaldi@inria.fr)

function [] = extraction_rightSkinForearm(all_subjects)

if(exist('Data/extraction/rightSkinForearm')==0)
    mkdir('Data/extraction/rightSkinForearm');
end


for i=1:3 % Trial
    
    RSF_good.manip{i}=[];
    
    % Find good subjects for each trial
    for sub=1:length(all_subjects)
        
        missing_data=0;
        T={};
        path_RSF = strcat('Data/dump_manip',num2str(i),'/',num2str(all_subjects(sub)),'/skin_right_forearm/data.log');
        
        % Is the data file existing ?
        if(exist(path_RSF)==0)
            disp(strcat('MANIP',num2str(i),': skipping',num2str(all_subjects(sub)), ' - no rightSkinForearm file'));
            continue;
        end
        
        % Is the file empty ?
        if(exist(path_RSF)==2)
            T=textread(strcat('Data/dump_manip',num2str(i),'/',num2str(all_subjects(sub)),'/skin_right_forearm/data.log'),'%s','delimiter','\n');
            file_size=size(T,1);
            
            if(file_size<10)
                disp(strcat('MANIP',num2str(i),': skipping',num2str(all_subjects(sub)),' - rightSkinForearm empty file'));
                continue;
            end
            
            RSF=load(strcat('Data/dump_manip',num2str(i),'/',num2str(all_subjects(sub)),'/skin_right_forearm/data.log'));
            if RSF(1,1)~=-1   % sort normalized ones ((temporary)), not taking account non post processed datas
                continue;
            end
            
            RSF_good.manip{i} = [RSF_good.manip{i} all_subjects(sub)];
        end
        
        dlmwrite(strcat('Data/extraction/rightSkinForearm/manip',num2str(i),'_RSF_good'),RSF_good.manip{i},'delimiter',' ');
        
    end
end

% Extraction
for i=1:3 % Trial
    
    for sub=1:length(RSF_good.manip{i})
        
        RSF=[];
        
        %read sensors data
        RSF=load(strcat('Data/dump_manip',num2str(i),'/',num2str(RSF_good.manip{i}(sub)),'/skin_right_forearm/data.log'));
        
        % Create folder
        path=strcat('Data/extraction/rightSkinForearm/',num2str((RSF_good.manip{i}(sub))));
        if(exist(path)==0)
            mkdir('Data/extraction/rightSkinForearm/',num2str((RSF_good.manip{i}(sub))));
        end
        
        % Mean of sensors value
        m=0;
        mean_pression=[];
        num_active_sensors=[];
        for j=1:size(RSF,1)
            
            c=0;
            for k=3:386 % Count active sensors
                if RSF(j,k)~=0
                    c=c+1;
                end
            end
            
            num_active_sensors=[num_active_sensors; c];
            line_sum=sum(RSF(i,[3:386]));
            
            if c==0
                m=0;
            end
            
            mean_pression=[mean_pression; m];
        end
        
        %         std_mean=std(mean_pression);
        %         std_num_censors=std(num_active_censors);
        
        dlmwrite(strcat('Data/extraction/rightSkinForearm/',num2str(RSF_good.manip{i}(sub)),'/mean_manip',num2str(i)),mean_pression,'delimiter',' ');
        dlmwrite(strcat('Data/extraction/rightSkinForearm/',num2str(RSF_good.manip{i}(sub)),'/num_active_sensors_manip',num2str(i)),num_active_censors,'delimiter',' ');
        %         dlmwrite(strcat('Data/extraction/rightSkinForearm/',num2str(RSF_good.manip{i}(sub)),'/STD_mean_manip',num2str(i)),std_mean,'delimiter','');
        %         dlmwrite(strcat('Data/extraction/rightSkinForearm/',num2str(RSF_good.manip{i}(sub)),'/STD_num_active_sensors_manip',num2str(i)),std_num_censors,'delimiter',' ');
        
        
        % Num of active sensors non post processed
        %     delta=10;
        %     c=0;
        %     i=1;
        %     num_active_censors=[];
        %     for i=1:file_size
        %         j=3;
        %         for j=3:386
        %             if RSF(i,j)<(255-delta)
        %                 c=c+1;
        %             end
        %         end
        %         num_active_censors=[num_active_censors c];
        %     end
        
        
    end
end

