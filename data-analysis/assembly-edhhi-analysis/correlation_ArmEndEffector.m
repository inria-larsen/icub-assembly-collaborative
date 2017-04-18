%% Correlation age
clear all
close all

% LEFT

for i=1:3 % Manipulation
    
    % Arm End Effector
    good_sub=load(strcat('Data/extraction/leftArmEndEffector/age/manip',num2str(i),'_age_subjects_good'));
    correlation_forceMax=[];
    correlation_forceMean=[];
    correlation_forceMedian=[];
    
    for sub=1:size(good_sub)
        
        
        mat=[];
        mat=load(strcat('Data/extraction/leftArmEndEffector/',num2str(good_sub(sub,1)),'/force_manip',num2str(i)));
        % Force max
        max_mat=max(mat);
        correlation_forceMax=[correlation_forceMax; good_sub(sub,2) max_mat];
        % Force mean
        mean_mat=mean(mat);
        correlation_forceMean=[correlation_forceMean; good_sub(sub,2) mean_mat];
        % Force median
        median_mat=median(mat);
        correlation_forceMedian=[correlation_forceMedian; good_sub(sub,2) median_mat];
        
       
    end
    
   
    
    

    % Graphics with fit curves
    
        % Force max
        figure
        sf=fit(correlation_forceMax(:,1),correlation_forceMax(:,2),'poly1')
        plot(sf,correlation_forceMax(:,1),correlation_forceMax(:,2),'.')
        xlabel('Age')
        ylabel('Fmax')
        title(strcat('Correlation for manipulation',num2str(i),' - Maximum forces Left hand'))
        saveas(gcf,strcat('Data/extraction/leftArmEndEffector/correlation/manip',num2str(i),'_age_forceMax.png'));
    
        % Force mean
        figure
        sf=fit(correlation_forceMean(:,1),correlation_forceMean(:,2),'poly1')
        plot(sf,correlation_forceMean(:,1),correlation_forceMean(:,2),'.')
        xlabel('Age')
        ylabel('Fmean')
        title(strcat('Correlation for manipulation',num2str(i),' - Mean forces Left hand'))
        saveas(gcf,strcat('Data/extraction/leftArmEndEffector/correlation/manip',num2str(i),'_age_forceMean.png'));
    
        % Force median
        figure
        sf=fit(correlation_forceMedian(:,1),correlation_forceMedian(:,2),'poly1')
        plot(sf,correlation_forceMedian(:,1),correlation_forceMedian(:,2),'.')
        xlabel('Age')
        ylabel('Fmedian')
        title(strcat('Correlation for manipulation',num2str(i),' - Median forces Left hand'))
        saveas(gcf,strcat('Data/extraction/leftArmEndEffector/correlation/manip',num2str(i),'_age_forceMedian.png'));
    
end

% RIGHT

