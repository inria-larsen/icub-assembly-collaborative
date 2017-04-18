%% Extroversion differences
% Script to generate boxplots between end effector force
% and extroversion of participants, across the three trials of collaborative
% assembly with iCub.
%
% authors: Anthony Voilque & Serena Ivaldi (serena.ivaldi@inria.fr)

clear all
close all
clc

% Limits
% l0-l1   (l1+1)-l3   (l3+1)
% 0-101   102 - 122    123+
l1=101;
l3=122;

% Sorting
% Create vectors with good subjects for each categorie

for i=1:3
    
    %%% Left
    extro_sub=load(strcat('Data/extraction/leftArmEndEffector/extroversion/manip',num2str(i),'_extro_subjects_good'));
    N_extro_sub=length(extro_sub);
    
        % extro categories
        left.manip{i}.extro{1}=[];
        left.manip{i}.extro{2}=[];
        left.manip{i}.extro{3}=[];      
        
        for sub=1:N_extro_sub
               
            if extro_sub(sub,2)<=l1;
                left.manip{i}.extro{1}=[left.manip{i}.extro{1}; extro_sub(sub,1)];
            end
            if (extro_sub(sub,2)>l1) && (extro_sub(sub,2))<=l3;
                left.manip{i}.extro{2}=[left.manip{i}.extro{1}; extro_sub(sub,1)];
            end
            if extro_sub(sub,2)>l3;
                left.manip{i}.extro{3}=[left.manip{i}.extro{3}; extro_sub(sub,1)];
            end
                
        end
        
        
 
    %%% Right
    extro_sub=load(strcat('Data/extraction/rightArmEndEffector/extroversion/manip',num2str(i),'_extro_subjects_good'));
    N_extro_sub=length(extro_sub);
    
        % extro categories
        right.manip{i}.extro{1}=[];
        right.manip{i}.extro{2}=[];
        right.manip{i}.extro{3}=[];
       
        
        for sub=1:N_extro_sub
            
            if extro_sub(sub,2)<=l1;
                right.manip{i}.extro{1}=[right.manip{i}.extro{1}; extro_sub(sub,1)];
            end
            if (extro_sub(sub,2)>l1) && (extro_sub(sub,2))<=l3;
                right.manip{i}.extro{2}=[right.manip{i}.extro{2}; extro_sub(sub,1)];
            end
            if extro_sub(sub,2)>l3;
                right.manip{i}.extro{3}=[right.manip{i}.extro{3}; extro_sub(sub,1)];
            end
        end

end



%% Extroversion differences per manip

%%% Left

for i=1:3
    left.manip{i}.extro_indices=[];
    left.manip{i}.extro_force_max=[];
    left.manip{i}.extro_force_median=[];
    left.manip{i}.extro_force_mean=[];
    left.manip{i}.extro_moment_max=[];
    left.manip{i}.extro_moment_median=[];
    left.manip{i}.extro_moment_mean=[];
    
    for cat=1:3  % Categories
        
        for sub=1:length(left.manip{i}.extro{cat})
            
            % Indices matrix
            left.manip{i}.extro_indices=[left.manip{i}.extro_indices; num2str(cat)];
            
            % FORCES
            mat=[];
            mat=load(strcat('Data/extraction/leftArmEndEffector/',num2str(left.manip{i}.extro{cat}(sub)),'/force_manip',num2str(i)));
            
                % Max forces
            max_mat=max(mat);
            left.manip{i}.extro_force_max=[left.manip{i}.extro_force_max; max_mat];
            
                % Median forces
            median_mat=median(mat);
            left.manip{i}.extro_force_median=[left.manip{i}.extro_force_median; median_mat];
            
                % Mean forces
            mean_mat=mean(mat);
            left.manip{i}.extro_force_mean=[left.manip{i}.extro_force_mean; mean_mat];
            
            % MOMENT
            mat=[];
            mat=load(strcat('Data/extraction/leftArmEndEffector/',num2str(left.manip{i}.extro{cat}(sub)),'/torque_manip',num2str(i)));
            
                % Max torques
            max_mat=max(mat);
            left.manip{i}.extro_moment_max=[left.manip{i}.extro_moment_max; max_mat];
            
                % Median torques
            median_mat=median(mat);
            left.manip{i}.extro_moment_median=[left.manip{i}.extro_moment_median; median_mat];
            
                % Mean torques
            mean_mat=mean(mat);
            left.manip{i}.extro_moment_mean=[left.manip{i}.extro_moment_mean; mean_mat];
            
                        
        end
      
    end
