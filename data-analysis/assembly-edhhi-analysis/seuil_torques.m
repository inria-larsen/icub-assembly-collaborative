%% Affiche les courbes de tendances pour voir s'il y a des seuils communs.
close all
clear all
% Filter parameters
[B,A] = butter(3,0.01);

for i=1:3
    
    figure (i);
    set(figure (i),'PaperPositionMode', 'auto', 'Units', 'Normalized', 'Position', [0 0 1 1]);
    
    good_sub=load(strcat('Data/extraction/leftArmTorques/manip',num2str(i),'_LAT_good'));

    % Aller chercher les courbes des sujets
    for sub=1:length(good_sub)
        resultante_filt=[];
        resultante=[];
        sommeq=[];
        for j=1:2 % Load all joins and calculate the resutante
            join.j{j}=[];
            join.j{j}=load(strcat('Data/extraction/leftArmTorques/',num2str(good_sub(sub)),'/join',num2str(j),'_manip',num2str(i)));
            sommeq=[sommeq abs(join.j{j})]; % Quadratic somme
        end
        resultante=sum(sommeq(:,:),2);
        resultante_filt=filter(B,A,resultante);
        figure (i)
        subplot(6,7,sub)
        plot(resultante_filt)

    end
    
    figure (i)
    saveas(gca,strcat('Data/results/seuil/manip_',num2str(i),'_torques.png'));

end