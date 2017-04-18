function []=graph_learningE()

%% Delta force and torques

% Plot for each manipulation the value of forces and torques delta per
% subject.

manip=1;
for manip=1:3
    
    % Delta per subject LEFT
    good_subjects=load(strcat('Data/extraction/leftArmEndEffector/manip',num2str(manip),'_LAEE_good'));
    N_sub=length(good_subjects);

    matf=[];
    matm=[];
    sub=1;
    for sub=1:N_sub
        
        % Force
        value_f=load(strcat('Data/extraction/leftArmEndEffector/post_process/',num2str(good_subjects(sub)),'/manip',num2str(manip),'_delta1F'));
        matf(1,sub)=value_f;
        
        % Torques
        value_m=load(strcat('Data/extraction/leftArmEndEffector/post_process/',num2str(good_subjects(sub)),'/manip',num2str(manip),'_delta1M'));
        matm(1,sub)=value_m;
        
    end
        
    % Plot
                
    figure
    plot(good_subjects,matf);
    savefig(strcat('Data/extraction/leftArmEndEffector/graphe_force_manip',num2str(manip)))
             
    figure
    plot(good_subjects,matm);
    savefig(strcat('Data/extraction/leftArmEndEffector/graphe_torques_manip',num2str(manip)))
    
    
    
    
    % Delta per subject RIGHT
    good_subjects=[];
    good_subjects=load(strcat('Data/extraction/rightArmEndEffector/manip',num2str(manip),'_RAEE_good'));
    N_sub=length(good_subjects);

    matf=[];
    matm=[];
    sub=1;
    for sub=1:N_sub
        
        % Force
        value_f=load(strcat('Data/extraction/rightArmEndEffector/post_process/',num2str(good_subjects(sub)),'/manip',num2str(manip),'_delta1F'));
        matf(1,sub)=value_f;
        
        % Torques
        value_m=load(strcat('Data/extraction/rightArmEndEffector/post_process/',num2str(good_subjects(sub)),'/manip',num2str(manip),'_delta1M'));
        matm(1,sub)=value_m;
        
    end
        
    % Plot
                
    figure
    plot(good_subjects,matf);
    savefig(strcat('Data/extraction/rightArmEndEffector/graphe_force_manip',num2str(manip)))
             
    figure
    plot(good_subjects,matm);
    savefig(strcat('Data/extraction/rightArmEndEffector/graphe_torques_manip',num2str(manip)))
end 


%% Learning effect


manip=1;
for manip=1:3
    
    disp('manip')
    manip
    
    %%%% LEFT
    
    %forces
        
    good_subjects=load(strcat('Data/extraction/leftArmEndEffector/manip',num2str(manip),'_LAEE_good'));
    N_sub=length(good_subjects);
    
    
    mat=[];
    for sub=1:N_sub
        mat=load(strcat('Data/extraction/leftArmEndEffector/',num2str(good_subjects(sub)),'/force_manip',num2str(manip)));
        max_FL=[max_FL max(mat)];
    end
    
    %torques
    deltaML=[];
   
    mat=[];
    for sub=1:N_sub
        mat=load(strcat('Data/extraction/leftArmEndEffector/',num2str(good_subjects(sub)),'/torque_manip',num2str(manip)));
        max_TL=[max_TL max(mat)];
    end 
    


    
    %%%% RIGHT
    
    %forces
    good_subjects=load(strcat('Data/extraction/rightArmEndEffector/manip',num2str(manip),'_RAEE_good'));
    N_sub=length(good_subjects);
    
    deltaFR=[];
    
    sub=1;
    for sub=1:N_sub
        mat=load(strcat('Data/extraction/leftArmEndEffector/',num2str(good_subjects(sub)),'/force_manip',num2str(manip)));
        max_FL=[max_FL max(mat)];
    end 
    


    %torques
    deltaMR=[];
 
    sub=1;
    for sub=1:N_sub
        value=load(strcat('Data/extraction/rightArmEndEffector/post_process/',num2str(good_subjects(sub)),'/manip',num2str(manip),'_delta1M'));
%         mean=mean+value;
        deltaMR(manip,sub)=value;
    end 

end

%%
manip=1:3;

% plot LEFT
meanfl=mean(deltaFL);
% q=quantile(deltaFL,0.25)
figure
boxplot(deltaFL',manip)
saveas(gcf,'Data/extraction/leftArmEndEffector/learningE_force')

meanml=mean(deltaML);
figure
boxplot(deltaML',manip)
saveas(gcf,'Data/extraction/leftArmEndEffector/learningE_torques')


% plot RIGHT;
meanfr=mean(deltaMR);
figure
boxplot(deltaMR',manip)

saveas(gcf,'Data/extraction/rightArmEndEffector/learningE_force')


meanmr=mean(deltaMR);
figure
boxplot(deltaMR',manip)
saveas(gcf,'Data/extraction/rightArmEndEffector/learningE_torques')








    