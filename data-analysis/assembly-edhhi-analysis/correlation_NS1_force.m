%% Correlation negative attitude
% Script to generate the plots of correlation between end effector forces
% and NS1 of participants, across the three trials of collaborative
% assembly with iCub.
%
% authors: Anthony Voilque & Serena Ivaldi (serena.ivaldi@inria.fr)


clear all
close all


flag_left_arm=1;
flag_right_arm=0;

plot_fontsize=18;
plot_fontsize_title=24;
plot_fontsize_axis=24;
plot_fontsize_corr=10;

plot_values_x=20;
plot_values_y=-5;
plot_xabs_x=7;
plot_xabs_y=-3;

% NS1
xmin=5;
xmax=35;

% Force
ymin=0;
ymax=30;


% LEFT ARM
if flag_left_arm ==1

    fig = figure;
    set(fig,'PaperPositionMode', 'auto', 'Units', 'Normalized', 'Position', [0 0 1 1]);

    for i=1:3 % Manipulation

        % Arm End Effector
        good_sub=load(strcat('Data/extraction/leftArmEndEffector/negativeAtt/NS1/manip',num2str(i),'_neg_subjects_good'));
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

        disp(strcat('manipulation n. ',num2str(i)))       
        maxforce_mean = mean(correlation_forceMax(:,2));        disp(strcat('max_force_mean',num2str(maxforce_mean)));
        maxforce_median = median(correlation_forceMax(:,2));    disp(strcat('max_force_median',num2str(maxforce_mean)));
        maxforce_stdev = std(correlation_forceMax(:,2));        disp(strcat('max_force_stdev',num2str(maxforce_mean)));
        maxforce_min = min(correlation_forceMax(:,2));          disp(strcat('max_force_stdev',num2str(maxforce_min)));
        maxforce_max = max(correlation_forceMax(:,2));          disp(strcat('max_force_stdev',num2str(maxforce_max)));


        % Graphics with fit curves

            % Force max
            curPlot=subplot(3,3,i);   
            sf=fit(correlation_forceMax(:,1),correlation_forceMax(:,2),'poly1')
            plot(sf,correlation_forceMax(:,1),correlation_forceMax(:,2),'.','predfunc')
            [correl, pval] = corr(correlation_forceMax(:,1),correlation_forceMax(:,2),'type','Pearson');
            [rho, pvalrho] = corr(correlation_forceMax(:,1),correlation_forceMax(:,2),'type','Spearman');    
            xlabel('NS1','FontSize',plot_fontsize,'Position',[plot_xabs_x plot_xabs_y])
            ylabel('Force max','FontSize',plot_fontsize)
            axis([xmin xmax ymin ymax])
            title(strcat('Trial ',num2str(i)),'FontSize',plot_fontsize_title) 
            
            textPearson=strcat('Pearson: r= ',num2str(correl),' p= ',num2str(pval));                   
            textSpearman=strcat('Spearman: rho= ',num2str(rho),' p= ',num2str(pvalrho));           
            textcorr=sprintf('%s \n%s',textPearson,textSpearman);
            text('String',textcorr,'FontSize',plot_fontsize_corr,'Parent',curPlot,'Position',[plot_values_x plot_values_y]);    
            
            % Force mean
            curPlot=subplot(3,3,3+i); 
            sf=fit(correlation_forceMean(:,1),correlation_forceMean(:,2),'poly1')
            plot(sf,correlation_forceMean(:,1),correlation_forceMean(:,2),'.','predfunc')
            [correl, pval] = corr(correlation_forceMean(:,1),correlation_forceMean(:,2),'type','Pearson');
            [rho, pvalrho] = corr(correlation_forceMean(:,1),correlation_forceMean(:,2),'type','Spearman');
            xlabel('NS1','FontSize',plot_fontsize,'Position',[plot_xabs_x plot_xabs_y])
            ylabel('Force mean','FontSize',plot_fontsize)
            axis([xmin xmax ymin ymax])
            
            textPearson=strcat('Pearson: r= ',num2str(correl),' p= ',num2str(pval));                   
            textSpearman=strcat('Spearman: rho= ',num2str(rho),' p= ',num2str(pvalrho));           
            textcorr=sprintf('%s \n%s',textPearson,textSpearman);
            text('String',textcorr,'FontSize',plot_fontsize_corr,'Parent',curPlot,'Position',[plot_values_x plot_values_y]);    
            
            % Force median
            curPlot=subplot(3,3,6+i);
            sf=fit(correlation_forceMedian(:,1),correlation_forceMedian(:,2),'poly1')
            plot(sf,correlation_forceMedian(:,1),correlation_forceMedian(:,2),'.','predfunc')
            [correl, pval] = corr(correlation_forceMedian(:,1),correlation_forceMedian(:,2),'type','Pearson');
            [rho, pvalrho] = corr(correlation_forceMedian(:,1),correlation_forceMedian(:,2),'type','Spearman');
            xlabel('NS1','FontSize',plot_fontsize,'Position',[plot_xabs_x plot_xabs_y])
            ylabel('Force median','FontSize',plot_fontsize)
            axis([xmin xmax ymin ymax])
            
            textPearson=strcat('Pearson: r= ',num2str(correl),' p= ',num2str(pval));                   
            textSpearman=strcat('Spearman: rho= ',num2str(rho),' p= ',num2str(pvalrho));           
            textcorr=sprintf('%s \n%s',textPearson,textSpearman);
            text('String',textcorr,'FontSize',plot_fontsize_corr,'Parent',curPlot,'Position',[plot_values_x plot_values_y]);    
            
    end
    
    saveas(gcf,strcat('Data/results/leftArm_correlation_NS1_force.png'));


end

%% RIGHT

if flag_right_arm ==1

    for i=2:3 % Manipulation

        % Arm End Effector
        good_sub=load(strcat('Data/extraction/rightSkinForearm/age/manip',num2str(i),'_age_subjects_good'));
        correlation_forceMax=[];
        correlation_forceMean=[];
        correlation_forceMedian=[];

        for sub=1:size(good_sub)

            mat=[];
            mat=load(strcat('Data/extraction/rightSkinForearm/',num2str(good_sub(sub,1)),'/num_active_sensors_manip',num2str(i)));
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
            ylabel('Num max')
            title(strcat('Correlation for manipulation',num2str(i),' - Maximum forces right hand'))
            saveas(gcf,strcat('Data/extraction/rightSkinForearm/correlation/manip',num2str(i),'_age_forceMax.png'));

            % Force mean
            figure
            sf=fit(correlation_forceMean(:,1),correlation_forceMean(:,2),'poly1')
            plot(sf,correlation_forceMean(:,1),correlation_forceMean(:,2),'.')
            xlabel('Age')
            ylabel('Num mean')
            title(strcat('Correlation for manipulation',num2str(i),' - Mean forces right hand'))
            saveas(gcf,strcat('Data/extraction/rightSkinForearm/correlation/manip',num2str(i),'_age_forceMean.png'));

            % Force median
            figure
            sf=fit(correlation_forceMedian(:,1),correlation_forceMedian(:,2),'poly1')
            plot(sf,correlation_forceMedian(:,1),correlation_forceMedian(:,2),'.')
            xlabel('Age')
            ylabel('Num median')
            title(strcat('Correlation for manipulation',num2str(i),' - Median forces right hand'))
            saveas(gcf,strcat('Data/extraction/rightSkinForearm/correlation/manip',num2str(i),'_age_forceMedian.png'));

    end

end
