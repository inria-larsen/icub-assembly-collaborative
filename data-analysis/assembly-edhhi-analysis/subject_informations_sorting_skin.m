%% Subjects informations for skin sensors
% Script to sort subjects by trial according to their profile.
%
% authors: Anthony Voilque & Serena Ivaldi (serena.ivaldi@inria.fr)

profiles=load('Data/subjects_profiles');
N_sub=length(profiles);





%% Age

age_subjects=[profiles(:,1) profiles(:,4)];

if(exist('Data/extraction/leftSkinForearm/age')==0)
        mkdir('Data/extraction/leftSkinForearm/age');
end

for manip=1:3
    
    % Left arm end effector
    
    good_sub=[];
    good_sub=load(strcat('Data/extraction/leftSkinForearm/manip',num2str(manip),'_LSF_good'));
    
    age_subjects_good=[];
  
    for sub=1:N_sub
        k=find(good_sub==age_subjects(sub,1));
        if k>=1
            age_subjects_good=[age_subjects_good; age_subjects(sub,:)]; % if the subject is in the good-ones list, his number and age are written 
        end
    end
    
    dlmwrite(strcat('Data/extraction/leftSkinForearm/age/manip',num2str(manip),'_age_subjects_good'),age_subjects_good,'delimiter',' ');
        
    
    
    % Right arm end effector
    if(exist('Data/extraction/rightSkinForearm/age')==0)
        mkdir('Data/extraction/rightSkinForearm/age');
    end
    good_sub=[];
    good_sub=load(strcat('Data/extraction/rightSkinForearm/manip',num2str(manip),'_RSF_good'));
    
    age_subjects_good=[];
  
    for sub=1:N_sub
        k=find(good_sub==age_subjects(sub,1));
        if k>=1
            age_subjects_good=[age_subjects_good; age_subjects(sub,:)]; % if the subject is in the good-ones list, his number and age are written 
        end
    end
    
    dlmwrite(strcat('Data/extraction/rightSkinForearm/age/manip',num2str(manip),'_age_subjects_good'),age_subjects_good,'delimiter',' ');
    
end





%% Gender

gender_subjects=[profiles(:,1) profiles(:,2)];

if(exist('Data/extraction/leftSkinForearm/gender')==0)
        mkdir('Data/extraction/leftSkinForearm/gender');
end

for manip=1:3
    
    % Left arm end effector
    
    good_sub=[];
    good_sub=load(strcat('Data/extraction/leftSkinForearm/manip',num2str(manip),'_LSF_good'));
    
    gender_subjects_good=[];
  
    for sub=1:N_sub
        k=find(good_sub==gender_subjects(sub,1));
        if k>=1
            gender_subjects_good=[gender_subjects_good; gender_subjects(sub,:)]; % if the subject is in the good-ones list, his number and gender are written 
        end
    end
    
    dlmwrite(strcat('Data/extraction/leftSkinForearm/gender/manip',num2str(manip),'_gender_subjects_good'),gender_subjects_good,'delimiter',' ');
        
    
    
    % Right arm end effector
    if(exist('Data/extraction/rightSkinForearm/gender')==0)
        mkdir('Data/extraction/rightSkinForearm/gender');
    end
    good_sub=[];
    good_sub=load(strcat('Data/extraction/rightSkinForearm/manip',num2str(manip),'_RSF_good'));
    
    gender_subjects_good=[];
  
    for sub=1:N_sub
        k=find(good_sub==gender_subjects(sub,1));
        if k>=1
            gender_subjects_good=[gender_subjects_good; gender_subjects(sub,:)]; % if the subject is in the good-ones list, his number and gender are written 
        end
    end
    
    dlmwrite(strcat('Data/extraction/rightSkinForearm/gender/manip',num2str(manip),'_gender_subjects_good'),gender_subjects_good,'delimiter',' ');
    
end




%% Extroversion

extro_subjects=[profiles(:,1) profiles(:,6)];

if(exist('Data/extraction/leftSkinForearm/extroversion')==0)
        mkdir('Data/extraction/leftSkinForearm/extroversion');
end