for i=2:3 % Manipulation
    
    % Arm End Effector
    good_sub=load(strcat('Data/extraction/rightArmEndEffector/age/manip',num2str(i),'_age_subjects_good'));
    correlation_forceMax=[];
    correlation_forceMean=[];
    correlation_forceMedian=[];
    
    for sub=1:size(good_sub)
        
        mat=[];
        mat=load(strcat('Data/extraction/rightArmEndEffector/',num2str(good_sub(sub,1)),'/force_manip',num2str(i)));
        % Force max
        max_mat=max(mat);
        correlation_forceMax=[correlation_forceMax; good_sub(sub,2) max_mat];
        % Force mean
        mean_mat=mean(mat);
        correlation_forceMean=[correlation_forceMean; good_sub(sub,2) mean_mat];
        % Force median
        median_mat=median(mat);
        correlation_forceMedian=[correlation_forceMedian; good_sub(sub,2) median_mat];
    end
    

    % Graphics with fit curves
    
        % Force max
        figure
        sf=fit(correlation_forceMax(:,1),correlation_forceMax(:,2),'poly1')
        plot(sf,correlation_forceMax(:,1),correlation_forceMax(:,2),'.')
        xlabel('Age')
        ylabel('Fmax')
        title(strcat('Correlation for manipulation',num2str(i),' - Maximum forces right hand'))
        saveas(gcf,strcat('Data/extraction/rightArmEndEffector/correlation/manip',num2str(i),'_age_forceMax.png'));
    
        % Force mean
        figure
        sf=fit(correlation_forceMean(:,1),correlation_forceMean(:,2),'poly1')
        plot(sf,correlation_forceMean(:,1),correlation_forceMean(:,2),'.')
        xlabel('Age')
        ylabel('Fmean')
        title(strcat('Correlation for manipulation',num2str(i),' - Mean forces right hand'))
        saveas(gcf,strcat('Data/extraction/rightArmEndEffector/correlation/manip',num2str(i),'_age_forceMean.png'));
    
        % Force median
        figure
        sf=fit(correlation_forceMedian(:,1),correlation_forceMedian(:,2),'poly1')
        plot(sf,correlation_forceMedian(:,1),correlation_forceMedian(:,2),'.')
        xlabel('Age')
        ylabel('Fmedian')
        title(strcat('Correlation for manipulation',num2str(i),' - Median forces right hand'))
        saveas(gcf,strcat('Data/extraction/rightArmEndEffector/correlation/manip',num2str(i),'_age_forceMedian.png'));
    
end

%% Correlation negative attitude
close all

% LEFT

for i=1:3 % Manipulation
    
    % Arm End Effector
    good_sub=load(strcat('Data/extraction/leftArmEndEffector/negativeAtt/manip',num2str(i),'_neg_subjects_good'));
    correlation_forceMax=[];
    correlation_forceMean=[];
    correlation_forceMedian=[];
    
    for sub=1:size(good_sub)
        
        mat=[];
        mat=load(strcat('Data/extraction/leftArmEndEffector/',num2str(good_sub(sub,1)),'/force_manip',num2str(i)));
        % Force max
        max_mat=max(mat);
        correlation_forceMax=[correlation_forceMax; good_sub(sub,2) max_mat];
        % Force mean
        mean_mat=mean(mat);
        correlation_forceMean=[correlation_forceMean; good_sub(sub,2) mean_mat];
        % Force median
        median_mat=median(mat);
        correlation_forceMedian=[correlation_forceMedian; good_sub(sub,2) median_mat];
    end
    

    % Graphics with fit curves
    
        % Force max
        figure
        sf=fit(correlation_forceMax(:,1),correlation_forceMax(:,2),'poly1')
        plot(sf,correlation_forceMax(:,1),correlation_forceMax(:,2),'.')
        xlabel('Negative attitude')
        ylabel('Fmax')
        title(strcat('Correlation for manipulation',num2str(i),' - Maximum forces Left hand'))
        saveas(gcf,strcat('Data/extraction/leftArmEndEffector/correlation/manip',num2str(i),'_neg_forceMax.png'));
    
        % Force mean
        figure
        sf=fit(correlation_forceMean(:,1),correlation_forceMean(:,2),'poly1')
        plot(sf,correlation_forceMean(:,1),correlation_forceMean(:,2),'.')
        xlabel('Negative attitude')
        ylabel('Fmean')
        title(strcat('Correlation for manipulation',num2str(i),' - Mean forces Left hand'))
        saveas(gcf,strcat('Data/extraction/leftArmEndEffector/correlation/manip',num2str(i),'_neg_forceMean.png'));
    
        % Force median
        figure
        sf=fit(correlation_forceMedian(:,1),correlation_forceMedian(:,2),'poly1')
        plot(sf,correlation_forceMedian(:,1),correlation_forceMedian(:,2),'.')
        xlabel('Negative attitude')
        ylabel('Fmedian')
        title(strcat('Correlation for manipulation',num2str(i),' - Median forces Left hand'))
        saveas(gcf,strcat('Data/extraction/leftArmEndEffector/correlation/manip',num2str(i),'_neg_forceMedian.png'));
    
