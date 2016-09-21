%% NARS differences
% Script to generate boxplots between end effector force
% and NARS of participants, across the three trials of collaborative
% assembly with iCub.
%
% authors: Anthony Voilque & Serena Ivaldi (serena.ivaldi@inria.fr)

clear all
close all
clc

% Limits
% l0-l1   (l1+1)-l3   (l3+1)
% 0-38     39 - 51      52+
l1=38;
l3=51;

% Sorting
% Create vectors with good subjects for each categorie

for i=1:3
    
    %%% Left
    neg_sub=load(strcat('Data/extraction/leftArmEndEffector/negativeAtt/NARS/manip',num2str(i),'_neg_subjects_good'));
    N_neg_sub=length(neg_sub);
    
        % neg categories
        left.manip{i}.neg{1}=[];
        left.manip{i}.neg{2}=[];
        left.manip{i}.neg{3}=[];      
        
        for sub=1:N_neg_sub
               
            if neg_sub(sub,2)<=l1;
                left.manip{i}.neg{1}=[left.manip{i}.neg{1}; neg_sub(sub,1)];
            end
            if (neg_sub(sub,2)>l1) && (neg_sub(sub,2))<=l3;
                left.manip{i}.neg{2}=[left.manip{i}.neg{1}; neg_sub(sub,1)];
            end
            if neg_sub(sub,2)>l3;
                left.manip{i}.neg{3}=[left.manip{i}.neg{3}; neg_sub(sub,1)];
            end
                
        end
        
        
 
    %%% Right
    neg_sub=load(strcat('Data/extraction/rightArmEndEffector/negativeAtt/NARS/manip',num2str(i),'_neg_subjects_good'));
    N_neg_sub=length(neg_sub);
    
        % neg categories
        right.manip{i}.neg{1}=[];
        right.manip{i}.neg{2}=[];
        right.manip{i}.neg{3}=[];
       
        
        for sub=1:N_neg_sub
            
            if neg_sub(sub,2)<=l1;
                right.manip{i}.neg{1}=[right.manip{i}.neg{1}; neg_sub(sub,1)];
            end
            if (neg_sub(sub,2)>l1) && (neg_sub(sub,2))<=l3;
                right.manip{i}.neg{2}=[right.manip{i}.neg{2}; neg_sub(sub,1)];
            end
            if neg_sub(sub,2)>l3;
                right.manip{i}.neg{3}=[right.manip{i}.neg{3}; neg_sub(sub,1)];
            end
        end

end




%% NARS differences per manip

%%% Left

for i=1:3
    left.manip{i}.neg_indices=[];
    left.manip{i}.neg_force_max=[];
    left.manip{i}.neg_force_median=[];
    left.manip{i}.neg_force_mean=[];
    left.manip{i}.neg_moment_max=[];
    left.manip{i}.neg_moment_median=[];
    left.manip{i}.neg_moment_mean=[];
    
    for cat=1:3  % Categories
        
        for sub=1:length(left.manip{i}.neg{cat})
            
            % Indices matrix
            left.manip{i}.neg_indices=[left.manip{i}.neg_indices; num2str(cat)];
            
            % FORCES
            mat=[];
            mat=load(strcat('Data/extraction/leftArmEndEffector/',num2str(left.manip{i}.neg{cat}(sub)),'/force_manip',num2str(i)));
            
                % Max forces
            max_mat=max(mat);
            left.manip{i}.neg_force_max=[left.manip{i}.neg_force_max; max_mat];
            
                % Median forces
            median_mat=median(mat);
            left.manip{i}.neg_force_median=[left.manip{i}.neg_force_median; median_mat];
            
                % Mean forces
            mean_mat=mean(mat);
            left.manip{i}.neg_force_mean=[left.manip{i}.neg_force_mean; mean_mat];
            
            % MOMENT
            mat=[];
            mat=load(strcat('Data/extraction/leftArmEndEffector/',num2str(left.manip{i}.neg{cat}(sub)),'/torque_manip',num2str(i)));
            
                % Max torques
            max_mat=max(mat);
            left.manip{i}.neg_moment_max=[left.manip{i}.neg_moment_max; max_mat];
            
                % Median torques
            median_mat=median(mat);
            left.manip{i}.neg_moment_median=[left.manip{i}.neg_moment_median; median_mat];
            
                % Mean torques
            mean_mat=mean(mat);
            left.manip{i}.neg_moment_mean=[left.manip{i}.neg_moment_mean; mean_mat];
            
                        
        end
      
    end