end
    

%%% Right

for i=1:3
    right.manip{i}.extro_indices=[];
    right.manip{i}.extro_force_max=[];
    right.manip{i}.extro_force_median=[];
    right.manip{i}.extro_force_mean=[];
    right.manip{i}.extro_moment_max=[];
    right.manip{i}.extro_moment_median=[];
    right.manip{i}.extro_moment_mean=[];
    
    for cat=1:3  % Categories
        
        for sub=1:length(right.manip{i}.extro{cat})
            
            % Indices matrix 
            right.manip{i}.extro_indices=[right.manip{i}.extro_indices; num2str(cat)];
            
            % FORCES
            mat=[];
            mat=load(strcat('Data/extraction/rightArmEndEffector/',num2str(right.manip{i}.extro{cat}(sub)),'/force_manip',num2str(i)));
            
            % Max forces
            max_mat=max(mat);
            right.manip{i}.extro_force_max=[right.manip{i}.extro_force_max; max_mat];
            
            % Median forces
            median_mat=median(mat);
            right.manip{i}.extro_force_median=[right.manip{i}.extro_force_median; median_mat];
            
            % Mean forces
            mean_mat=mean(mat);
            right.manip{i}.extro_force_mean=[right.manip{i}.extro_force_mean; mean_mat];
            
            % MOMENT
            mat=[];
            mat=load(strcat('Data/extraction/rightArmEndEffector/',num2str(right.manip{i}.extro{cat}(sub)),'/torque_manip',num2str(i)));
            
                % Max torques
            max_mat=max(mat);
            right.manip{i}.extro_moment_max=[right.manip{i}.extro_moment_max; max_mat];
            
                % Median torques
            median_mat=median(mat);
            right.manip{i}.extro_moment_median=[right.manip{i}.extro_moment_median; median_mat];
            
                % Mean torques
            mean_mat=mean(mat);
            right.manip{i}.extro_moment_mean=[right.manip{i}.extro_moment_mean; mean_mat];
                        
        end
      
    end
end




%% Manip differences per extro

%%% Left

for cat=1:3 % Categories
    left.category{cat}.extro_indices=[];
    left.category{cat}.extro_force_max=[];
    left.category{cat}.extro_force_median=[];
    left.category{cat}.extro_force_mean=[];
    left.category{cat}.extro_moment_max=[];
    left.category{cat}.extro_moment_median=[];
    left.category{cat}.extro_moment_mean=[];
    
    for i=1:3  % Manipulation
        
        for sub=1:length(left.manip{i}.extro{cat})
            
            % Indices matrix
            left.category{cat}.extro_indices=[left.category{cat}.extro_indices; num2str(i)];
            
            % FORCES
            mat=[];
            mat=load(strcat('Data/extraction/leftArmEndEffector/',num2str(left.manip{i}.extro{cat}(sub)),'/force_manip',num2str(i)));
            
                % Max forces
            max_mat=max(mat);
            left.category{cat}.extro_force_max=[left.category{cat}.extro_force_max; max_mat];
            
                % Median forces
            median_mat=median(mat);
            left.category{cat}.extro_force_median=[left.category{cat}.extro_force_median; median_mat];
            
                % Mean forces
            mean_mat=mean(mat);
            left.category{cat}.extro_force_mean=[left.category{cat}.extro_force_mean; mean_mat];
            
            % MOMENT
            mat=[];
            mat=load(strcat('Data/extraction/leftArmEndEffector/',num2str(left.manip{i}.extro{cat}(sub)),'/torque_manip',num2str(i)));
            
                % Max torques
            max_mat=max(mat);
            left.category{cat}.extro_moment_max=[left.category{cat}.extro_moment_max; max_mat];
            
                % Median torques
            median_mat=median(mat);
            left.category{cat}.extro_moment_median=[left.category{cat}.extro_moment_median; median_mat];
            
                % Mean torques
            mean_mat=mean(mat);
            left.category{cat}.extro_moment_mean=[left.category{cat}.extro_moment_mean; mean_mat];
            
                        
        end
      
    end