end

% RIGHT

for i=2:3 % Manipulation
    
    % Arm End Effector
    good_sub=load(strcat('Data/extraction/rightArmEndEffector/negativeAtt/manip',num2str(i),'_neg_subjects_good'));
    correlation_forceMax=[];
    correlation_forceMean=[];
    correlation_forceMedian=[];
    
    for sub=1:size(good_sub)
        
        mat=[];
        mat=load(strcat('Data/extraction/rightArmEndEffector/',num2str(good_sub(sub,1)),'/force_manip',num2str(i)));
        % Force max
        max_mat=max(mat);
        correlation_forceMax=[correlation_forceMax; good_sub(sub,2) max_mat];
        % Force mean
        mean_mat=mean(mat);
        correlation_forceMean=[correlation_forceMean; good_sub(sub,2) mean_mat];
        % Force median
        median_mat=median(mat);
        correlation_forceMedian=[correlation_forceMedian; good_sub(sub,2) median_mat];
    end
    

    % Graphics with fit curves
    
        % Force max
        figure
        sf=fit(correlation_forceMax(:,1),correlation_forceMax(:,2),'poly1')
        plot(sf,correlation_forceMax(:,1),correlation_forceMax(:,2),'.')
        xlabel('Negative attitude')
        ylabel('Fmax')
        title(strcat('Correlation for manipulation',num2str(i),' - Maximum forces right hand'))
        saveas(gcf,strcat('Data/extraction/rightArmEndEffector/correlation/manip',num2str(i),'_neg_forceMax.png'));
    
        % Force mean
        figure
        sf=fit(correlation_forceMean(:,1),correlation_forceMean(:,2),'poly1')
        plot(sf,correlation_forceMean(:,1),correlation_forceMean(:,2),'.')
        xlabel('Negative attitude')
        ylabel('Fmean')
        title(strcat('Correlation for manipulation',num2str(i),' - Mean forces right hand'))
        saveas(gcf,strcat('Data/extraction/rightArmEndEffector/correlation/manip',num2str(i),'_neg_forceMean.png'));
    
        % Force median
        figure
        sf=fit(correlation_forceMedian(:,1),correlation_forceMedian(:,2),'poly1')
        plot(sf,correlation_forceMedian(:,1),correlation_forceMedian(:,2),'.')
        xlabel('Negative attitude')
        ylabel('Fmedian')
        title(strcat('Correlation for manipulation',num2str(i),' - Median forces right hand'))
        saveas(gcf,strcat('Data/extraction/rightArmEndEffector/correlation/manip',num2str(i),'_neg_forceMedian.png'));
    
end

%% Correlation extroversion
close all

% LEFT