for manip=1:3
    
    % Left arm end effector
    
    good_sub=[];
    good_sub=load(strcat('Data/extraction/leftSkinForearm/manip',num2str(manip),'_LSF_good'));
    
    extro_subjects_good=[];
  
    for sub=1:N_sub
        k=find(good_sub==extro_subjects(sub,1));
        if k>=1
            extro_subjects_good=[extro_subjects_good; extro_subjects(sub,:)]; % if the subject is in the good-ones list, his number and age are written 
        end
    end
    
    dlmwrite(strcat('Data/extraction/leftSkinForearm/extroversion/manip',num2str(manip),'_extro_subjects_good'),extro_subjects_good,'delimiter',' ');
        
    
    
    % Right arm end effector
    if(exist('Data/extraction/rightSkinForearm/extroversion')==0)
        mkdir('Data/extraction/rightSkinForearm/extroversion');
    end
    good_sub=[];
    good_sub=load(strcat('Data/extraction/rightSkinForearm/manip',num2str(manip),'_RSF_good'));
    
    extro_subjects_good=[];
  
    for sub=1:N_sub
        k=find(good_sub==extro_subjects(sub,1));
        if k>=1
            extro_subjects_good=[extro_subjects_good; extro_subjects(sub,:)]; % if the subject is in the good-ones list, his number and age are written 
        end
    end
    
    dlmwrite(strcat('Data/extraction/rightSkinForearm/extroversion/manip',num2str(manip),'_extro_subjects_good'),extro_subjects_good,'delimiter',' ');
    
end



%% Negative attitude

if(exist('Data/extraction/leftSkinForearm/negativeAtt')==0)
        mkdir('Data/extraction/leftSkinForearm/negativeAtt');
end

if(exist('Data/extraction/rightSkinForearm/negativeAtt')==0)
        mkdir('Data/extraction/rightSkinForearm/negativeAtt');
end


% NARS

if(exist('Data/extraction/leftSkinForearm/negativeAtt/NARS')==0)
        mkdir('Data/extraction/leftSkinForearm/negativeAtt/NARS');
end

if(exist('Data/extraction/rightSkinForearm/negativeAtt/NARS')==0)
        mkdir('Data/extraction/rightSkinForearm/negativeAtt/NARS');
end

neg_subjects=[];
neg_subjects=[profiles(:,1) profiles(:,7)];

for manip=1:3
    
    % Left arm end effector
    
    good_sub=[];
    good_sub=load(strcat('Data/extraction/leftSkinForearm/manip',num2str(manip),'_LSF_good'));
    
    neg_subjects_good=[];
  
    for sub=1:N_sub
        k=find(good_sub==neg_subjects(sub,1));
        if k>=1
            neg_subjects_good=[neg_subjects_good; neg_subjects(sub,:)]; % if the subject is in the good-ones list, his number and age are written 
        end
    end
    
    dlmwrite(strcat('Data/extraction/leftSkinForearm/negativeAtt/NARS/manip',num2str(manip),'_neg_subjects_good'),neg_subjects_good,'delimiter',' ');
        
    
    
    % Right arm end effector
    if(exist('Data/extraction/rightSkinForearm/negativeAtt')==0)
        mkdir('Data/extraction/rightSkinForearm/negativeAtt');
    end
    good_sub=[];
    good_sub=load(strcat('Data/extraction/rightSkinForearm/manip',num2str(manip),'_RSF_good'));
    
    neg_subjects_good=[];
  
    for sub=1:N_sub
        k=find(good_sub==neg_subjects(sub,1));
        if k>=1
            neg_subjects_good=[neg_subjects_good; neg_subjects(sub,:)]; % if the subject is in the good-ones list, his number and age are written 
        end
    end
    
    dlmwrite(strcat('Data/extraction/rightSkinForearm/negativeAtt/NARS/manip',num2str(manip),'_neg_subjects_good'),neg_subjects_good,'delimiter',' ');
    
end


% NS1
if(exist('Data/extraction/leftSkinForearm/negativeAtt/NS1')==0)
        mkdir('Data/extraction/leftSkinForearm/negativeAtt/NS1');
end

if(exist('Data/extraction/rightSkinForearm/negativeAtt/NS1')==0)
        mkdir('Data/extraction/rightSkinForearm/negativeAtt/NS1');
end

neg_subjects=[];
neg_subjects=[profiles(:,1) profiles(:,8)];