end
    

%%% Right

for i=1:3
    right.manip{i}.neg_indices=[];
    right.manip{i}.neg_force_max=[];
    right.manip{i}.neg_force_median=[];
    right.manip{i}.neg_force_mean=[];
    right.manip{i}.neg_moment_max=[];
    right.manip{i}.neg_moment_median=[];
    right.manip{i}.neg_moment_mean=[];
    
    for cat=1:3  % Categories
        
        for sub=1:length(right.manip{i}.neg{cat})
            
            % Indices matrix 
            right.manip{i}.neg_indices=[right.manip{i}.neg_indices; num2str(cat)];
            
            % FORCES
            mat=[];
            mat=load(strcat('Data/extraction/rightArmEndEffector/',num2str(right.manip{i}.neg{cat}(sub)),'/force_manip',num2str(i)));
            
            % Max forces
            max_mat=max(mat);
            right.manip{i}.neg_force_max=[right.manip{i}.neg_force_max; max_mat];
            
            % Median forces
            median_mat=median(mat);
            right.manip{i}.neg_force_median=[right.manip{i}.neg_force_median; median_mat];
            
            % Mean forces
            mean_mat=mean(mat);
            right.manip{i}.neg_force_mean=[right.manip{i}.neg_force_mean; mean_mat];
            
            % MOMENT
            mat=[];
            mat=load(strcat('Data/extraction/rightArmEndEffector/',num2str(right.manip{i}.neg{cat}(sub)),'/torque_manip',num2str(i)));
            
                % Max torques
            max_mat=max(mat);
            right.manip{i}.neg_moment_max=[right.manip{i}.neg_moment_max; max_mat];
            
                % Median torques
            median_mat=median(mat);
            right.manip{i}.neg_moment_median=[right.manip{i}.neg_moment_median; median_mat];
            
                % Mean torques
            mean_mat=mean(mat);
            right.manip{i}.neg_moment_mean=[right.manip{i}.neg_moment_mean; mean_mat];
                        
        end
      
    end
end






%% Manip differences per NARS

%%% Left

for cat=1:3 % Categories
    left.category{cat}.neg_indices=[];
    left.category{cat}.neg_force_max=[];
    left.category{cat}.neg_force_median=[];
    left.category{cat}.neg_force_mean=[];
    left.category{cat}.neg_moment_max=[];
    left.category{cat}.neg_moment_median=[];
    left.category{cat}.neg_moment_mean=[];
    
    for i=1:3  % Manipulation
        
        for sub=1:length(left.manip{i}.neg{cat})
            
            % Indices matrix
            left.category{cat}.neg_indices=[left.category{cat}.neg_indices; num2str(i)];
            
            % FORCES
            mat=[];
            mat=load(strcat('Data/extraction/leftArmEndEffector/',num2str(left.manip{i}.neg{cat}(sub)),'/force_manip',num2str(i)));
            
                % Max forces
            max_mat=max(mat);
            left.category{cat}.neg_force_max=[left.category{cat}.neg_force_max; max_mat];
            
                % Median forces
            median_mat=median(mat);
            left.category{cat}.neg_force_median=[left.category{cat}.neg_force_median; median_mat];
            
                % Mean forces
            mean_mat=mean(mat);
            left.category{cat}.neg_force_mean=[left.category{cat}.neg_force_mean; mean_mat];
            
            % MOMENT
            mat=[];
            mat=load(strcat('Data/extraction/leftArmEndEffector/',num2str(left.manip{i}.neg{cat}(sub)),'/torque_manip',num2str(i)));
            
                % Max torques
            max_mat=max(mat);
            left.category{cat}.neg_moment_max=[left.category{cat}.neg_moment_max; max_mat];
            
                % Median torques
            median_mat=median(mat);
            left.category{cat}.neg_moment_median=[left.category{cat}.neg_moment_median; median_mat];
            
                % Mean torques
            mean_mat=mean(mat);
            left.category{cat}.neg_moment_mean=[left.category{cat}.neg_moment_mean; mean_mat];
            
                        
        end
      
    end
