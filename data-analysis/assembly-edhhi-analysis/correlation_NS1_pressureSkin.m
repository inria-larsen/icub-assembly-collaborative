%% Correlation negative attitude
% Script to generate the plots of correlation between skin pressure
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
plot_values_y=-2;
plot_xabs_x=7;
plot_xabs_y=-1;

% NS1
xmin=5;
xmax=35;

% Skin pressure
ymin=0;
ymax=10;


% LEFT ARM
if flag_left_arm ==1

    fig = figure;
    set(fig,'PaperPositionMode', 'auto', 'Units', 'Normalized', 'Position', [0 0 1 1]);

    for i=1:3 % Manipulation

        % Skin pressure
        good_sub=load(strcat('Data/extraction/leftSkinForearm/negativeAtt/NS1/manip',num2str(i),'_neg_subjects_good'));
        correlation_pressureMax=[];
        correlation_pressureMean=[];
        correlation_pressureMedian=[];

        for sub=1:size(good_sub)


            mat=[];
            mat=load(strcat('Data/extraction/leftSkinForearm/',num2str(good_sub(sub,1)),'/mean_manip',num2str(i)));
            % Pressure max
            max_mat=max(mat);
             correlation_pressureMax=[ correlation_pressureMax; good_sub(sub,2) max_mat];
            % Pressure mean
            mean_mat=mean(mat);
            correlation_pressureMean=[correlation_pressureMean; good_sub(sub,2) mean_mat];
            % Pressure median
            median_mat=median(mat);
            correlation_pressureMedian=[correlation_pressureMedian; good_sub(sub,2) median_mat];


        end

        disp(strcat('manipulation n. ',num2str(i)))       
        maxPressure_mean = mean(correlation_pressureMax(:,2));        disp(strcat('max_num_mean',num2str(maxPressure_mean)));
        maxPressure_median = median(correlation_pressureMax(:,2));    disp(strcat('max_num_median',num2str(maxPressure_mean)));
        maxPressure_stdev = std(correlation_pressureMax(:,2));        disp(strcat('max_num_stdev',num2str(maxPressure_mean)));
        maxPressure_min = min(correlation_pressureMax(:,2));          disp(strcat('max_num_stdev',num2str(maxPressure_min)));
        maxPressure_max = max(correlation_pressureMax(:,2));          disp(strcat('max_num_stdev',num2str(maxPressure_max)));

        
        % Graphics with fit curves

            % Pressure max
            curPlot=subplot(3,3,i);   
            sf=fit( correlation_pressureMax(:,1), correlation_pressureMax(:,2),'poly1')
            plot(sf, correlation_pressureMax(:,1), correlation_pressureMax(:,2),'.','predfunc')
            [correl, pval] = corr(correlation_pressureMax(:,1),correlation_pressureMax(:,2),'type','Pearson');
            [rho, pvalrho] = corr(correlation_pressureMax(:,1),correlation_pressureMax(:,2),'type','Spearman');  
            xlabel('NS1','FontSize',plot_fontsize,'Position',[plot_xabs_x plot_xabs_y])
            ylabel('Pressure max','FontSize',plot_fontsize)
            axis([xmin xmax ymin ymax])
            title(strcat('Trial ',num2str(i)),'FontSize',plot_fontsize_title) 
            
            textPearson=strcat('Pearson: r= ',num2str(correl),' p= ',num2str(pval));                   
            textSpearman=strcat('Spearman: rho= ',num2str(rho),' p= ',num2str(pvalrho));           
            textcorr=sprintf('%s \n%s',textPearson,textSpearman);
            text('String',textcorr,'FontSize',plot_fontsize_corr,'Parent',curPlot,'Position',[plot_values_x plot_values_y]);
            
            % Pressure mean
            curPlot=subplot(3,3,3+i); 
            sf=fit(correlation_pressureMean(:,1),correlation_pressureMean(:,2),'poly1')
            plot(sf,correlation_pressureMean(:,1),correlation_pressureMean(:,2),'.','predfunc')
            [correl, pval] = corr(correlation_pressureMean(:,1),correlation_pressureMean(:,2),'type','Pearson');
            [rho, pvalrho] = corr(correlation_pressureMean(:,1),correlation_pressureMean(:,2),'type','Spearman');
            xlabel('NS1','FontSize',plot_fontsize,'Position',[plot_xabs_x plot_xabs_y])
            ylabel('Pressure mean','FontSize',plot_fontsize)
            axis([xmin xmax ymin ymax])
            
            textPearson=strcat('Pearson: r= ',num2str(correl),' p= ',num2str(pval));                   
            textSpearman=strcat('Spearman: rho= ',num2str(rho),' p= ',num2str(pvalrho));           
            textcorr=sprintf('%s \n%s',textPearson,textSpearman);
            text('String',textcorr,'FontSize',plot_fontsize_corr,'Parent',curPlot,'Position',[plot_values_x plot_values_y]);
            
            % Pressure median
            curPlot=subplot(3,3,6+i);
            sf=fit(correlation_pressureMedian(:,1),correlation_pressureMedian(:,2),'poly1')
            plot(sf,correlation_pressureMedian(:,1),correlation_pressureMedian(:,2),'.','predfunc')
            [correl, pval] = corr(correlation_pressureMedian(:,1),correlation_pressureMedian(:,2),'type','Pearson');
            [rho, pvalrho] = corr(correlation_pressureMedian(:,1),correlation_pressureMedian(:,2),'type','Spearman');
            xlabel('NS1','FontSize',plot_fontsize,'Position',[plot_xabs_x plot_xabs_y])
            ylabel('Pressure median','FontSize',plot_fontsize)
            axis([xmin xmax ymin ymax])
            
            textPearson=strcat('Pearson: r= ',num2str(correl),' p= ',num2str(pval));                   
            textSpearman=strcat('Spearman: rho= ',num2str(rho),' p= ',num2str(pvalrho));           
            textcorr=sprintf('%s \n%s',textPearson,textSpearman);
            text('String',textcorr,'FontSize',plot_fontsize_corr,'Parent',curPlot,'Position',[plot_values_x plot_values_y]);
            
    end
    
    saveas(gcf,strcat('Data/results/leftArm_correlation_NS1_pressureSkin.png'));


