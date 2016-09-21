%% Smoothness
% Script to calculate participant smoothness and generate the plots of
% correlation between smoothness and profile of participants, across the
% three trials of collaborative assembly with iCub.
%
% authors: Anthony Voilque & Serena Ivaldi (serena.ivaldi@inria.fr)

clear all;
close all
clc;


% Subjects informations
subjects_profiles=load('Data/subjects_profiles');

% Filter parameters
flag_bypass_filter=0;
[B,A] = butter(3,0.01);

% Plot parameters
plot_fontsize=15;
plot_fontsize_title=25;
plot_fontsize_corr=9;


for i=1:3 % Trial
    
    subjects_good=load(strcat('Data/extraction/CartLeftArm/manip',num2str(i),'_CLA_good'));
    left.trial{i}.smoothness_vector=[];
    left.trial{i}.smoothness_age=[];
    left.trial{i}.smoothness_SRE=[];
    left.trial{i}.smoothness_extro=[];
    left.trial{i}.smoothness_NARS=[];
    left.trial{i}.smoothness_NS1=[];
    left.trial{i}.smoothness_NS2=[];
    left.trial{i}.smoothness_NS3=[];
    
    
    for j=1:length(subjects_good) % For each good subject
        
        left.trial{i}.subject{j}.vector{1}=[]; % x
        left.trial{i}.subject{j}.vector{2}=[]; % y
        left.trial{i}.subject{j}.vector{3}=[]; % z
        
        % Vector loading
        left.trial{i}.subject{j}.vector{1}=load(strcat('Data/extraction/CartLeftArm/',...
            num2str(subjects_good(j)),'/posx_manip',num2str(i)));
        left.trial{i}.subject{j}.vector{2}=load(strcat('Data/extraction/CartLeftArm/',...
            num2str(subjects_good(j)),'/posy_manip',num2str(i)));
        left.trial{i}.subject{j}.vector{3}=load(strcat('Data/extraction/CartLeftArm/',...
            num2str(subjects_good(j)),'/posz_manip',num2str(i)));
        
        for k=1:3 % For each coordonate of the trajectory vector (3 translations and 4 quaternions)
            
            
            % Filter
            if flag_bypass_filter==0;
                
                left.trial{i}.subject{j}.vector_filtered{k}=...
                    filter(B,A,left.trial{i}.subject{j}.vector{k});
                
            end
        end
        
        
        % Timestamp
        left.trial{i}.subject{j}.timestamp_filtered=[];
        time=0;
        for t=1:length(left.trial{i}.subject{j}.vector_filtered{1})
            left.trial{i}.subject{j}.timestamp_filtered=[left.trial{i}.subject{j}.timestamp_filtered;...
                time];
            time=time+0.01; % Seconde
        end
        
        if (length(left.trial{i}.subject{j}.vector_filtered{2})~=length(left.trial{i}.subject{j}.timestamp_filtered))
            error('timestamp and vectors must have the same length');
        end
        
        
        
        % Smoothness
        
        smoothness_value=0;
        for k=1:3
            
            dv=diff(left.trial{i}.subject{j}.vector_filtered{k});
            dt=diff(left.trial{i}.subject{j}.timestamp_filtered);
            
            d2v=diff(dv);
            
            intV = trapz(abs(dv./dt.^2).^2);
            T = ((left.trial{i}.subject{j}.timestamp_filtered(end) - ...
                left.trial{i}.subject{j}.timestamp_filtered(1))).^5;
            Vpeak = max(diff(left.trial{i}.subject{j}.vector_filtered{k})).^2;
            
            left.trial{i}.subject{j}.DLJ{k} = (-T/Vpeak) * intV;
            left.trial{i}.subject{j}.LDLJ{k} = -log(abs(left.trial{i}.subject{j}.DLJ{k}));
            
            % Create vector with all mean smoothness value
            smoothness_value=smoothness_value+left.trial{i}.subject{j}.LDLJ{k};
            
        end
        
        mean_smoothness=smoothness_value/3;
        
        % Create the smoothness vector
        left.trial{i}.smoothness_vector=[left.trial{i}.smoothness_vector; mean_smoothness];
        
        
        f=find(subjects_profiles(:,1)==subjects_good(j));
        % Create the indices vector to identify age
        left.trial{i}.smoothness_age=[left.trial{i}.smoothness_age; subjects_profiles(f,4)];
        
        % Create the indices vector to identify SRE
        left.trial{i}.smoothness_SRE=[left.trial{i}.smoothness_SRE; subjects_profiles(f,5)];
        
        % Create the indices vector to identify extroversion
        left.trial{i}.smoothness_extro=[left.trial{i}.smoothness_extro; subjects_profiles(f,6)];
        
        % Create the indices vector to identify NARS
        left.trial{i}.smoothness_NARS=[left.trial{i}.smoothness_NARS; subjects_profiles(f,7)];
        
        % Create the indices vector to identify NS1
        left.trial{i}.smoothness_NS1=[left.trial{i}.smoothness_NS1; subjects_profiles(f,8)];
        
        % Create the indices vector to identify NS2
        left.trial{i}.smoothness_NS2=[left.trial{i}.smoothness_NS2; subjects_profiles(f,9)];
        
        % Create the indices vector to identify NS3
        left.trial{i}.smoothness_NS3=[left.trial{i}.smoothness_NS3; subjects_profiles(f,10)];
        
    end
    
