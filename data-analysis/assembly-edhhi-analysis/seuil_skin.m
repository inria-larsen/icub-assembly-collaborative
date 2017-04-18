%% Affiche les courbes de tendances pour voir s'il y a des seuils communs.
close all
clear all
% Filter parameters
[B,A] = butter(3,0.01);

for i=1:3
    
    figure (i);
    set(figure (i),'PaperPositionMode', 'auto', 'Units', 'Normalized', 'Position', [0 0 1 1]);
    
    good_sub=load(strcat('Data/extraction/leftSkinForearm/manip',num2str(i),'_LSF_good'));

    % Aller chercher les courbes des sujets
    for sub=1:length(good_sub)
        
        mat=[];
        mat_filt=[];
        
        mat=load(strcat('Data/extraction/leftSkinForearm/',num2str(good_sub(sub)),'/mean_manip',num2str(i)));


        mat_filt=filter(B,A,mat);
        figure (i)
        subplot(6,6,sub)
        plot(mat_filt)

    end
    
    figure (i)
    saveas(gca,strcat('Data/results/seuil/manip_',num2str(i),'_skinPressure.png'));

end


%% Affiche les courbes de tendances pour voir s'il y a des seuils communs.
close all
clear all
% Filter parameters
[B,A] = butter(3,0.01);

for i=1:3
    
    figure (i);
    set(figure (i),'PaperPositionMode', 'auto', 'Units', 'Normalized', 'Position', [0 0 1 1]);
    
    good_sub=load(strcat('Data/extraction/leftSkinForearm/manip',num2str(i),'_LSF_good'));

    % Aller chercher les courbes des sujets
    for sub=1:length(good_sub)
        
        mat=[];
        mat_filt=[];
        
        mat=load(strcat('Data/extraction/leftSkinForearm/',num2str(good_sub(sub)),'/num_active_sensors_manip',num2str(i)));


        mat_filt=filter(B,A,mat);
        figure (i)
        subplot(6,6,sub)
        plot(mat_filt)

    end
    
    figure (i)
    saveas(gca,strcat('Data/results/seuil/manip_',num2str(i),'_skinNumber.png'));

end