end

%%% Right

for cat=1:3 % Categories
    right.category{cat}.neg_indices=[];
    right.category{cat}.neg_force_max=[];
    right.category{cat}.neg_force_median=[];
    right.category{cat}.neg_force_mean=[];
    right.category{cat}.neg_moment_max=[];
    right.category{cat}.neg_moment_median=[];
    right.category{cat}.neg_moment_mean=[];
    
    for i=1:3  % Manipulation
        
        for sub=1:length(right.manip{i}.neg{cat})
            
            % Indices matrix
            right.category{cat}.neg_indices=[right.category{cat}.neg_indices; num2str(i)];
            
            % FORCES
            mat=[];
            mat=load(strcat('Data/extraction/rightArmEndEffector/',num2str(right.manip{i}.neg{cat}(sub)),'/force_manip',num2str(i)));
            
                % Max forces
            max_mat=max(mat);
            right.category{cat}.neg_force_max=[right.category{cat}.neg_force_max; max_mat];
            
                % Median forces
            median_mat=median(mat);
            right.category{cat}.neg_force_median=[right.category{cat}.neg_force_median; median_mat];
            
                % Mean forces
            mean_mat=mean(mat);
            right.category{cat}.neg_force_mean=[right.category{cat}.neg_force_mean; mean_mat];
            
            % MOMENT
            mat=[];
            mat=load(strcat('Data/extraction/rightArmEndEffector/',num2str(right.manip{i}.neg{cat}(sub)),'/torque_manip',num2str(i)));
            
                % Max torques
            max_mat=max(mat);
            right.category{cat}.neg_moment_max=[right.category{cat}.neg_moment_max; max_mat];
            
                % Median torques
            median_mat=median(mat);
            right.category{cat}.neg_moment_median=[right.category{cat}.neg_moment_median; median_mat];
            
                % Mean torques
            mean_mat=mean(mat);
            right.category{cat}.neg_moment_mean=[right.category{cat}.neg_moment_mean; mean_mat];
            
                        
        end
      
    end
end






%% BOXPLOT
%%% NARS differences per manip

