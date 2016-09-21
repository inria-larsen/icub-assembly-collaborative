%% Gender differences
% Script to generate boxplots between end effector force
% and gender of participants, across the three trials of collaborative
% assembly with iCub.
%
% authors: Anthony Voilque & Serena Ivaldi (serena.ivaldi@inria.fr)

clear all
close all
clc

% Sorting
% Create vectors with good subjects for each gender
%     0 for female    ,    1 for male
% gender{1} for female, gender{2} for male

for i=1:3  % Manipulation
    
    %%% Left
    gender_sub=load(strcat('Data/extraction/leftArmEndEffector/gender/manip',num2str(i),'_gender_subjects_good'));
    N_gender_sub=length(gender_sub);
    
        % Gender categories
        left.manip{i}.gender{1}=[];
        left.manip{i}.gender{2}=[];    
        
        for sub=1:N_gender_sub
            
            if gender_sub(sub,2)==0;
                left.manip{i}.gender{1}=[left.manip{i}.gender{1}; gender_sub(sub,1)];
            end
            if gender_sub(sub,2)==1;
                left.manip{i}.gender{2}=[left.manip{i}.gender{2}; gender_sub(sub,1)];
            end
            
                
        end
        
    %%% Right
    gender_sub=load(strcat('Data/extraction/rightArmEndEffector/gender/manip',num2str(i),'_gender_subjects_good'));
    N_gender_sub=length(gender_sub);
    
        % Gender categories
        right.manip{i}.gender{1}=[];
        right.manip{i}.gender{2}=[];    
        
        for sub=1:N_gender_sub
            
            if gender_sub(sub,2)==0;
                right.manip{i}.gender{1}=[right.manip{i}.gender{1}; gender_sub(sub,1)];
            end   
            if gender_sub(sub,2)==1;
                right.manip{i}.gender{2}=[right.manip{i}.gender{2}; gender_sub(sub,1)];
            end
            
                
        end
end






%% Gender differences per manip

%%% Left

for i=1:3  % Manipulation
    left.manip{i}.gender_indices=[];
    left.manip{i}.gender_force_max=[];
    left.manip{i}.gender_force_median=[];
    left.manip{i}.gender_force_mean=[];
    left.manip{i}.gender_moment_max=[];
    left.manip{i}.gender_moment_median=[];
    left.manip{i}.gender_moment_mean=[];
    
    for g=1:2  % Gender
        
        for sub=1:length(left.manip{i}.gender{g})
            
            % Indices matrix
            left.manip{i}.gender_indices=[left.manip{i}.gender_indices; num2str(g)];
            
            % FORCES
            mat=[];
            mat=load(strcat('Data/extraction/leftArmEndEffector/',num2str(left.manip{i}.gender{g}(sub)),'/force_manip',num2str(i)));
            
                % Max forces
            max_mat=max(mat);
            left.manip{i}.gender_force_max=[left.manip{i}.gender_force_max; max_mat];
            
                % Median forces
            median_mat=median(mat);
            left.manip{i}.gender_force_median=[left.manip{i}.gender_force_median; median_mat];
            
                % Mean forces
            mean_mat=mean(mat);
            left.manip{i}.gender_force_mean=[left.manip{i}.gender_force_mean; mean_mat];
            
            % MOMENT
            mat=[];
            mat=load(strcat('Data/extraction/leftArmEndEffector/',num2str(left.manip{i}.gender{g}(sub)),'/torque_manip',num2str(i)));
            
                % Max torques
            max_mat=max(mat);
            left.manip{i}.gender_moment_max=[left.manip{i}.gender_moment_max; max_mat];
            
                % Median torques
            median_mat=median(mat);
            left.manip{i}.gender_moment_median=[left.manip{i}.gender_moment_median; median_mat];
            
                % Mean torques
            mean_mat=mean(mat);
            left.manip{i}.gender_moment_mean=[left.manip{i}.gender_moment_mean; mean_mat];
            
                        
        end
      
    end
end



%%% Right

