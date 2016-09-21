% function []=time_manipulation()

%% Manipulation time
m=0
manip=1;
for manip=1:3
    
    % Left arm
    duration_subject=[];
    good_subjects=load(strcat('Data/extraction/leftArmEndEffector/manip',num2str(manip),'_LAEE_good'));
    N_sub=length(good_subjects);
    
    data=[];
    sub=1;
    for sub=1:N_sub
        data=load(strcat('Data/extraction/leftArmEndEffector/post_process/',num2str(good_subjects(sub)),'/pp_fx_manip',num2str(manip)));
        time_fx=length(data)*0.01;
        data=[];
        data=load(strcat('Data/extraction/leftArmEndEffector/post_process/',num2str(good_subjects(sub)),'/pp_fy_manip',num2str(manip)));
        time_fy=length(data)*0.01;
        data=[];
        data=load(strcat('Data/extraction/leftArmEndEffector/post_process/',num2str(good_subjects(sub)),'/pp_fz_manip',num2str(manip)));
        time_fz=length(data)*0.01;
        data=[];
        data=load(strcat('Data/extraction/leftArmEndEffector/post_process/',num2str(good_subjects(sub)),'/pp_mx_manip',num2str(manip)));
        time_mx=length(data)*0.01;
        data=[];
        data=load(strcat('Data/extraction/leftArmEndEffector/post_process/',num2str(good_subjects(sub)),'/pp_my_manip',num2str(manip)));
        time_my=length(data)*0.01;
        data=[];
        data=load(strcat('Data/extraction/leftArmEndEffector/post_process/',num2str(good_subjects(sub)),'/pp_mz_manip',num2str(manip)));
        time_mz=length(data)*0.01;
  
        
        % Mean
    mean_time=(time_fx+time_fy+time_fz+time_mx+time_my+time_mz)/6;
    dlmwrite(strcat('Data/extraction/leftArmEndEffector/post_process/',num2str(good_subjects(sub)),'/time_manip',num2str(manip)),mean_time);
    
    duration_subject=[duration_subject mean_time];
    
    end
    
    dlmwrite(strcat('Data/extraction/leftArmEndEffector/post_process/duration_subject_manip',num2str(manip)),duration_subject);
    
        
    
    
    
     % Right arm
    duration_subject=[];
    good_subjects=load(strcat('Data/extraction/rightArmEndEffector/manip',num2str(manip),'_RAEE_good'));
    N_sub=length(good_subjects);
    
    data=[];
    sub=1;
    for sub=1:N_sub
        data=load(strcat('Data/extraction/rightArmEndEffector/post_process/',num2str(good_subjects(sub)),'/pp_fx_manip',num2str(manip)));
        time_fx=length(data)*0.01;
        data=[];
        data=load(strcat('Data/extraction/rightArmEndEffector/post_process/',num2str(good_subjects(sub)),'/pp_fy_manip',num2str(manip)));
        time_fy=length(data)*0.01;
        data=[];
        data=load(strcat('Data/extraction/rightArmEndEffector/post_process/',num2str(good_subjects(sub)),'/pp_fz_manip',num2str(manip)));
        time_fz=length(data)*0.01;
        data=[];
        data=load(strcat('Data/extraction/rightArmEndEffector/post_process/',num2str(good_subjects(sub)),'/pp_mx_manip',num2str(manip)));
        time_mx=length(data)*0.01;
        data=[];
        data=load(strcat('Data/extraction/rightArmEndEffector/post_process/',num2str(good_subjects(sub)),'/pp_my_manip',num2str(manip)));
        time_my=length(data)*0.01;
        data=[];
        data=load(strcat('Data/extraction/rightArmEndEffector/post_process/',num2str(good_subjects(sub)),'/pp_mz_manip',num2str(manip)));
        time_mz=length(data)*0.01;
        
        % Mean
    mean_time=(time_fx+time_fy+time_fz+time_mx+time_my+time_mz)/6;
    dlmwrite(strcat('Data/extraction/rightArmEndEffector/post_process/',num2str(good_subjects(sub)),'/time_manip',num2str(manip)),mean_time);
    
    duration_subject=[duration_subject mean_time];
    
    end
    
   dlmwrite(strcat('Data/extraction/rightArmEndEffector/post_process/duration_subject_manip',num2str(manip)),duration_subject);
    
      
end
       
        
        
        
        