for i=1:3
    
    % LEFT
    
    % max
    figure(1)
    subplot(1,3,i)
    boxplot(left.manip{i}.neg_force_max,left.manip{i}.neg_indices);
    xlabel('NARS category')
    ylabel('Fmax per subject')
    title(strcat('Trial  ',num2str(i)))
    saveas(gcf,'Data/results/boxplot/negativeAtt/NARS_leftArm_trial_forceMax.png');
    
    % median
    figure(2)
    subplot(1,3,i)
    boxplot(left.manip{i}.neg_force_median,left.manip{i}.neg_indices);
    xlabel('NARS category')
    ylabel('Fmedian per subject')
    title(strcat('Trial  ',num2str(i)))
    saveas(gcf,'Data/results/boxplot/negativeAtt/NARS_leftArm_trial_forceMedian.png');
    
    % mean
    figure(3)
    subplot(1,3,i)
    boxplot(left.manip{i}.neg_force_mean,left.manip{i}.neg_indices);
    xlabel('NARS category')
    ylabel('Fmean per subject')
    title(strcat('Trial  ',num2str(i)))
    saveas(gcf,'Data/results/boxplot/negativeAtt/NARS_leftArm_trial_forceMean.png');
   
    
    
    % RIGHT
    
    % max
    figure(4)
    subplot(1,3,i)
    boxplot(right.manip{i}.neg_force_max,right.manip{i}.neg_indices);
    xlabel('NARS category')
    ylabel('Fmax per subject')
    title(strcat('Trial  ',num2str(i)))
    saveas(gcf,'Data/results/boxplot/negativeAtt/NARS_rightArm_trial_forceMax.png');
    
    % median
    figure(5)
    subplot(1,3,i)
    boxplot(right.manip{i}.neg_force_median,right.manip{i}.neg_indices);
    xlabel('NARS category')
    ylabel('Fmedian per subject')
    title(strcat('Trial  ',num2str(i)))
    saveas(gcf,'Data/results/boxplot/negativeAtt/NARS_rightArm_trial_forceMedian.png');
    
    % mean
    figure(6)
    subplot(1,3,i)
    boxplot(right.manip{i}.neg_force_mean,right.manip{i}.neg_indices);
    xlabel('NARS category')
    ylabel('Fmean per subject')
    title(strcat('Trial  ',num2str(i)))
    saveas(gcf,'Data/results/boxplot/negativeAtt/NARS_rightArm_trial_forceMean.png');
    
    
end






%% BOXPLOT
%%% Manip differences per NARS

for cat=1:3
    
    % LEFT
    
    % max
    figure(7)
    subplot(1,3,cat)
    boxplot(left.category{cat}.neg_force_max,left.category{cat}.neg_indices);
    xlabel('Trial')
    ylabel('Fmax per subject')
    title(strcat('NARS-',num2str(cat)))
    saveas(gcf,'Data/results/boxplot/negativeAtt/NARS_leftArm_cat_forceMax.png');
    
    % median
    figure(8)
    subplot(1,3,cat)
    boxplot(left.category{cat}.neg_force_median,left.category{cat}.neg_indices);
    xlabel('Trial')
    ylabel('Fmedian per subject')
    title(strcat('NARS-',num2str(cat)))
    saveas(gcf,'Data/results/boxplot/negativeAtt/NARS_leftArm_cat_forceMedian.png');
    
    % mean
    figure(9)
    subplot(1,3,cat)
    boxplot(left.category{cat}.neg_force_mean,left.category{cat}.neg_indices);
    xlabel('Trial')
    ylabel('Fmean per subject')
    title(strcat('NARS-',num2str(cat)))
    saveas(gcf,'Data/results/boxplot/negativeAtt/NARS_leftArm_cat_forceMean.png');
   
    
    
    % RIGHT
    
    % max
    figure(10)
    subplot(1,3,cat)
    boxplot(right.category{cat}.neg_force_max,right.category{cat}.neg_indices);
    xlabel('Trial')
    ylabel('Fmax per subject')
    title(strcat('NARS-',num2str(cat)))
    saveas(gcf,'Data/results/boxplot/negativeAtt/NARS_rightArm_cat_forceMax.png');
    
    % median
    figure(11)
    subplot(1,3,cat)
    boxplot(right.category{cat}.neg_force_median,right.category{cat}.neg_indices);
    xlabel('Trial')
    ylabel('Fmedian per subject')
    title(strcat('NARS-',num2str(cat)))
    saveas(gcf,'Data/results/boxplot/negativeAtt/NARS_rightArm_cat_forceMedian.png');
    
    % mean
    figure(12)
    subplot(1,3,cat)
    boxplot(right.category{cat}.neg_force_mean,right.category{cat}.neg_indices);
    xlabel('Trial')
    ylabel('Fmean per subject')
    title(strcat('NARS-',num2str(cat)))
    saveas(gcf,'Data/results/boxplot/negativeAtt/NARS_rightArm_cat_forceMean.png');
    
    
end

