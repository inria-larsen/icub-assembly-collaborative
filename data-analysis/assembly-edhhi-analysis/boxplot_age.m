%% Age differences
% Script to generate boxplots between end effector force
% and age of participants, across the three trials of collaborative
% assembly with iCub.
%
% authors: Anthony Voilque & Serena Ivaldi (serena.ivaldi@inria.fr)

clear all
close all
clc

% Limits
% l0-l1   (l1+1)-l3   (l3+1)
% 18-26     27 - 42     43+
l1=26;
l3=42;

% Sorting
% Create vectors with good subjects for each categorie

for i=1:3
    
    %%% Left
    age_sub=load(strcat('Data/extraction/leftArmEndEffector/age/manip',num2str(i),'_age_subjects_good'));
    N_age_sub=length(age_sub);
    
        % Age categories
        left.manip{i}.age{1}=[];
        left.manip{i}.age{2}=[];
        left.manip{i}.age{3}=[];      
        
        for sub=1:N_age_sub
               
            if age_sub(sub,2)<=l1;
                left.manip{i}.age{1}=[left.manip{i}.age{1}; age_sub(sub,1)];
            end
            if (age_sub(sub,2)>l1) && (age_sub(sub,2)<=l3);
                left.manip{i}.age{2}=[left.manip{i}.age{2}; age_sub(sub,1)];
            end
            if age_sub(sub,2)>l3;
                left.manip{i}.age{3}=[left.manip{i}.age{3}; age_sub(sub,1)];
            end
                
        end
        
        
 
    %%% Right
    age_sub=load(strcat('Data/extraction/rightArmEndEffector/age/manip',num2str(i),'_age_subjects_good'));
    N_age_sub=length(age_sub);
    
        % Age categories
        right.manip{i}.age{1}=[];
        right.manip{i}.age{2}=[];
        right.manip{i}.age{3}=[];
       
        
        for sub=1:N_age_sub
            
            if age_sub(sub,2)<=l1;
                right.manip{i}.age{1}=[right.manip{i}.age{1}; age_sub(sub,1)];
            end
            if (age_sub(sub,2)>l1) && (age_sub(sub,2)<=l3);
                right.manip{i}.age{2}=[right.manip{i}.age{2}; age_sub(sub,1)];
            end
            if age_sub(sub,2)>l3;
                right.manip{i}.age{3}=[right.manip{i}.age{3}; age_sub(sub,1)];
            end
        end

end




%% Age differences per manip

%%% Left

for i=1:3
    left.manip{i}.indices=[];
    left.manip{i}.force_max=[];
    left.manip{i}.force_median=[];
    left.manip{i}.force_mean=[];
    left.manip{i}.moment_max=[];
    left.manip{i}.moment_median=[];
    left.manip{i}.moment_mean=[];
    
    for cat=1:3  % Categories
        
        for sub=1:length(left.manip{i}.age{cat})
            
            % Indices matrix
            left.manip{i}.indices=[left.manip{i}.indices; num2str(cat)];
            
            % FORCES
            mat=[];
            mat=load(strcat('Data/extraction/leftArmEndEffector/',num2str(left.manip{i}.age{cat}(sub)),'/force_manip',num2str(i)));
            
                % Max forces
            max_mat=max(mat);
            left.manip{i}.force_max=[left.manip{i}.force_max; max_mat];
            
                % Median forces
            median_mat=median(mat);
            left.manip{i}.force_median=[left.manip{i}.force_median; median_mat];
            
                % Mean forces
            mean_mat=mean(mat);
            left.manip{i}.force_mean=[left.manip{i}.force_mean; mean_mat];
            
            % MOMENT
            mat=[];
            mat=load(strcat('Data/extraction/leftArmEndEffector/',num2str(left.manip{i}.age{cat}(sub)),'/torque_manip',num2str(i)));
            
                % Max torques
            max_mat=max(mat);
            left.manip{i}.moment_max=[left.manip{i}.moment_max; max_mat];
            
                % Median torques
            median_mat=median(mat);
            left.manip{i}.moment_median=[left.manip{i}.moment_median; median_mat];
            
                % Mean torques
            mean_mat=mean(mat);
            left.manip{i}.moment_mean=[left.manip{i}.moment_mean; mean_mat];
            
                        
        end
      
    end
end
    

%%% Right