for i=1:3 % Manipulation
    
    % Arm End Effector
    good_sub=load(strcat('Data/extraction/leftArmEndEffector/extroversion/manip',num2str(i),'_extro_subjects_good'));
    correlation_forceMax=[];
    correlation_forceMean=[];
    correlation_forceMedian=[];
    
    for sub=1:size(good_sub)
        
        mat=[];
        mat=load(strcat('Data/extraction/leftArmEndEffector/',num2str(good_sub(sub,1)),'/force_manip',num2str(i)));
        % Force max
        max_mat=max(mat);
        correlation_forceMax=[correlation_forceMax; good_sub(sub,2) max_mat];
        % Force mean
        mean_mat=mean(mat);
        correlation_forceMean=[correlation_forceMean; good_sub(sub,2) mean_mat];
        % Force median
        median_mat=median(mat);
        correlation_forceMedian=[correlation_forceMedian; good_sub(sub,2) median_mat];
    end
    

    % Graphics with fit curves
    
        % Force max
        figure
        sf=fit(correlation_forceMax(:,1),correlation_forceMax(:,2),'poly1')
        plot(sf,correlation_forceMax(:,1),correlation_forceMax(:,2),'.')
        xlabel('Extroversion')
        ylabel('Fmax')
        title(strcat('Correlation for manipulation',num2str(i),' - Maximum forces Left hand'))
        saveas(gcf,strcat('Data/extraction/leftArmEndEffector/correlation/manip',num2str(i),'_extro_forceMax.png'));
    
        % Force mean
        figure
        sf=fit(correlation_forceMean(:,1),correlation_forceMean(:,2),'poly1')
        plot(sf,correlation_forceMean(:,1),correlation_forceMean(:,2),'.')
        xlabel('Extroversion')
        ylabel('Fmean')
        title(strcat('Correlation for manipulation',num2str(i),' - Mean forces Left hand'))
        saveas(gcf,strcat('Data/extraction/leftArmEndEffector/correlation/manip',num2str(i),'_extro_forceMean.png'));
    
        % Force median
        figure
        sf=fit(correlation_forceMedian(:,1),correlation_forceMedian(:,2),'poly1')
        plot(sf,correlation_forceMedian(:,1),correlation_forceMedian(:,2),'.')
        xlabel('Extroversion')
        ylabel('Fmedian')
        title(strcat('Correlation for manipulation',num2str(i),' - Median forces Left hand'))
        saveas(gcf,strcat('Data/extraction/leftArmEndEffector/correlation/manip',num2str(i),'_extro_forceMedian.png'));
    
end

% RIGHT

for i=2:3 % Manipulation
    
    % Arm End Effector
    good_sub=load(strcat('Data/extraction/rightArmEndEffector/extroversion/manip',num2str(i),'_extro_subjects_good'));
    correlation_forceMax=[];
    correlation_forceMean=[];
    correlation_forceMedian=[];
    
    for sub=1:size(good_sub)
        
        mat=[];
        mat=load(strcat('Data/extraction/rightArmEndEffector/',num2str(good_sub(sub,1)),'/force_manip',num2str(i)));
        % Force max
        max_mat=max(mat);
        correlation_forceMax=[correlation_forceMax; good_sub(sub,2) max_mat];
        % Force mean
        mean_mat=mean(mat);
        correlation_forceMean=[correlation_forceMean; good_sub(sub,2) mean_mat];
        % Force median
        median_mat=median(mat);
        correlation_forceMedian=[correlation_forceMedian; good_sub(sub,2) median_mat];
    end
    

    % Graphics with fit curves
    
        % Force max
        figure
        sf=fit(correlation_forceMax(:,1),correlation_forceMax(:,2),'poly1')
        plot(sf,correlation_forceMax(:,1),correlation_forceMax(:,2),'.')
        xlabel('Extroversion')
        ylabel('Fmax')
        title(strcat('Correlation for manipulation',num2str(i),' - Maximum forces right hand'))
        saveas(gcf,strcat('Data/extraction/rightArmEndEffector/correlation/manip',num2str(i),'_extro_forceMax.png'));
    
        % Force mean
        figure
        sf=fit(correlation_forceMean(:,1),correlation_forceMean(:,2),'poly1')
        plot(sf,correlation_forceMean(:,1),correlation_forceMean(:,2),'.')
        xlabel('Extroversion')
        ylabel('Fmean')
        title(strcat('Correlation for manipulation',num2str(i),' - Mean forces right hand'))
        saveas(gcf,strcat('Data/extraction/rightArmEndEffector/correlation/manip',num2str(i),'_extro_forceMean.png'));
    
        % Force median
        figure
        sf=fit(correlation_forceMedian(:,1),correlation_forceMedian(:,2),'poly1')
        plot(sf,correlation_forceMedian(:,1),correlation_forceMedian(:,2),'.')
        xlabel('Extroversion')
        ylabel('Fmedian')
        title(strcat('Correlation for manipulation',num2str(i),' - Median forces right hand'))
        saveas(gcf,strcat('Data/extraction/rightArmEndEffector/correlation/manip',num2str(i),'_extro_forceMedian.png'));
    
end