for i=1:3  % Manipulation
    right.manip{i}.gender_indices=[];
    right.manip{i}.gender_force_max=[];
    right.manip{i}.gender_force_median=[];
    right.manip{i}.gender_force_mean=[];
    right.manip{i}.gender_moment_max=[];
    right.manip{i}.gender_moment_median=[];
    right.manip{i}.gender_moment_mean=[];
    
    for g=1:2  % Gender
        
        for sub=1:length(right.manip{i}.gender{g})
            
            % Indices matrix
            right.manip{i}.gender_indices=[right.manip{i}.gender_indices; num2str(g)];
            
            % FORCES
            mat=[];
            mat=load(strcat('Data/extraction/rightArmEndEffector/',num2str(right.manip{i}.gender{g}(sub)),'/force_manip',num2str(i)));
            
                % Max forces
            max_mat=max(mat);
            right.manip{i}.gender_force_max=[right.manip{i}.gender_force_max; max_mat];
            
                % Median forces
            median_mat=median(mat);
            right.manip{i}.gender_force_median=[right.manip{i}.gender_force_median; median_mat];
            
                % Mean forces
            mean_mat=mean(mat);
            right.manip{i}.gender_force_mean=[right.manip{i}.gender_force_mean; mean_mat];
            
            % MOMENT
            mat=[];
            mat=load(strcat('Data/extraction/rightArmEndEffector/',num2str(right.manip{i}.gender{g}(sub)),'/torque_manip',num2str(i)));
            
                % Max torques
            max_mat=max(mat);
            right.manip{i}.gender_moment_max=[right.manip{i}.gender_moment_max; max_mat];
            
                % Median torques
            median_mat=median(mat);
            right.manip{i}.gender_moment_median=[right.manip{i}.gender_moment_median; median_mat];
            
                % Mean torques
            mean_mat=mean(mat);
            right.manip{i}.gender_moment_mean=[right.manip{i}.gender_moment_mean; mean_mat];
            
                        
        end
      
    end
end



%% Manipulation differences per gender

%%% Left

for g=1:2  % Gender
    left.gender{g}.gender_indices=[];
    left.gender{g}.gender_force_max=[];
    left.gender{g}.gender_force_median=[];
    left.gender{g}.gender_force_mean=[];
    left.gender{g}.gender_moment_max=[];
    left.gender{g}.gender_moment_median=[];
    left.gender{g}.gender_moment_mean=[];
    
    for i=1:3  % Manipulation
        
        for sub=1:length(left.manip{i}.gender{g})
            
            % Indices matrix
            left.gender{g}.gender_indices=[left.gender{g}.gender_indices; num2str(i)];
            
            % FORCES
            mat=[];
            mat=load(strcat('Data/extraction/leftArmEndEffector/',num2str(left.manip{i}.gender{g}(sub)),'/force_manip',num2str(i)));
            
                % Max forces
            max_mat=max(mat);
            left.gender{g}.gender_force_max=[left.gender{g}.gender_force_max; max_mat];
            
                % Median forces
            median_mat=median(mat);
            left.gender{g}.gender_force_median=[left.gender{g}.gender_force_median; median_mat];
            
                % Mean forces
            mean_mat=mean(mat);
            left.gender{g}.gender_force_mean=[left.gender{g}.gender_force_mean; mean_mat];
            
            % MOMENT
            mat=[];
            mat=load(strcat('Data/extraction/leftArmEndEffector/',num2str(left.manip{i}.gender{g}(sub)),'/torque_manip',num2str(i)));
            
                % Max torques
            max_mat=max(mat);
            left.gender{g}.gender_moment_max=[left.gender{g}.gender_moment_max; max_mat];
            
                % Median torques
            median_mat=median(mat);
            left.gender{g}.gender_moment_median=[left.gender{g}.gender_moment_median; median_mat];
            
                % Mean torques
            mean_mat=mean(mat);
            left.gender{g}.gender_moment_mean=[left.gender{g}.gender_moment_mean; mean_mat];
            
                        
        end
      
    end
end



%%% Right

for g=1:2  % Gender
    right.gender{g}.gender_indices=[];
    right.gender{g}.gender_force_max=[];
    right.gender{g}.gender_force_median=[];
    right.gender{g}.gender_force_mean=[];
    right.gender{g}.gender_moment_max=[];
    right.gender{g}.gender_moment_median=[];
    right.gender{g}.gender_moment_mean=[];
    
    for i=1:3  % Gender
        
        for sub=1:length(right.manip{i}.gender{g})
            
            % Indices matrix
            right.gender{g}.gender_indices=[right.gender{g}.gender_indices; num2str(i)];
            
            % FORCES
            mat=[];
            mat=load(strcat('Data/extraction/rightArmEndEffector/',num2str(right.manip{i}.gender{g}(sub)),'/force_manip',num2str(i)));
            
                % Max forces
            max_mat=max(mat);
            right.gender{g}.gender_force_max=[right.gender{g}.gender_force_max; max_mat];
            
                % Median forces
            median_mat=median(mat);
            right.gender{g}.gender_force_median=[right.gender{g}.gender_force_median; median_mat];
            
                % Mean forces
            mean_mat=mean(mat);
            right.gender{g}.gender_force_mean=[right.gender{g}.gender_force_mean; mean_mat];
            
            % MOMENT
            mat=[];
            mat=load(strcat('Data/extraction/rightArmEndEffector/',num2str(right.manip{i}.gender{g}(sub)),'/torque_manip',num2str(i)));
            
                % Max torques
            max_mat=max(mat);
            right.gender{g}.gender_moment_max=[right.gender{g}.gender_moment_max; max_mat];
            
                % Median torques
            median_mat=median(mat);
            right.gender{g}.gender_moment_median=[right.gender{g}.gender_moment_median; median_mat];
            
                % Mean torques
            mean_mat=mean(mat);
            right.gender{g}.gender_moment_mean=[right.gender{g}.gender_moment_mean; mean_mat];
            
                        
        end
      
    end