end


%% Correlation

fig = figure;
set(fig,'PaperPositionMode', 'auto', 'Units', 'Normalized', 'Position', [0 0 1 1]);

for i=1:3 % Trial
    
    
    
    % Age
    curPlot=subplot(3,7,7*(i-1)+1);
    sf=fit(left.trial{i}.smoothness_age,left.trial{i}.smoothness_vector,'poly1')
    plot(sf,left.trial{i}.smoothness_age,left.trial{i}.smoothness_vector,'.','predfunc')
    [correl, pval] = corr(left.trial{i}.smoothness_age,left.trial{i}.smoothness_vector,'type','Pearson');
    [rho, pvalrho] = corr(left.trial{i}.smoothness_age,left.trial{i}.smoothness_vector,'type','Spearman');
    xlabel('Age','FontSize',plot_fontsize,'Position',[40 -33*i^5])
    ylabel('Smoothness','FontSize',plot_fontsize)
    axis([17 65 -53 -37])
    
    title(strcat('Trial ',num2str(i)),'FontSize',plot_fontsize_title,'Position',[-30 -45])
    
    textPearson=strcat('P : r= ',num2str(correl),' p= ',num2str(pval));
    textSpearman=strcat('S : rho= ',num2str(rho),' p= ',num2str(pvalrho));
    textcorr=sprintf('%s \n%s',textPearson,textSpearman);
    text('String',textcorr,'FontSize',plot_fontsize_corr,'Parent',curPlot,'Position',[17 -56]);
    
    % SRE
    curPlot=subplot(3,7,7*(i-1)+2);
    sf=fit(left.trial{i}.smoothness_SRE,left.trial{i}.smoothness_vector,'poly1')
    plot(sf,left.trial{i}.smoothness_SRE,left.trial{i}.smoothness_vector,'.','predfunc')
    [correl, pval] = corr(left.trial{i}.smoothness_SRE,left.trial{i}.smoothness_vector,'type','Pearson');
    [rho, pvalrho] = corr(left.trial{i}.smoothness_SRE,left.trial{i}.smoothness_vector,'type','Spearman');
    xlabel('SRE','FontSize',plot_fontsize,'Position',[0.5 -33*i^5])
    ylabel('Smoothness','FontSize',plot_fontsize)
    axis([0 1 -53 -37])
    
    textPearson=strcat('P : r= ',num2str(correl),' p= ',num2str(pval));
    textSpearman=strcat('S : rho= ',num2str(rho),' p= ',num2str(pvalrho));
    textcorr=sprintf('%s \n%s',textPearson,textSpearman);
    text('String',textcorr,'FontSize',plot_fontsize_corr,'Parent',curPlot,'Position',[0 -56]);
    
    % Extroversion
    curPlot=subplot(3,7,7*(i-1)+3);
    sf=fit(left.trial{i}.smoothness_extro,left.trial{i}.smoothness_vector,'poly1')
    plot(sf,left.trial{i}.smoothness_extro,left.trial{i}.smoothness_vector,'.','predfunc')
    [correl, pval] = corr(left.trial{i}.smoothness_extro,left.trial{i}.smoothness_vector,'type','Pearson');
    [rho, pvalrho] = corr(left.trial{i}.smoothness_extro,left.trial{i}.smoothness_vector,'type','Spearman');
    xlabel('Extro','FontSize',plot_fontsize,'Position',[105 -33*i^5])
    ylabel('Smoothness','FontSize',plot_fontsize)
    axis([55 170 -53 -37])
    
    textPearson=strcat('P : r= ',num2str(correl),' p= ',num2str(pval));
    textSpearman=strcat('S : rho= ',num2str(rho),' p= ',num2str(pvalrho));
    textcorr=sprintf('%s \n%s',textPearson,textSpearman);
    text('String',textcorr,'FontSize',plot_fontsize_corr,'Parent',curPlot,'Position',[55 -56]);
    
    % NARS
    curPlot=subplot(3,7,7*(i-1)+4);
    sf=fit(left.trial{i}.smoothness_NARS,left.trial{i}.smoothness_vector,'poly1')
    plot(sf,left.trial{i}.smoothness_NARS,left.trial{i}.smoothness_vector,'.','predfunc')
    [correl, pval] = corr(left.trial{i}.smoothness_NARS,left.trial{i}.smoothness_vector,'type','Pearson');
    [rho, pvalrho] = corr(left.trial{i}.smoothness_NARS,left.trial{i}.smoothness_vector,'type','Spearman');
    xlabel('NARS','FontSize',plot_fontsize,'Position',[50 -33*i^5])
    ylabel('Smoothness','FontSize',plot_fontsize)
    axis([17 90 -53 -37])
    
    textPearson=strcat('P : r= ',num2str(correl),' p= ',num2str(pval));
    textSpearman=strcat('S : rho= ',num2str(rho),' p= ',num2str(pvalrho));
    textcorr=sprintf('%s \n%s',textPearson,textSpearman);
    text('String',textcorr,'FontSize',plot_fontsize_corr,'Parent',curPlot,'Position',[17 -56]);
    
    % NS1
    curPlot=subplot(3,7,7*(i-1)+5);
    sf=fit(left.trial{i}.smoothness_NS1,left.trial{i}.smoothness_vector,'poly1')
    plot(sf,left.trial{i}.smoothness_NS1,left.trial{i}.smoothness_vector,'.','predfunc')
    [correl, pval] = corr(left.trial{i}.smoothness_NS1,left.trial{i}.smoothness_vector,'type','Pearson');
    [rho, pvalrho] = corr(left.trial{i}.smoothness_NS1,left.trial{i}.smoothness_vector,'type','Spearman');
    xlabel('NS1','FontSize',plot_fontsize,'Position',[20 -33*i^5])
    ylabel('Smoothness','FontSize',plot_fontsize)
    axis([5 35 -53 -37])
    
    textPearson=strcat('P : r= ',num2str(correl),' p= ',num2str(pval));
    textSpearman=strcat('S : rho= ',num2str(rho),' p= ',num2str(pvalrho));
    textcorr=sprintf('%s \n%s',textPearson,textSpearman);
    text('String',textcorr,'FontSize',plot_fontsize_corr,'Parent',curPlot,'Position',[5 -56]);
    
    % NS2
    curPlot=subplot(3,7,7*(i-1)+6);
    sf=fit(left.trial{i}.smoothness_NS2,left.trial{i}.smoothness_vector,'poly1')
    plot(sf,left.trial{i}.smoothness_NS2,left.trial{i}.smoothness_vector,'.','predfunc')
    [correl, pval] = corr(left.trial{i}.smoothness_NS2,left.trial{i}.smoothness_vector,'type','Pearson');
    [rho, pvalrho] = corr(left.trial{i}.smoothness_NS2,left.trial{i}.smoothness_vector,'type','Spearman');
    xlabel('NS2','FontSize',plot_fontsize,'Position',[20 -33*i^5])
    ylabel('Smoothness','FontSize',plot_fontsize)
    axis([5 35 -53 -37])
    
    textPearson=strcat('P : r= ',num2str(correl),' p= ',num2str(pval));
    textSpearman=strcat('S : rho= ',num2str(rho),' p= ',num2str(pvalrho));
    textcorr=sprintf('%s \n%s',textPearson,textSpearman);
    text('String',textcorr,'FontSize',plot_fontsize_corr,'Parent',curPlot,'Position',[5 -56]);
    
    % NS3
    curPlot=subplot(3,7,7*(i-1)+7);
    sf=fit(left.trial{i}.smoothness_NS3,left.trial{i}.smoothness_vector,'poly1')
    plot(sf,left.trial{i}.smoothness_NS3,left.trial{i}.smoothness_vector,'.','predfunc')
    [correl, pval] = corr(left.trial{i}.smoothness_NS3,left.trial{i}.smoothness_vector,'type','Pearson');
    [rho, pvalrho] = corr(left.trial{i}.smoothness_NS3,left.trial{i}.smoothness_vector,'type','Spearman');
    xlabel('NS3','FontSize',plot_fontsize,'Position',[10 -33*i^5])
    ylabel('Smoothness','FontSize',plot_fontsize)
    axis([0 20 -53 -37])
    
    textPearson=strcat('P : r= ',num2str(correl),' p= ',num2str(pval));
    textSpearman=strcat('S : rho= ',num2str(rho),' p= ',num2str(pvalrho));
    textcorr=sprintf('%s \n%s',textPearson,textSpearman);
    text('String',textcorr,'FontSize',plot_fontsize_corr,'Parent',curPlot,'Position',[0 -56]);
    
    
end

saveas(gca,strcat('Data/results/leftArm_correlation_smoothness.png'));



%% BOXPLOT
smoothness_vector=[];
trial_indices=[];

for i=1:3
        
        
        % Create the smoothness vector
        smoothness_vector=[smoothness_vector; left.trial{i}.smoothness_vector];
        
        % Create the indices vector to identify trial
        for k=1:length(left.trial{i}.smoothness_vector)
            trial_indices=[trial_indices; num2str(i)];
        end
    
end

fig = figure;
set(fig,'PaperPositionMode', 'auto', 'Units', 'Normalized', 'Position', [0 0 1 1]);

boxplot(smoothness_vector,trial_indices);
xlabel('Trial','FontSize',30)
ylabel('Mean smoothness','FontSize',30)
title('Smoothness','FontSize',40)
saveas(gca,'Data/results/boxplot/leftArm_smoothness.png');


