for manip=1:3
    
    % Left arm end effector
    
    good_sub=[];
    good_sub=load(strcat('Data/extraction/leftSkinForearm/manip',num2str(manip),'_LSF_good'));
    
    neg_subjects_good=[];
  
    for sub=1:N_sub
        k=find(good_sub==neg_subjects(sub,1));
        if k>=1
            neg_subjects_good=[neg_subjects_good; neg_subjects(sub,:)]; % if the subject is in the good-ones list, his number and age are written 
        end
    end
    
    dlmwrite(strcat('Data/extraction/leftSkinForearm/negativeAtt/NS1/manip',num2str(manip),'_neg_subjects_good'),neg_subjects_good,'delimiter',' ');
        
    
    
    % Right arm end effector
   
    good_sub=[];
    good_sub=load(strcat('Data/extraction/rightSkinForearm/manip',num2str(manip),'_RSF_good'));
    
    neg_subjects_good=[];
  
    for sub=1:N_sub
        k=find(good_sub==neg_subjects(sub,1));
        if k>=1
            neg_subjects_good=[neg_subjects_good; neg_subjects(sub,:)]; % if the subject is in the good-ones list, his number and age are written 
        end
    end
    
    dlmwrite(strcat('Data/extraction/rightSkinForearm/negativeAtt/NS1/manip',num2str(manip),'_neg_subjects_good'),neg_subjects_good,'delimiter',' ');
    
end

% NS2

if(exist('Data/extraction/leftSkinForearm/negativeAtt/NS2')==0)
        mkdir('Data/extraction/leftSkinForearm/negativeAtt/NS2');
end

if(exist('Data/extraction/rightSkinForearm/negativeAtt/NS2')==0)
        mkdir('Data/extraction/rightSkinForearm/negativeAtt/NS2');
end

neg_subjects=[];
neg_subjects=[profiles(:,1) profiles(:,9)];

for manip=1:3
    
    % Left arm end effector
    
    good_sub=[];
    good_sub=load(strcat('Data/extraction/leftSkinForearm/manip',num2str(manip),'_LSF_good'));
    
    neg_subjects_good=[];
  
    for sub=1:N_sub
        k=find(good_sub==neg_subjects(sub,1));
        if k>=1
            neg_subjects_good=[neg_subjects_good; neg_subjects(sub,:)]; % if the subject is in the good-ones list, his number and age are written 
        end
    end
    
    dlmwrite(strcat('Data/extraction/leftSkinForearm/negativeAtt/NS2/manip',num2str(manip),'_neg_subjects_good'),neg_subjects_good,'delimiter',' ');
        
    
    
    % Right arm end effector
    
    good_sub=[];
    good_sub=load(strcat('Data/extraction/rightSkinForearm/manip',num2str(manip),'_RSF_good'));
    
    neg_subjects_good=[];
  
    for sub=1:N_sub
        k=find(good_sub==neg_subjects(sub,1));
        if k>=1
            neg_subjects_good=[neg_subjects_good; neg_subjects(sub,:)]; % if the subject is in the good-ones list, his number and age are written 
        end
    end
    
    dlmwrite(strcat('Data/extraction/rightSkinForearm/negativeAtt/NS2/manip',num2str(manip),'_neg_subjects_good'),neg_subjects_good,'delimiter',' ');
    
end

% NS3

if(exist('Data/extraction/leftSkinForearm/negativeAtt/NS3')==0)
        mkdir('Data/extraction/leftSkinForearm/negativeAtt/NS3');
end

if(exist('Data/extraction/rightSkinForearm/negativeAtt/NS3')==0)
        mkdir('Data/extraction/rightSkinForearm/negativeAtt/NS3');
end

neg_subjects=[];
neg_subjects=[profiles(:,1) profiles(:,10)];

for manip=1:3
    
    % Left arm end effector
    
    good_sub=[];
    good_sub=load(strcat('Data/extraction/leftSkinForearm/manip',num2str(manip),'_LSF_good'));
    
    neg_subjects_good=[];
  
    for sub=1:N_sub
        k=find(good_sub==neg_subjects(sub,1));
        if k>=1
            neg_subjects_good=[neg_subjects_good; neg_subjects(sub,:)]; % if the subject is in the good-ones list, his number and age are written 
        end
    end
    
    dlmwrite(strcat('Data/extraction/leftSkinForearm/negativeAtt/NS3/manip',num2str(manip),'_neg_subjects_good'),neg_subjects_good,'delimiter',' ');
        
    
    
    % Right arm end effector
   
    good_sub=[];
    good_sub=load(strcat('Data/extraction/rightSkinForearm/manip',num2str(manip),'_RSF_good'));
    
    neg_subjects_good=[];
  
    for sub=1:N_sub
        k=find(good_sub==neg_subjects(sub,1));
        if k>=1
            neg_subjects_good=[neg_subjects_good; neg_subjects(sub,:)]; % if the subject is in the good-ones list, his number and age are written 
        end
    end
    
    dlmwrite(strcat('Data/extraction/rightSkinForearm/negativeAtt/NS3/manip',num2str(manip),'_neg_subjects_good'),neg_subjects_good,'delimiter',' ');
    
end





