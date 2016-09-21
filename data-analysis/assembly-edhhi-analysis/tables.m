mat=load('Data/subjects_profiles');

% Gender
gender=mat(:,2);

num_men=sum(gender)
num_woman=length(gender)-num_men



for i=4:10
    info=mat(:,i);
    
    disp(strcat('For column',num2str(i)))
    
    
    min(info)
    max(info)
    median(info)
    mean(info)
    std(info)
end

%% FORCE

for i=1:3
    
    good_sub=load(strcat('Data/extraction/leftArmEndEffector/manip',num2str(i),'_LAEE_good'));
    
    force_x=[];
    force_y=[];
    force_z=[];
    
    min_sub=[];
    max_sub=[];
    median_sub=[];
    mean_sub=[];
    std_sub=[];
    
    for j=1:length(good_sub)
        force_x=load(strcat('Data/extraction/leftArmEndEffector/',num2str(good_sub(j)),'/fx_manip',num2str(i)));
        force_y=load(strcat('Data/extraction/leftArmEndEffector/',num2str(good_sub(j)),'/fy_manip',num2str(i)));
        force_z=load(strcat('Data/extraction/leftArmEndEffector/',num2str(good_sub(j)),'/fz_manip',num2str(i)));
        
        force=[];
        for k=1:length(force_x)
            force=[force ; sqrt(force_x(k)^2+force_y(k)^2+force_z(k)^2)];
        end
        
        min_sub=[min_sub ; min(force)];
        max_sub=[max_sub ; max(force)];
        median_sub=[median_sub ; median(force)];
        mean_sub=[mean_sub ; mean(force)];
        std_sub=[std_sub ; std(force)];
        
    end
    disp(strcat('Force              For Trial',num2str(i),':',num2str(min(min_sub)),'/',num2str(max(max_sub)),'/',num2str(median(median_sub)),'/',...
        num2str(mean(mean_sub)),'/',num2str(std(std_sub))))
end

%% skin sensors

for i=1:3
    
    good_sub=load(strcat('Data/extraction/leftSkinForearm/manip',num2str(i),'_LSF_good'));
    
    min_sub=[];
    max_sub=[];
    median_sub=[];
    mean_sub=[];
    std_sub=[];
    
    for j=1:length(good_sub)
        
        skin=load(strcat('Data/extraction/leftSkinForearm/',num2str(good_sub(j)),'/num_active_sensors_manip',num2str(i)));
        
        min_sub=[min_sub ; min(skin)];
        max_sub=[max_sub ; max(skin)];
        median_sub=[median_sub ; median(skin)];
        mean_sub=[mean_sub ; mean(skin)];
        std_sub=[std_sub ; std(skin)];
        
    end
    disp(strcat('Skin sensors       For Trial',num2str(i),':',num2str(min(min_sub)),'/',num2str(max(max_sub)),'/',num2str(median(median_sub)),'/',...
        num2str(mean(mean_sub)),'/',num2str(std(std_sub))))
end

%% Skin pressure

for i=1:3
    
    good_sub=load(strcat('Data/extraction/leftSkinForearm/manip',num2str(i),'_LSF_good'));
    
    min_sub=[];
    max_sub=[];
    median_sub=[];
    mean_sub=[];
    std_sub=[];
    
    for j=1:length(good_sub)
        
        pressure=load(strcat('Data/extraction/leftSkinForearm/',num2str(good_sub(j)),'/mean_manip',num2str(i)));
        
        min_sub=[min_sub ; min(pressure)];
        max_sub=[max_sub ; max(pressure)];
        median_sub=[median_sub ; median(pressure)];
        mean_sub=[mean_sub ; mean(pressure)];
        std_sub=[std_sub ; std(pressure)];
        
    end
    disp(strcat('pressure           For Trial',num2str(i),':',num2str(min(min_sub)),'/',num2str(max(max_sub)),'/',num2str(median(median_sub)),'/',...
        num2str(mean(mean_sub)),'/',num2str(std(std_sub))))
end

%% Stiffness

for i=1:3
    
    min_sub=[];
    max_sub=[];
    median_sub=[];
    mean_sub=[];
    std_sub=[];
    
    for j=1:length(left.trial{i}.subject)
        
        
        min_sub=[min_sub ; min(left.trial{i}.subject{j}.vector_stiffness)];
        max_sub=[max_sub ; max(left.trial{i}.subject{j}.vector_stiffness)];
        median_sub=[median_sub ; median(left.trial{i}.subject{j}.vector_stiffness)];
        mean_sub=[mean_sub ; mean(left.trial{i}.subject{j}.vector_stiffness)];
        std_sub=[std_sub ; std(left.trial{i}.subject{j}.vector_stiffness)];
        
    end
    disp(strcat('Stiffness          Trial',num2str(i),':',num2str(min(min_sub)),'/',num2str(max(max_sub)),'/',num2str(median(median_sub)),'/',...
        num2str(mean(mean_sub)),'/',num2str(std(std_sub))))
end

%% Smoothness

for i=1:3
    
    disp(strcat('Smoothness       Trial',num2str(i),':',num2str(min(left.trial{i}.smoothness_vector)),'/',num2str(max(left.trial{i}.smoothness_vector)),'/',num2str(median(left.trial{i}.smoothness_vector)),'/',...
        num2str(mean(left.trial{i}.smoothness_vector)),'/',num2str(std(left.trial{i}.smoothness_vector))))
    
end