end

%% RIGHT

if flag_right_arm ==1

    for i=2:3 % Manipulation

        % Arm End Effector
        good_sub=load(strcat('Data/extraction/rightSkinForearm/age/manip',num2str(i),'_age_subjects_good'));
         correlation_pressureMax=[];
        correlation_pressureMean=[];
        correlation_pressureMedian=[];

        for sub=1:size(good_sub)

            mat=[];
            mat=load(strcat('Data/extraction/rightSkinForearm/',num2str(good_sub(sub,1)),'/mean_manip',num2str(i)));
            % Force max
            max_mat=max(mat);
             correlation_pressureMax=[ correlation_pressureMax; good_sub(sub,2) max_mat];
            % Force mean
            mean_mat=mean(mat);
            correlation_pressureMean=[correlation_pressureMean; good_sub(sub,2) mean_mat];
            % Force median
            median_mat=median(mat);
            correlation_pressureMedian=[correlation_pressureMedian; good_sub(sub,2) median_mat];
        end


        % Graphics with fit curves

            % Force max
            figure
            sf=fit( correlation_pressureMax(:,1), correlation_pressureMax(:,2),'poly1')
            plot(sf, correlation_pressureMax(:,1), correlation_pressureMax(:,2),'.')
            xlabel('Age')
            ylabel('Pressure max')
            title(strcat('Correlation for manipulation',num2str(i),' - Maximum forces right hand'))
            saveas(gcf,strcat('Data/extraction/rightSkinForearm/correlation/manip',num2str(i),'_age_forceMax.png'));

            % Force mean
            figure
            sf=fit(correlation_pressureMean(:,1),correlation_pressureMean(:,2),'poly1')
            plot(sf,correlation_pressureMean(:,1),correlation_pressureMean(:,2),'.')
            xlabel('Age')
            ylabel('Pressure mean')
            title(strcat('Correlation for manipulation',num2str(i),' - Mean forces right hand'))
            saveas(gcf,strcat('Data/extraction/rightSkinForearm/correlation/manip',num2str(i),'_age_forceMean.png'));

            % Force median
            figure
            sf=fit(correlation_pressureMedian(:,1),correlation_pressureMedian(:,2),'poly1')
            plot(sf,correlation_pressureMedian(:,1),correlation_pressureMedian(:,2),'.')
            xlabel('Age')
            ylabel('Pressure median')
            title(strcat('Correlation for manipulation',num2str(i),' - Median forces right hand'))
            saveas(gcf,strcat('Data/extraction/rightSkinForearm/correlation/manip',num2str(i),'_age_forceMedian.png'));

    end

end