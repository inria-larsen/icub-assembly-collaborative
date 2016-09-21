%% Stiffness
% Script to calculate participant stiffness and generate the plots of
% correlation between stiffness and profile of participants, across the
% three trials of collaborative assembly with iCub.
%
% authors: Anthony Voilque & Serena Ivaldi (serena.ivaldi@inria.fr)

clear all;
close all
clc;

filter_iterations=3;
flag_bypass_force_filter=0;
flag_bypass_cart_filter=0;
flag_filter_iterations_plot=0;

% Stiffness parameters
delta_stiff=25; % Number of value


for i=1:3 % Trial
    
    subjects_force_good=load(strcat('Data/extraction/leftArmEndEffector/manip',num2str(i),'_LAEE_good'));
    subjects_cart_good=load(strcat('Data/extraction/CartLeftArm/manip',num2str(i),'_CLA_good'));
    good_subjects=[];
    
    % Find subject with forces end trajectories data
    if (length(subjects_force_good)>=length(subjects_cart_good))
        for j=1:length(subjects_force_good)
            h=find(subjects_cart_good==subjects_force_good(j));
            if (h>0)
                good_subjects=[good_subjects ; subjects_force_good(j)];
            end
        end
    end
    
    if (length(subjects_force_good)<length(subjects_cart_good))
        for j=1:length(subjects_cart_good)
            h=find(subjects_force_good==subjects_cart_good(j));
            if (h>0)
                good_subjects=[good_subjects ; subjects_cart_good(j)];
            end
        end
    end
    
    
    
    
    
    for j=1:length(good_subjects) % For each good subject
        
        % Forces and trajectories loading
        left.trial{i}.subject{j}.vector_force_x=[];
        left.trial{i}.subject{j}.vector_force_y=[];
        left.trial{i}.subject{j}.vector_force_z=[];
        left.trial{i}.subject{j}.vector_force_x_filtered=[];
        left.trial{i}.subject{j}.vector_force_y_filtered=[];
        left.trial{i}.subject{j}.vector_force_z_filtered=[];
        left.trial{i}.subject{j}.vector_cart_x=[];
        left.trial{i}.subject{j}.vector_cart_y=[];
        left.trial{i}.subject{j}.vector_cart_z=[];
        left.trial{i}.subject{j}.vector_cart_x_filtered=[];
        left.trial{i}.subject{j}.vector_cart_y_filtered=[];
        left.trial{i}.subject{j}.vector_cart_z_filtered=[];
        left.trial{i}.subject{j}.vector_stiffness=[];
        
        left.trial{i}.subject{j}.vector_force_x=load(strcat('Data/extraction/leftArmEndEffector/',num2str(good_subjects(j)),'/fx_manip',num2str(i)));
        left.trial{i}.subject{j}.vector_force_y=load(strcat('Data/extraction/leftArmEndEffector/',num2str(good_subjects(j)),'/fy_manip',num2str(i)));
        left.trial{i}.subject{j}.vector_force_z=load(strcat('Data/extraction/leftArmEndEffector/',num2str(good_subjects(j)),'/fz_manip',num2str(i)));
        
        left.trial{i}.subject{j}.vector_cart_x=load(strcat('Data/extraction/CartLeftArm/',num2str(good_subjects(j)),'/posx_manip',num2str(i)));
        left.trial{i}.subject{j}.vector_cart_y=load(strcat('Data/extraction/CartLeftArm/',num2str(good_subjects(j)),'/posy_manip',num2str(i)));
        left.trial{i}.subject{j}.vector_cart_z=load(strcat('Data/extraction/CartLeftArm/',num2str(good_subjects(j)),'/posz_manip',num2str(i)));
        
        
        %         % Trajectory resultant
        %         for k=1:length(vector_cart_x)
        %             left.trial{i}.subject{j}.vector_cart=[left.trial{i}.subject{j}.vector_cart ; sqrt(vector_cart_x(k)^2+vector_cart_y(k)^2+vector_cart_z(k)^2)];
        %         end
        %
        
        % FILTERS
        
        if flag_filter_iterations_plot==1
            fig = figure(j);
            set(fig,'PaperPositionMode', 'auto', 'Units', 'Normalized', 'Position', [0 0 1 1]);
        end
        
        
        % Force
        
        if flag_filter_iterations_plot==1
            subplot(2,2,1)
            plot(left.trial{i}.subject{j}.vector_force_x)
        end
        
        [B,A] = butter(3,0.01);
        
        if flag_bypass_force_filter==0;
            
            left.trial{i}.subject{j}.vector_force_x_filtered=filter(B,A,left.trial{i}.subject{j}.vector_force_x);
            left.trial{i}.subject{j}.vector_force_y_filtered=filter(B,A,left.trial{i}.subject{j}.vector_force_y);
            left.trial{i}.subject{j}.vector_force_z_filtered=filter(B,A,left.trial{i}.subject{j}.vector_force_z);
            
            if flag_filter_iterations_plot==1
                subplot(2,2,2)
                plot(left.trial{i}.subject{j}.vector_force_x_filtered)
            end
            
        end
        
        
        
        
        % Trajectory
        
        if flag_filter_iterations_plot==1
            subplot(2,2,3)
            plot(left.trial{i}.subject{j}.vector_cart_x)
        end
        
        [B,A] = butter(3,0.01);
        
        if flag_bypass_cart_filter==0;
            
            left.trial{i}.subject{j}.vector_cart_x_filtered=filter(B,A,left.trial{i}.subject{j}.vector_cart_x);
            left.trial{i}.subject{j}.vector_cart_y_filtered=filter(B,A,left.trial{i}.subject{j}.vector_cart_y);
            left.trial{i}.subject{j}.vector_cart_z_filtered=filter(B,A,left.trial{i}.subject{j}.vector_cart_z);
            
            if flag_filter_iterations_plot==1
                subplot(2,2,4)
                plot(left.trial{i}.subject{j}.vector_cart_x_filtered)
            end
            
        end
        
        
        
        % Stifness vector
        
        if length(left.trial{i}.subject{j}.vector_cart_x_filtered)>length(left.trial{i}.subject{j}.vector_force_x_filtered)
            disp('Problem : Force vector size must be longer, it is needed to add new "if" taking account that cart vector is longer')
        end
        
        
        if length(left.trial{i}.subject{j}.vector_cart_x_filtered)<length(left.trial{i}.subject{j}.vector_force_x_filtered)
            
            for k=1:(floor(length(left.trial{i}.subject{j}.vector_cart_x_filtered)/delta_stiff))
                stiff_x=abs(left.trial{i}.subject{j}.vector_force_x_filtered(delta_stiff*k)-left.trial{i}.subject{j}.vector_force_x_filtered(delta_stiff*(k-1)+1))...
                    /abs(left.trial{i}.subject{j}.vector_cart_x_filtered(delta_stiff*k)-left.trial{i}.subject{j}.vector_cart_x_filtered(delta_stiff*(k-1)+1));
                stiff_y=abs(left.trial{i}.subject{j}.vector_force_y_filtered(delta_stiff*k)-left.trial{i}.subject{j}.vector_force_y_filtered(delta_stiff*(k-1)+1))...
                    /abs(left.trial{i}.subject{j}.vector_cart_y_filtered(delta_stiff*k)-left.trial{i}.subject{j}.vector_cart_y_filtered(delta_stiff*(k-1)+1));
                stiff_z=abs(left.trial{i}.subject{j}.vector_force_z_filtered(delta_stiff*k)-left.trial{i}.subject{j}.vector_force_z_filtered(delta_stiff*(k-1)+1))...
                    /abs(left.trial{i}.subject{j}.vector_cart_z_filtered(delta_stiff*k)-left.trial{i}.subject{j}.vector_cart_z_filtered(delta_stiff*(k-1)+1));
      
                
                left.trial{i}.subject{j}.vector_stiffness=[left.trial{i}.subject{j}.vector_stiffness ; (stiff_x+stiff_y+stiff_z)/3];
            end
        end
        
        % Stiffness plot
        
        fig = figure(200);
        set(fig,'PaperPositionMode', 'auto', 'Units', 'Normalized', 'Position', [0 0 1 1]);
        subplot(6,6,j)
        plot(left.trial{i}.subject{j}.vector_stiffness)
        
        
    end
    
    
end

saveas(gca,strcat('Data/results/leftArm_stifftness.png'));