for i=1:3
    right.manip{i}.indices=[];
    right.manip{i}.force_max=[];
    right.manip{i}.force_median=[];
    right.manip{i}.force_mean=[];
    right.manip{i}.moment_max=[];
    right.manip{i}.moment_median=[];
    right.manip{i}.moment_mean=[];
    
    for cat=1:3  % Categories
        
        for sub=1:length(right.manip{i}.age{cat})
            
            % Indices matrix 
            right.manip{i}.indices=[right.manip{i}.indices; num2str(cat)];
            
            % FORCES
            mat=[];
            mat=load(strcat('Data/extraction/rightArmEndEffector/',num2str(right.manip{i}.age{cat}(sub)),'/force_manip',num2str(i)));
            
            % Max forces
            max_mat=max(mat);
            right.manip{i}.force_max=[right.manip{i}.force_max; max_mat];
            
            % Median forces
            median_mat=median(mat);
            right.manip{i}.force_median=[right.manip{i}.force_median; median_mat];
            
            % Mean forces
            mean_mat=mean(mat);
            right.manip{i}.force_mean=[right.manip{i}.force_mean; mean_mat];
            
            % MOMENT
            mat=[];
            mat=load(strcat('Data/extraction/rightArmEndEffector/',num2str(right.manip{i}.age{cat}(sub)),'/torque_manip',num2str(i)));
            
                % Max torques
            max_mat=max(mat);
            right.manip{i}.moment_max=[right.manip{i}.moment_max; max_mat];
            
                % Median torques
            median_mat=median(mat);
            right.manip{i}.moment_median=[right.manip{i}.moment_median; median_mat];
            
                % Mean torques
            mean_mat=mean(mat);
            right.manip{i}.moment_mean=[right.manip{i}.moment_mean; mean_mat];
                        
        end
      
    end
end






%% Manip differences per age

%%% Left

for cat=1:3 % Categories
    left.category{cat}.indices=[];
    left.category{cat}.force_max=[];
    left.category{cat}.force_median=[];
    left.category{cat}.force_mean=[];
    left.category{cat}.moment_max=[];
    left.category{cat}.moment_median=[];
    left.category{cat}.moment_mean=[];
    
    for i=1:3  % Manipulation
        
        for sub=1:length(left.manip{i}.age{cat})
            
            % Indices matrix
            left.category{cat}.indices=[left.category{cat}.indices; num2str(i)];
            
            % FORCES
            mat=[];
            mat=load(strcat('Data/extraction/leftArmEndEffector/',num2str(left.manip{i}.age{cat}(sub)),'/force_manip',num2str(i)));
            
                % Max forces
            max_mat=max(mat);
            left.category{cat}.force_max=[left.category{cat}.force_max; max_mat];
            
                % Median forces
            median_mat=median(mat);
            left.category{cat}.force_median=[left.category{cat}.force_median; median_mat];
            
                % Mean forces
            mean_mat=mean(mat);
            left.category{cat}.force_mean=[left.category{cat}.force_mean; mean_mat];
            
            % MOMENT
            mat=[];
            mat=load(strcat('Data/extraction/leftArmEndEffector/',num2str(left.manip{i}.age{cat}(sub)),'/torque_manip',num2str(i)));
            
                % Max torques
            max_mat=max(mat);
            left.category{cat}.moment_max=[left.category{cat}.moment_max; max_mat];
            
                % Median torques
            median_mat=median(mat);
            left.category{cat}.moment_median=[left.category{cat}.moment_median; median_mat];
            
                % Mean torques
            mean_mat=mean(mat);
            left.category{cat}.moment_mean=[left.category{cat}.moment_mean; mean_mat];
            
                        
        end
      
    end
end

%%% Right

for cat=1:3 % Categories
    right.category{cat}.indices=[];
    right.category{cat}.force_max=[];
    right.category{cat}.force_median=[];
    right.category{cat}.force_mean=[];
    right.category{cat}.moment_max=[];
    right.category{cat}.moment_median=[];
    right.category{cat}.moment_mean=[];
    
    for i=1:3  % Manipulation
        
        for sub=1:length(right.manip{i}.age{cat})
            
            % Indices matrix
            right.category{cat}.indices=[right.category{cat}.indices; num2str(i)];
            
            % FORCES
            mat=[];
            mat=load(strcat('Data/extraction/rightArmEndEffector/',num2str(right.manip{i}.age{cat}(sub)),'/force_manip',num2str(i)));
            
                % Max forces
            max_mat=max(mat);
            right.category{cat}.force_max=[right.category{cat}.force_max; max_mat];
            
                % Median forces
            median_mat=median(mat);
            right.category{cat}.force_median=[right.category{cat}.force_median; median_mat];
            
                % Mean forces
            mean_mat=mean(mat);
            right.category{cat}.force_mean=[right.category{cat}.force_mean; mean_mat];
            
            % MOMENT
            mat=[];
            mat=load(strcat('Data/extraction/rightArmEndEffector/',num2str(right.manip{i}.age{cat}(sub)),'/torque_manip',num2str(i)));
            
                % Max torques
            max_mat=max(mat);
            right.category{cat}.moment_max=[right.category{cat}.moment_max; max_mat];
            
                % Median torques
            median_mat=median(mat);
            right.category{cat}.moment_median=[right.category{cat}.moment_median; median_mat];
            
                % Mean torques
            mean_mat=mean(mat);
            right.category{cat}.moment_mean=[right.category{cat}.moment_mean; mean_mat];
            
                        
        end
      
    end