end






%% BOXPLOT
%%% Gender differences per manip

for i=1:3  % Manipulation
    
    % LEFT
    
    % max
    figure(1)
    subplot(1,3,i)
    boxplot(left.manip{i}.gender_force_max,left.manip{i}.gender_indices);
    xlabel('Female        Male')
    ylabel('Fmax per subject')
    title(strcat('Trial ',num2str(i)))
    saveas(gcf,'Data/results/boxplot/gender/leftArm_trial_forceMax.png');
    
    % median
    figure(2)
    subplot(1,3,i)
    boxplot(left.manip{i}.gender_force_median,left.manip{i}.gender_indices);
    xlabel('Female        Male')
    ylabel('Fmedian per subject')
    title(strcat('Trial ',num2str(i)))
    saveas(gcf,'Data/results/boxplot/gender/leftArm_trial_forceMedian.png');
    
    % mean
    figure(3)
    subplot(1,3,i)
    boxplot(left.manip{i}.gender_force_mean,left.manip{i}.gender_indices);
    xlabel('Female        Male')
    ylabel('Fmean per subject')
    title(strcat('Trial ',num2str(i)))
    saveas(gcf,'Data/results/boxplot/gender/leftArm_trial_forceMean.png');
   
    
    
    % RIGHT
    
    % max
    figure(4)
    subplot(1,3,i)
    boxplot(right.manip{i}.gender_force_max,right.manip{i}.gender_indices);
    xlabel('Female        Male')
    ylabel('Fmax per subject')
    title(strcat('Trial ',num2str(i)))
    saveas(gcf,'Data/results/boxplot/gender/rightArm_trial_forceMax.png');
    
    % median
    figure(5)
    subplot(1,3,i)
    boxplot(right.manip{i}.gender_force_median,right.manip{i}.gender_indices);
    xlabel('Female        Male')
    ylabel('Fmedian per subject')
    title(strcat('Trial ',num2str(i)))
    saveas(gcf,'Data/results/boxplot/gender/rightArm_trial_forceMedian.png');
    
    % mean
    figure(6)
    subplot(1,3,i)
    boxplot(right.manip{i}.gender_force_mean,right.manip{i}.gender_indices);
    xlabel('Female        Male')
    ylabel('Fmean per subject')
    title(strcat('Trial ',num2str(i)))
    saveas(gcf,'Data/results/boxplot/gender/rightArm_trial_forceMean.png');
    
    
end






%% BOXPLOT
%%% Manip differences per gender

for g=1:2  % Gender
    
    % LEFT
    
    % max
    figure(7)
    subplot(1,2,g)
    boxplot(left.gender{g}.gender_force_max,left.gender{g}.gender_indices);
    xlabel('Trial')
    ylabel('Fmax per subject')
    title(strcat('Gender ',num2str(g)))
    saveas(gcf,'Data/results/boxplot/gender/leftArm_cat_forceMax.png');
    
    % median
    figure(8)
    subplot(1,2,g)
    boxplot(left.gender{g}.gender_force_median,left.gender{g}.gender_indices);
    xlabel('Trial')
    ylabel('Fmedian per subject')
    title(strcat('Gender ',num2str(g)))
    saveas(gcf,'Data/results/boxplot/gender/leftArm_cat_forceMedian.png');
    
    % mean
    figure(9)
    subplot(1,2,g)
    boxplot(left.gender{g}.gender_force_mean,left.gender{g}.gender_indices);
    xlabel('Trial')
    ylabel('Fmean per subject')
    title(strcat('Gender ',num2str(g)))
    saveas(gcf,'Data/results/boxplot/gender/leftArm_cat_forceMean.png');
   
    
    
    % RIGHT
    
    % max
    figure(10)
    subplot(1,2,g)
    boxplot(right.gender{g}.gender_force_max,right.gender{g}.gender_indices);
    xlabel('Trial')
    ylabel('Fmax per subject')
    title(strcat('Gender ',num2str(g)))
    saveas(gcf,'Data/results/boxplot/gender/rightArm_cat_forceMax.png');
    
    % median
    figure(11)
    subplot(1,2,g)
    boxplot(right.gender{g}.gender_force_median,right.gender{g}.gender_indices);
    xlabel('Trial')
    ylabel('Fmedian per subject')
    title(strcat('Gender ',num2str(g)))
    saveas(gcf,'Data/results/boxplot/gender/rightArm_cat_forceMedian.png');
    
    % mean
    figure(12)
    subplot(1,2,g)
    boxplot(right.gender{g}.gender_force_mean,right.gender{g}.gender_indices);
    xlabel('Trial')
    ylabel('Fmean per subject')
    title(strcat('Gender ',num2str(g)))
    saveas(gcf,'Data/results/boxplot/gender/rightArm_cat_forceMean.png');
    
    
end