end

%%% Right

for cat=1:3 % Categories
    right.category{cat}.extro_indices=[];
    right.category{cat}.extro_force_max=[];
    right.category{cat}.extro_force_median=[];
    right.category{cat}.extro_force_mean=[];
    right.category{cat}.extro_moment_max=[];
    right.category{cat}.extro_moment_median=[];
    right.category{cat}.extro_moment_mean=[];
    
    for i=1:3  % Manipulation
        
        for sub=1:length(right.manip{i}.extro{cat})
            
            % Indices matrix
            right.category{cat}.extro_indices=[right.category{cat}.extro_indices; num2str(i)];
            
            % FORCES
            mat=[];
            mat=load(strcat('Data/extraction/rightArmEndEffector/',num2str(right.manip{i}.extro{cat}(sub)),'/force_manip',num2str(i)));
            
                % Max forces
            max_mat=max(mat);
            right.category{cat}.extro_force_max=[right.category{cat}.extro_force_max; max_mat];
            
                % Median forces
            median_mat=median(mat);
            right.category{cat}.extro_force_median=[right.category{cat}.extro_force_median; median_mat];
            
                % Mean forces
            mean_mat=mean(mat);
            right.category{cat}.extro_force_mean=[right.category{cat}.extro_force_mean; mean_mat];
            
            % MOMENT
            mat=[];
            mat=load(strcat('Data/extraction/rightArmEndEffector/',num2str(right.manip{i}.extro{cat}(sub)),'/torque_manip',num2str(i)));
            
                % Max torques
            max_mat=max(mat);
            right.category{cat}.extro_moment_max=[right.category{cat}.extro_moment_max; max_mat];
            
                % Median torques
            median_mat=median(mat);
            right.category{cat}.extro_moment_median=[right.category{cat}.extro_moment_median; median_mat];
            
                % Mean torques
            mean_mat=mean(mat);
            right.category{cat}.extro_moment_mean=[right.category{cat}.extro_moment_mean; mean_mat];
            
                        
        end
      
    end
end




%% BOXPLOT
%%% Extroversion differences per manip