end






%% BOXPLOT
%%% Age differences per manip

for i=1:3
    
    % LEFT
    
    % max
    figure(1)
    subplot(1,3,i)
    boxplot(left.manip{i}.force_max,left.manip{i}.indices);
    xlabel('Age category')
    ylabel('Fmax per subject')
    title(strcat('Trial ',num2str(i)))
    saveas(gcf,'Data/results/boxplot/age/leftArm_trial_forceMax.png');
    
    % median
    figure(2)
    subplot(1,3,i)
    boxplot(left.manip{i}.force_median,left.manip{i}.indices);
    xlabel('Age category')
    ylabel('Fmedian per subject')
    title(strcat('Trial ',num2str(i)))
    saveas(gcf,'Data/results/boxplot/age/leftArm_trial_forceMedian.png');
    
    % mean
    figure(3)
    subplot(1,3,i)
    boxplot(left.manip{i}.force_mean,left.manip{i}.indices);
    xlabel('Age category')
    ylabel('Fmean per subject')
    title(strcat('Trial ',num2str(i)))
    saveas(gcf,'Data/results/boxplot/age/leftArm_trial_forceMean.png');
   
    
    
    % RIGHT
    
    % max
    figure(4)
    subplot(1,3,i)
    boxplot(right.manip{i}.force_max,right.manip{i}.indices);
    xlabel('Age category')
    ylabel('Fmax per subject')
    title(strcat('Trial ',num2str(i)))
    saveas(gcf,'Data/results/boxplot/age/rightArm_trial_forceMax.png');
    
    % median
    figure(5)
    subplot(1,3,i)
    boxplot(right.manip{i}.force_median,right.manip{i}.indices);
    xlabel('Age category')
    ylabel('Fmedian per subject')
    title(strcat('Trial ',num2str(i)))
    saveas(gcf,'Data/results/boxplot/age/rightArm_trial_forceMedian.png');
    
    % mean
    figure(6)
    subplot(1,3,i)
    boxplot(right.manip{i}.force_mean,right.manip{i}.indices);
    xlabel('Age category')
    ylabel('Fmean per subject')
    title(strcat('Trial ',num2str(i)))
    saveas(gcf,'Data/results/boxplot/age/rightArm_trial_forceMean.png');
    
    
end






%% BOXPLOT
%%% Manip differences per age

for cat=1:3
    
    % LEFT
    
    % max
    figure(7)
    subplot(1,3,cat)
    boxplot(left.category{cat}.force_max,left.category{cat}.indices);
    xlabel('Trial')
    ylabel('Fmax per subject')
    title(strcat('Age ',num2str(cat)))
    saveas(gcf,'Data/results/boxplot/age/leftArm_cat_forceMax.png');
    
    % median
    figure(8)
    subplot(1,3,cat)
    boxplot(left.category{cat}.force_median,left.category{cat}.indices);
    xlabel('Trial')
    ylabel('Fmedian per subject')
    title(strcat('Age ',num2str(cat)))
    saveas(gcf,'Data/results/boxplot/age/leftArm_cat_forceMedian.png');
    
    % mean
    figure(9)
    subplot(1,3,cat)
    boxplot(left.category{cat}.force_mean,left.category{cat}.indices);
    xlabel('Trial')
    ylabel('Fmean per subject')
    title(strcat('Age ',num2str(cat)))
    saveas(gcf,'Data/results/boxplot/age/leftArm_cat_forceMean.png');
   
    
    
    % RIGHT
    
    % max
    figure(10)
    subplot(1,3,cat)
    boxplot(right.category{cat}.force_max,right.category{cat}.indices);
    xlabel('Trial')
    ylabel('Fmax per subject')
    title(strcat('Age ',num2str(cat)))
    saveas(gcf,'Data/results/boxplot/age/rightArm_cat_forceMax.png');
    
    % median
    figure(11)
    subplot(1,3,cat)
    boxplot(right.category{cat}.force_median,right.category{cat}.indices);
    xlabel('Trial')
    ylabel('Fmedian per subject')
    title(strcat('Age ',num2str(cat)))
    saveas(gcf,'Data/results/boxplot/age/rightArm_cat_forceMedian.png');
    
    % mean
    figure(12)
    subplot(1,3,cat)
    boxplot(right.category{cat}.force_mean,right.category{cat}.indices);
    xlabel('Trial')
    ylabel('Fmean per subject')
    title(strcat('Age ',num2str(cat)))
    saveas(gcf,'Data/results/boxplot/age/rightArm_cat_forceMean.png');
    
    
end

            
            
            
             
