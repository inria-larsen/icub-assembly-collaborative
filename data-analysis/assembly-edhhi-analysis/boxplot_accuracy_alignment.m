%% Accuracy of alignment
% Script to generate boxplots about accuracy of participants, across 
% the three trials of collaborative assembly task with iCub.
%
% authors: Anthony Voilque & Serena Ivaldi (serena.ivaldi@inria.fr)

clear all
close all
clc

% Parameters
num_endValue=100;

vector_mean_x=[];
vector_mean_y=[];
vector_mean_z=[];

indices=[];

for i=1:3
    
    subjects_cart_good=load(strcat('Data/extraction/CartLeftArm/manip',num2str(i),'_CLA_good'));
    
    for j=1:length(subjects_cart_good)
        
        % Position data loading
        vector_cart_x=load(strcat('Data/extraction/CartLeftArm/',num2str(subjects_cart_good(j)),'/posx_manip',num2str(i)));
        vector_cart_y=load(strcat('Data/extraction/CartLeftArm/',num2str(subjects_cart_good(j)),'/posy_manip',num2str(i)));
        vector_cart_z=load(strcat('Data/extraction/CartLeftArm/',num2str(subjects_cart_good(j)),'/posz_manip',num2str(i)));
        
        mean_x=0; mean_y=0; mean_z=0;
        
        for k=0:num_endValue
            mean_x=mean_x+vector_cart_x(length(vector_cart_x)-k);
            mean_y=mean_y+vector_cart_y(length(vector_cart_y)-k);
            mean_z=mean_z+vector_cart_z(length(vector_cart_z)-k);
        end
        
        mean_x=mean_x/num_endValue;
        mean_y=mean_y/num_endValue;
        mean_z=mean_z/num_endValue;
        
        % Vectors
        indices=[indices; i];
        
        vector_mean_x=[vector_mean_x; mean_x];
        vector_mean_y=[vector_mean_y; mean_y];
        vector_mean_z=[vector_mean_z; mean_z];
        
        


    end
end


% Boxplot

fig = figure;
set(fig,'PaperPositionMode', 'auto', 'Units', 'Normalized', 'Position', [0 0 1 1]);

% X position
subplot(1,3,1)
boxplot(vector_mean_x,indices);
xlabel('Trial')
ylabel('Final postion X')
title('Postion X')
% saveas(gcf,'Data/results/boxplot/age/leftArm_trial_forceMax.png');

% Y position
subplot(1,3,2)
boxplot(vector_mean_y,indices);
xlabel('Trial')
ylabel('Final postion Y')
title('Postion Y')


% Z position
subplot(1,3,3)
boxplot(vector_mean_z,indices);
xlabel('Trial')
ylabel('Final postion Z')
title('Postion Z')

        
        
        
        
        
        
        
        
        
        
        
        
        
        
        
        
        
        