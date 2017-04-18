%% Affiche les courbes de tendances pour voir s'il y a des seuils communs.

figure (1); % untreated
set(figure (1),'PaperPositionMode', 'auto', 'Units', 'Normalized', 'Position', [0 0 1 1]);

figure (2); % Filtered
set(figure (2),'PaperPositionMode', 'auto', 'Units', 'Normalized', 'Position', [0 0 1 1]);

% Filter parameters
[B,A] = butter(3,0.01);

for i=1:3
    
    good_sub=load(strcat('Data/extraction/leftArmEndEffector/manip',num2str(i),'_LAEE_good'));

    % Aller chercher les courbes des sujets
    for sub=1:length(good_sub)
        mat=[];
        mat_filt=[];
        
        mat=load(strcat('Data/extraction/leftArmEndEffector/',num2str(good_sub(sub)),'/force_manip',num2str(i)));
        figure (1)
        subplot(6,7,sub)
        plot(mat)

        mat_filt=filter(B,A,mat);
        figure (2)
        subplot(6,7,sub)
        plot(mat_filt)

    end
    
    figure (1)
    saveas(gca,strcat('Data/results/seuil/manip_',num2str(i),'untreated.png'));

    figure (2)
    saveas(gca,strcat('Data/results/seuil/manip_',num2str(i),'filtered.png'));

end

%% Afficher les graphes selectionnés



good.mat{1}=[18 19 43 44 52 74 87 90 101 103 107 115 117];
good.mat{2}=[19 43 52 66 91 92 93 101 117 118 126];
good.mat{3}=[52 66 72 87 92 115 117 118];

% Filter parameters
[B,A] = butter(3,0.01);

for i=1:3
    
    figure (i);
    set(figure (i),'PaperPositionMode', 'auto', 'Units', 'Normalized', 'Position', [0 0 1 1]);
    good_sub=good.mat{i};

    % Aller chercher les courbes des sujets
    for sub=1:length(good_sub)
        mat=[];
        mat_filt=[];
        
        mat=load(strcat('Data/extraction/leftArmEndEffector/',num2str(good_sub(sub)),'/force_manip',num2str(i)))
        mat_filt=filter(B,A,mat);
        figure (i)
        subplot(5,4,sub)
        plot(mat_filt)

    end
    
    figure (i)
    saveas(gca,strcat('Data/results/seuil/manip',num2str(i),'_good.png'));

end