for i=1:3
    
    % LEFT
    
    % max
    figure(1)
    subplot(1,3,i)
    boxplot(left.manip{i}.extro_force_max,left.manip{i}.extro_indices);
    xlabel('Extroversion catégorie')
    ylabel('Fmax per subject')
    title(strcat('Trial ',num2str(i)))
    saveas(gcf,'Data/results/boxplot/extroversion/leftArm_trial_forceMax.png');
    
    % median
    figure(2)
    subplot(1,3,i)
    boxplot(left.manip{i}.extro_force_median,left.manip{i}.extro_indices);
    xlabel('Extroversion catégorie')
    ylabel('Fmedian per subject')
    title(strcat('Trial ',num2str(i)))
    saveas(gcf,'Data/results/boxplot/extroversion/leftArm_trial_forceMedian.png');
    
    % mean
    figure(3)
    subplot(1,3,i)
    boxplot(left.manip{i}.extro_force_mean,left.manip{i}.extro_indices);
    xlabel('Extroversion catégorie')
    ylabel('Fmean per subject')
    title(strcat('Trial ',num2str(i)))
    saveas(gcf,'Data/results/boxplot/extroversion/leftArm_trial_forceMean.png');
   
    
    
    % RIGHT
    
    % max
    figure(4)
    subplot(1,3,i)
    boxplot(right.manip{i}.extro_force_max,right.manip{i}.extro_indices);
    xlabel('Extroversion catégorie')
    ylabel('Fmax per subject')
    title(strcat('Trial ',num2str(i)))
    saveas(gcf,'Data/results/boxplot/extroversion/rightArm_trial_forceMax.png');
    
    % median
    figure(5)
    subplot(1,3,i)
    boxplot(right.manip{i}.extro_force_median,right.manip{i}.extro_indices);
    xlabel('Extroversion catégorie')
    ylabel('Fmedian per subject')
    title(strcat('Trial ',num2str(i)))
    saveas(gcf,'Data/results/boxplot/extroversion/rightArm_trial_forceMedian.png');
    
    % mean
    figure(6)
    subplot(1,3,i)
    boxplot(right.manip{i}.extro_force_mean,right.manip{i}.extro_indices);
    xlabel('Extroversion catégorie')
    ylabel('Fmean per subject')
    title(strcat('Trial ',num2str(i)))
    saveas(gcf,'Data/results/boxplot/extroversion/rightArm_trial_forceMean.png');
    
    
end




%% BOXPLOT
%%% Manip differences per extro

for cat=1:3
    
    % LEFT
    
    % max
    figure(7)
    subplot(1,3,cat)
    boxplot(left.category{cat}.extro_force_max,left.category{cat}.extro_indices);
    xlabel('Trial')
    ylabel('Fmax per subject')
    title(strcat('Extroversion ',num2str(cat)))
    saveas(gcf,'Data/results/boxplot/extroversion/leftArm_cat_forceMax.png');
    
    % median
    figure(8)
    subplot(1,3,cat)
    boxplot(left.category{cat}.extro_force_median,left.category{cat}.extro_indices);
    xlabel('Trial')
    ylabel('Fmedian per subject')
    title(strcat('Extroversion ',num2str(cat)))
    saveas(gcf,'Data/results/boxplot/extroversion/leftArm_cat_forceMedian.png');
    
    % mean
    figure(9)
    subplot(1,3,cat)
    boxplot(left.category{cat}.extro_force_mean,left.category{cat}.extro_indices);
    xlabel('Trial')
    ylabel('Fmean per subject')
    title(strcat('Extroversion ',num2str(cat)))
    saveas(gcf,'Data/results/boxplot/extroversion/leftArm_cat_forceMean.png');
   
    
    
    % RIGHT
    
    % max
    figure(10)
    subplot(1,3,cat)
    boxplot(right.category{cat}.extro_force_max,right.category{cat}.extro_indices);
    xlabel('Trial')
    ylabel('Fmax per subject')
    title(strcat('Extroversion ',num2str(cat)))
    saveas(gcf,'Data/results/boxplot/extroversion/rightArm_cat_forceMax.png');
    
    % median
    figure(11)
    subplot(1,3,cat)
    boxplot(right.category{cat}.extro_force_median,right.category{cat}.extro_indices);
    xlabel('Trial')
    ylabel('Fmedian per subject')
    title(strcat('Extroversion ',num2str(cat)))
    saveas(gcf,'Data/results/boxplot/extroversion/rightArm_cat_forceMedian.png');
    
    % mean
    figure(12)
    subplot(1,3,cat)
    boxplot(right.category{cat}.extro_force_mean,right.category{cat}.extro_indices);
    xlabel('Trial')
    ylabel('Fmean per subject')
    title(strcat('Extroversion ',num2str(cat)))
    saveas(gcf,'Data/results/boxplot/extroversion/rightArm_cat_forceMean.png');
    
    
end

