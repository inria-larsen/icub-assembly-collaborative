%% Learning effect

% Reading of forces and torques resultant
for manip=1:3

    %%%% LEFT
    
    good_subjects=load(strcat('Data/extraction/leftArmEndEffector/manip',num2str(manip),'_LAEE_good'));
    N_sub=length(good_subjects);
    
    %forces
    
    mat=[];
    for sub=1:N_sub
        mat=load(strcat('Data/extraction/leftArmEndEffector/',num2str(good_subjects(sub)),'/force_manip',num2str(manip)));
        max_FL(sub,manip)= max(mat);
        mean_FL(sub,manip)=mean(mat);
        median_FL(sub,manip)=median(mat);
    end
    
    %torques
   
    mat=[];
    for sub=1:N_sub
        mat=load(strcat('Data/extraction/leftArmEndEffector/',num2str(good_subjects(sub)),'/torque_manip',num2str(manip)));
        max_ML(sub,manip)= max(mat);
        mean_ML(sub,manip)=mean(mat);
        median_ML(sub,manip)=median(mat);
    end 
    

    
    %%%% RIGHT
    
    good_subjects=load(strcat('Data/extraction/rightArmEndEffector/manip',num2str(manip),'_RAEE_good'));
    N_sub=length(good_subjects);
    
    %forces
    
    mat=[];
    for sub=1:N_sub
        mat=load(strcat('Data/extraction/rightArmEndEffector/',num2str(good_subjects(sub)),'/force_manip',num2str(manip)));
        max_FR(sub,manip)= max(mat);
        mean_FR(sub,manip)=mean(mat);
        median_FR(sub,manip)=median(mat);
    end 
    
    %torques
    
    mat=[];
    for sub=1:N_sub
        mat=load(strcat('Data/extraction/rightArmEndEffector/',num2str(good_subjects(sub)),'/force_manip',num2str(manip)));
        max_MR(sub,manip)= max(mat);
        mean_MR(sub,manip)=mean(mat);
        median_MR(sub,manip)=median(mat);
    end


    
end

%% Plot for each manipulation

X=1:3;  
    
% plot LEFT

%max
figure
boxplot(max_FL,X);
xlabel('Manipulation')
ylabel('Fmax per subject')
title('Maximum forces Left hand')
saveas(gcf,strcat('Data/extraction/leftArmEndEffector/boxplot_forceMax.png'));
disp('max fl');
median(max_FL)


figure
boxplot(max_ML,X);
xlabel('Manipulation')
ylabel('Mmax per subject')
title('Maximum torques Left hand')
saveas(gcf,strcat('Data/extraction/leftArmEndEffector/boxplot_torqueMax.png'));
disp('max ml');
median(max_ML)

%median
figure
boxplot(median_FL,X);
xlabel('Manipulation')
ylabel('Fmedian per subject')
title('Median forces Left hand')
saveas(gcf,strcat('Data/extraction/leftArmEndEffector/boxplot_forceMedian.png'));
disp('median fl');
median(median_FL)


figure
boxplot(median_ML,X);
xlabel('Manipulation')
ylabel('Mmedian per subject')
title('Median torques Left hand')
saveas(gcf,strcat('Data/extraction/leftArmEndEffector/boxplot_torqueMedian.png'));
disp('median ml');
median(median_ML)

%mean
figure
boxplot(mean_FL,X)
xlabel('Manipulation')
ylabel('Fmean per subject')
title('Mean forces Left hand')
saveas(gcf,strcat('Data/extraction/leftArmEndEffector/boxplot_forceMean.png'));
disp('mean ml');
median(mean_FL)

figure
boxplot(mean_ML,X)
xlabel('Manipulation')
ylabel('Mmean per subject')
title('Mean torques Left hand')
saveas(gcf,strcat('Data/extraction/leftArmEndEffector/boxplot_torqueMean.png'));


%% plot RIGHT;
%max
figure
boxplot(max_FR,X)
xlabel('Manipulation')
ylabel('Fmax per subject')
title('Maximum forces Right hand')
saveas(gcf,strcat('Data/extraction/rightArmEndEffector/boxplot_forceMax.png'));
figure
boxplot(max_MR,X)
xlabel('Manipulation')
ylabel('Mmax per subject')
title('Maximum torques Right hand')
saveas(gcf,strcat('Data/extraction/rightArmEndEffector/boxplot_torqueMax.png'));

%median
figure
boxplot(median_FR,X);
xlabel('Manipulation')
ylabel('Fmedian per subject')
title('Median forces Right hand')
saveas(gcf,strcat('Data/extraction/rightArmEndEffector/boxplot_forceMedian.png'));
disp('median fr');
median(median_FR)


figure
boxplot(median_MR,X);
xlabel('Manipulation')
ylabel('Mmedian per subject')
title('Median torques Right hand')
saveas(gcf,strcat('Data/extraction/rightArmEndEffector/boxplot_torqueMedian.png'));
disp('median mr');
median(median_MR)

%mean
figure
boxplot(mean_FR,X)
xlabel('Manipulation')
ylabel('Fmean per subject')
title('Mean forces Right hand')
saveas(gcf,strcat('Data/extraction/rightArmEndEffector/boxplot_forceMean.png'));
figure
boxplot(mean_MR,X)
xlabel('Manipulation')
ylabel('Mmean per subject')
title('Mean torques Right hand')
saveas(gcf,strcat('Data/extraction/rightArmEndEffector/boxplot_torqueMean.png'));

