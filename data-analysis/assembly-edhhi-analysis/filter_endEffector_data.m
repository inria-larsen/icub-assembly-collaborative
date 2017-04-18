% Filter 
% Delete noisy data at the begining and at the end of record.
%
% authors: Anthony Voilque & Serena Ivaldi (serena.ivaldi@inria.fr)

function []=filter_endEffector_data(err_f,err_m,n)

% % Forces and torque post process


%% Left Arm
if(exist('Data/extraction/leftArmEndEffector/post_process')==0)
    mkdir(strcat('Data/extraction/leftArmEndEffector/post_process'));
end

manip=1;
for manip=1:3
    good_subjects=load(strcat('Data/extraction/leftArmEndEffector/manip',num2str(manip),'_LAEE_good'));
    N_sub=length(good_subjects);
    
    sub=1;
    for sub=1:N_sub
        
        if (exist(strcat('Data/extraction/leftArmEndEffector/post_process/',num2str((good_subjects(sub)))))==0)
            mkdir(strcat('Data/extraction/leftArmEndEffector/post_process/',num2str((good_subjects(sub)))));
        end
        
        % fx
        mat=[];
        mat=dlmread(strcat('Data/extraction/leftArmEndEffector/',num2str((good_subjects(sub))),'/fx_manip',num2str(manip)));
        N_mat=length(mat);
        
        %%% Beginning
        i=1;
        moy=0;
        for i=1:n
            moy=moy+mat(i,1);
        end
        moy=moy/n;
        
        m=0;
        c1=0;
        for m=1:N_mat
            
            if any([mat(m,1)>(moy-err_f),mat(m,1)<(moy+err_f)])
                c1=c1+1;
            end
            
            if any([mat(m,1)<(moy-err_f),mat(m,1)>(moy+err_f)])
                break
            end
        end
        
        
        %%% End
        i=0;
        moy=0;
        for i=0:n
            j=N_mat-i;
            moy=moy+mat(j,1);
        end
        moy=moy/n;
        
        m=0;
        c2=0;
        for m=0:N_mat-1
            j=N_mat-m;
            if any([mat(j,1)>(moy-err_f),mat(j,1)<(moy+err_f)])
                c2=c2+1;
            end
            
            if any([mat(j,1)<(moy-err_f),mat(j,1)>(moy+err_f)])
                break
            end
        end
        mat(N_mat-c2:N_mat,:)=[];
        mat(1:c1,:)=[];
        
        
        dlmwrite(strcat('Data/extraction/leftArmEndEffector/post_process/',num2str((good_subjects(sub))),'/pp_fx_manip',num2str(manip)),mat,'delimiter',' ');
        
        delta_fx=max(mat);
        mean_fx=mean(mat);
        
        
        % fy
        mat=[];
        mat=dlmread(strcat('Data/extraction/leftArmEndEffector/',num2str((good_subjects(sub))),'/fy_manip',num2str(manip)));
        N_mat=length(mat);
        
        %%% Beginning
        i=1;
        moy=0;
        for i=1:n
            moy=moy+mat(i,1);
        end
        moy=moy/n;
        
        m=0;
        c1=0;
        for m=1:N_mat
            
            if any([mat(m,1)>(moy-err_f),mat(m,1)<(moy+err_f)])
                c1=c1+1;
            end
            
            if any([mat(m,1)<(moy-err_f),mat(m,1)>(moy+err_f)])
                break
            end
        end
        
        %%% End
        i=1;
        moy=0;
        for i=0:n
            j=N_mat-i;
            moy=moy+mat(j,1);
        end
        moy=moy/n;
        
        m=0;
        c2=0;
        for m=0:N_mat-1
            j=N_mat-m;
            if any([mat(j,1)>(moy-err_f),mat(j,1)<(moy+err_f)])
                c2=c2+1;
            end
            
            if any([mat(j,1)<(moy-err_f),mat(j,1)>(moy+err_f)])
                break
            end
        end
        mat(N_mat-c2:N_mat,:)=[];
        mat(1:c1,:)=[];
        
        
        dlmwrite(strcat('Data/extraction/leftArmEndEffector/post_process/',num2str((good_subjects(sub))),'/pp_fy_manip',num2str(manip)),mat,'delimiter',' ');
        
        delta_fy=max(mat);
        mean_fy=mean(mat);
        
        % fz
        mat=[];
        mat=dlmread(strcat('Data/extraction/leftArmEndEffector/',num2str((good_subjects(sub))),'/fz_manip',num2str(manip)));
        N_mat=length(mat);
        
        %%% Beginning
        i=1;
        moy=0;
        for i=1:n
            moy=moy+mat(i,1);
        end
        moy=moy/n;
        
        m=0;
        c1=0;
        for m=1:N_mat
            
            if any([mat(m,1)>(moy-err_f),mat(m,1)<(moy+err_f)])
                c1=c1+1;
            end
            
            if any([mat(m,1)<(moy-err_f),mat(m,1)>(moy+err_f)])
                break
            end
        end
        
        %%% End
        i=1;
        moy=0;
        for i=0:n
            j=N_mat-i;
            moy=moy+mat(j,1);
        end
        moy=moy/n;
        
        m=0;
        c2=0;
        for m=0:N_mat-1
            j=N_mat-m;
            if any([mat(j,1)>(moy-err_f),mat(j,1)<(moy+err_f)])
                c2=c2+1;
            end
            
            if any([mat(j,1)<(moy-err_f),mat(j,1)>(moy+err_f)])
                break
            end
        end
        mat(N_mat-c2:N_mat,:)=[];
        mat(1:c1,:)=[];
        
        dlmwrite(strcat('Data/extraction/leftArmEndEffector/post_process/',num2str((good_subjects(sub))),'/pp_fz_manip',num2str(manip)),mat,'delimiter',' ');
        
        delta_fz=max(mat);
        mean_fz=mean(mat);
        
        delta_1=sqrt(delta_fx^2+delta_fy^2+delta_fz^2);
        dlmwrite(strcat('Data/extraction/leftArmEndEffector/post_process/',num2str(good_subjects(sub)),'/manip',num2str(manip),'_delta1F'),delta_1,'delimiter',' ');
        
               
        % mx
        mat=[];
        mat=dlmread(strcat('Data/extraction/leftArmEndEffector/',num2str((good_subjects(sub))),'/mx_manip',num2str(manip)));
        N_mat=length(mat);
        
        %%% Beginning
        i=1;
        moy=0;
        for i=1:n
            moy=moy+mat(i,1);
        end
        moy=moy/n;
        
        m=0;
        c1=0;
        for m=1:N_mat
            
            if any([mat(m,1)>(moy-err_m),mat(m,1)<(moy+err_m)])
                c1=c1+1;
            end
            
            if any([mat(m,1)<(moy-err_m),mat(m,1)>(moy+err_m)])
                break
            end
        end
        
        
        %%% End
        i=1;
        moy=0;
        for i=0:n
            j=N_mat-i;
            moy=moy+mat(j,1);
        end
        moy=moy/n;
        
        m=0;
        c2=0;
        for m=0:N_mat-1
            j=N_mat-m;
            if any([mat(j,1)>(moy-err_m),mat(j,1)<(moy+err_m)])
                c2=c2+1;
            end
            
            if any([mat(j,1)<(moy-err_m),mat(j,1)>(moy+err_m)])
                break
            end
        end
        mat(N_mat-c2:N_mat,:)=[];
        mat(1:c1,:)=[];
        
        dlmwrite(strcat('Data/extraction/leftArmEndEffector/post_process/',num2str((good_subjects(sub))),'/pp_mx_manip',num2str(manip)),mat,'delimiter',' ');
        
        delta_mx=max(mat);
        
        % my
        mat=[];
        mat=dlmread(strcat('Data/extraction/leftArmEndEffector/',num2str((good_subjects(sub))),'/my_manip',num2str(manip)));
        N_mat=length(mat);
        
        %%% Beginning
        i=1;
        moy=0;
        for i=1:n
            moy=moy+mat(i,1);
        end
        moy=moy/n;
        
        m=0;
        c1=0;
        for m=1:N_mat
            
            if any([mat(m,1)>(moy-err_m),mat(m,1)<(moy+err_m)])
                c1=c1+1;
            end
            
            if any([mat(m,1)<(moy-err_m),mat(m,1)>(moy+err_m)])
                break
            end
        end
        
        
        %%% End
        i=1;
        moy=0;
        for i=0:n
            j=N_mat-i;
            moy=moy+mat(j,1);
        end
        moy=moy/n;
        
        m=0;
        c2=0;
        for m=0:N_mat-1
            j=N_mat-m;
            if any([mat(j,1)>(moy-err_m),mat(j,1)<(moy+err_m)])
                c2=c2+1;
            end
            
            if any([mat(j,1)<(moy-err_m),mat(j,1)>(moy+err_m)])
                break
            end
        end
        mat(N_mat-c2:N_mat,:)=[];
        mat(1:c1,:)=[];
        
        dlmwrite(strcat('Data/extraction/leftArmEndEffector/post_process/',num2str((good_subjects(sub))),'/pp_my_manip',num2str(manip)),mat,'delimiter',' ');
        
        delta_my=max(mat);
        
        % mz
        mat=[];
        mat=dlmread(strcat('Data/extraction/leftArmEndEffector/',num2str((good_subjects(sub))),'/mz_manip',num2str(manip)));
        N_mat=length(mat);
        
        %%% Beginning
        i=1;
        moy=0;
        for i=1:n
            moy=moy+mat(i,1);
        end
        moy=moy/n;
        
        m=0;
        c1=0;
        for m=1:N_mat
            
            if any([mat(m,1)>(moy-err_m),mat(m,1)<(moy+err_m)])
                c1=c1+1;
            end
            
            if any([mat(m,1)<(moy-err_m),mat(m,1)>(moy+err_m)])
                break
            end
        end
       
        
        %%% End
        i=1;
        moy=0;
        for i=0:n
            j=N_mat-i;
            moy=moy+mat(j,1);
        end
        moy=moy/n;
        
        m=0;
        c2=0;
        for m=0:N_mat-1
            j=N_mat-m;
            if any([mat(j,1)>(moy-err_m),mat(j,1)<(moy+err_m)])
                c2=c2+1;
            end
            
            if any([mat(j,1)<(moy-err_m),mat(j,1)>(moy+err_m)])
                break
            end
        end
        mat(N_mat-c2:N_mat,:)=[];
        mat(1:c1,:)=[];
   
        dlmwrite(strcat('Data/extraction/leftArmEndEffector/post_process/',num2str((good_subjects(sub))),'/pp_mz_manip',num2str(manip)),mat,'delimiter',' ');
        
        delta_mz=max(mat);
        
        delta_1=sqrt(delta_mx^2+delta_my^2+delta_mz^2);
        dlmwrite(strcat('Data/extraction/leftArmEndEffector/post_process/',num2str(good_subjects(sub)),'/manip',num2str(manip),'_delta1M'),delta_1,'delimiter',' ');
%       delta_2=
%       dlmwrite(strcat('Data/extraction/leftArmEndEffector/post_process/',num2str(good_subjects(sub)),'/manip',num2str(manip),'_delta2M'),delta_2,'delimiter',' ');
        
        
    end
 end

  %% Right arm
        
  if(exist('Data/extraction/rightArmEndEffector/post_process')==0)
    mkdir(strcat('Data/extraction/rightArmEndEffector/post_process'));
end

manip=1;
for manip=1:3
    good_subjects=load(strcat('Data/extraction/rightArmEndEffector/manip',num2str(manip),'_RAEE_good'));
    N_sub=length(good_subjects);
    
    sub=1;
    for sub=1:N_sub
        
        if (exist(strcat('Data/extraction/rightArmEndEffector/post_process/',num2str((good_subjects(sub)))))==0)
            mkdir(strcat('Data/extraction/rightArmEndEffector/post_process/',num2str((good_subjects(sub)))));
        end
        
        % fx
        mat=[];
        mat=dlmread(strcat('Data/extraction/rightArmEndEffector/',num2str((good_subjects(sub))),'/fx_manip',num2str(manip)));
        N_mat=length(mat);
        
        %%% Beginning
        i=1;
        moy=0;
        for i=1:n
            moy=moy+mat(i,1);
        end
        moy=moy/n;
        
        m=0;
        c1=0;
        for m=1:N_mat
            
            if any([mat(m,1)>(moy-err_f),mat(m,1)<(moy+err_f)])
                c1=c1+1;
            end
            
            if any([mat(m,1)<(moy-err_f),mat(m,1)>(moy+err_f)])
                break
            end
        end
        
        
        %%% End
        i=0;
        moy=0;
        for i=0:n
            j=N_mat-i;
            moy=moy+mat(j,1);
        end
        moy=moy/n;
        
        m=0;
        c2=0;
        for m=0:N_mat-1
            j=N_mat-m;
            if any([mat(j,1)>(moy-err_f),mat(j,1)<(moy+err_f)])
                c2=c2+1;
            end
            
            if any([mat(j,1)<(moy-err_f),mat(j,1)>(moy+err_f)])
                break
            end
        end
        mat(N_mat-c2:N_mat,:)=[];
        mat(1:c1,:)=[];
        
        
        dlmwrite(strcat('Data/extraction/rightArmEndEffector/post_process/',num2str((good_subjects(sub))),'/pp_fx_manip',num2str(manip)),mat,'delimiter',' ');
        
        delta_fx=max(mat);
        
        % fy
        mat=[];
        mat=dlmread(strcat('Data/extraction/rightArmEndEffector/',num2str((good_subjects(sub))),'/fy_manip',num2str(manip)));
        N_mat=length(mat);
        
        %%% Beginning
        i=1;
        moy=0;
        for i=1:n
            moy=moy+mat(i,1);
        end
        moy=moy/n;
        
        m=0;
        c1=0;
        for m=1:N_mat
            
            if any([mat(m,1)>(moy-err_f),mat(m,1)<(moy+err_f)])
                c1=c1+1;
            end
            
            if any([mat(m,1)<(moy-err_f),mat(m,1)>(moy+err_f)])
                break
            end
        end
        
        %%% End
        i=1;
        moy=0;
        for i=0:n
            j=N_mat-i;
            moy=moy+mat(j,1);
        end
        moy=moy/n;
        
        m=0;
        c2=0;
        for m=0:N_mat-1
            j=N_mat-m;
            if any([mat(j,1)>(moy-err_f),mat(j,1)<(moy+err_f)])
                c2=c2+1;
            end
            
            if any([mat(j,1)<(moy-err_f),mat(j,1)>(moy+err_f)])
                break
            end
        end
        mat(N_mat-c2:N_mat,:)=[];
        mat(1:c1,:)=[];
        
        
        dlmwrite(strcat('Data/extraction/rightArmEndEffector/post_process/',num2str((good_subjects(sub))),'/pp_fy_manip',num2str(manip)),mat,'delimiter',' ');
        
        delta_fy=max(mat);
        
        % fz
        mat=[];
        mat=dlmread(strcat('Data/extraction/rightArmEndEffector/',num2str((good_subjects(sub))),'/fz_manip',num2str(manip)));
        N_mat=length(mat);
        
        %%% Beginning
        i=1;
        moy=0;
        for i=1:n
            moy=moy+mat(i,1);
        end
        moy=moy/n;
        
       m=0;
        c1=0;
        for m=1:N_mat
            
            if any([mat(m,1)>(moy-err_f),mat(m,1)<(moy+err_f)])
                c1=c1+1;
            end
            
            if any([mat(m,1)<(moy-err_f),mat(m,1)>(moy+err_f)])
                break
            end
        end
       
        
        %%% End
        i=1;
        moy=0;
        for i=0:n
            j=N_mat-i;
            moy=moy+mat(j,1);
        end
        moy=moy/n;
        
        m=0;
        c2=0;
        for m=0:N_mat-1
            j=N_mat-m;
            if any([mat(j,1)>(moy-err_f),mat(j,1)<(moy+err_f)])
                c2=c2+1;
            end
            
            if any([mat(j,1)<(moy-err_f),mat(j,1)>(moy+err_f)])
                break
            end
        end
        mat(N_mat-c2:N_mat,:)=[];
        mat(1:c1,:)=[];
        
        dlmwrite(strcat('Data/extraction/rightArmEndEffector/post_process/',num2str((good_subjects(sub))),'/pp_fz_manip',num2str(manip)),mat,'delimiter',' ');
        
        delta_fz=max(mat);
        
        delta_1=sqrt(delta_fx^2+delta_fy^2+delta_fz^2);
        dlmwrite(strcat('Data/extraction/rightArmEndEffector/post_process/',num2str(good_subjects(sub)),'/manip',num2str(manip),'_delta1F'),delta_1,'delimiter',' ');
%       delta_2=
%       dlmwrite(strcat('Data/extraction/rightArmEndEffector/post_process/',num2str(good_subjects(sub)),'/manip',num2str(manip),'_delta2F'),delta_2,'delimiter',' ');
        
               
        % mx
        mat=[];
        mat=dlmread(strcat('Data/extraction/rightArmEndEffector/',num2str((good_subjects(sub))),'/mx_manip',num2str(manip)));
        N_mat=length(mat);
        
        %%% Beginning
        i=1;
        moy=0;
        for i=1:n
            moy=moy+mat(i,1);
        end
        moy=moy/n;
        
        m=0;
        c1=0;
        for m=1:N_mat
            
            if any([mat(m,1)>(moy-err_m),mat(m,1)<(moy+err_m)])
                c1=c1+1;
            end
            
            if any([mat(m,1)<(moy-err_m),mat(m,1)>(moy+err_m)])
                break
            end
        end
        
        
        %%% End
        i=1;
        moy=0;
        for i=0:n
            j=N_mat-i;
            moy=moy+mat(j,1);
        end
        moy=moy/n;
        
        m=0;
        c2=0;
        for m=0:N_mat-1
            j=N_mat-m;
            if any([mat(j,1)>(moy-err_m),mat(j,1)<(moy+err_m)])
                c2=c2+1;
            end
            
            if any([mat(j,1)<(moy-err_m),mat(j,1)>(moy+err_m)])
                break
            end
        end
        mat(N_mat-c2:N_mat,:)=[];
        mat(1:c1,:)=[];
        
        dlmwrite(strcat('Data/extraction/rightArmEndEffector/post_process/',num2str((good_subjects(sub))),'/pp_mx_manip',num2str(manip)),mat,'delimiter',' ');
        
        delta_mx=max(mat);
        
        % my
        mat=[];
        mat=dlmread(strcat('Data/extraction/rightArmEndEffector/',num2str((good_subjects(sub))),'/my_manip',num2str(manip)));
        N_mat=length(mat);
        
        %%% Beginning
        i=1;
        moy=0;
        for i=1:n
            moy=moy+mat(i,1);
        end
        moy=moy/n;
        
        m=0;
        c1=0;
        for m=1:N_mat
            
            if any([mat(m,1)>(moy-err_m),mat(m,1)<(moy+err_m)])
                c1=c1+1;
            end
            
            if any([mat(m,1)<(moy-err_m),mat(m,1)>(moy+err_m)])
                break
            end
        end
        
        
        %%% End
        i=1;
        moy=0;
        for i=0:n
            j=N_mat-i;
            moy=moy+mat(j,1);
        end
        moy=moy/n;
        
        m=0;
        c2=0;
        for m=0:N_mat-1
            j=N_mat-m;
            if any([mat(j,1)>(moy-err_m),mat(j,1)<(moy+err_m)])
                c2=c2+1;
            end
            
            if any([mat(j,1)<(moy-err_m),mat(j,1)>(moy+err_m)])
                break
            end
        end
        mat(N_mat-c2:N_mat,:)=[];
        mat(1:c1,:)=[];
        
        dlmwrite(strcat('Data/extraction/rightArmEndEffector/post_process/',num2str((good_subjects(sub))),'/pp_my_manip',num2str(manip)),mat,'delimiter',' ');
        
        delta_my=max(mat);
        
        % mz
        mat=[];
        mat=dlmread(strcat('Data/extraction/rightArmEndEffector/',num2str((good_subjects(sub))),'/mz_manip',num2str(manip)));
        N_mat=length(mat);
        
        %%% Beginning
        i=1;
        moy=0;
        for i=1:n
            moy=moy+mat(i,1);
        end
        moy=moy/n;
        
        m=0;
        c1=0;
        for m=1:N_mat
            
            if any([mat(m,1)>(moy-err_m),mat(m,1)<(moy+err_m)])
                c1=c1+1;
            end
            
            if any([mat(m,1)<(moy-err_m),mat(m,1)>(moy+err_m)])
                break
            end
        end
       
        
        %%% End
        i=1;
        moy=0;
        for i=0:n
            j=N_mat-i;
            moy=moy+mat(j,1);
        end
        moy=moy/n;
        
        m=0;
        c2=0;
        for m=0:N_mat-1
            j=N_mat-m;
            if any([mat(j,1)>(moy-err_m),mat(j,1)<(moy+err_m)])
                c2=c2+1;
            end
            
            if any([mat(j,1)<(moy-err_m),mat(j,1)>(moy+err_m)])
                break
            end
        end
        mat(N_mat-c2:N_mat,:)=[];
        mat(1:c1,:)=[];
        
        dlmwrite(strcat('Data/extraction/rightArmEndEffector/post_process/',num2str((good_subjects(sub))),'/pp_mz_manip',num2str(manip)),mat,'delimiter',' ');
        
        delta_mz=max(mat);
        
        delta_1=sqrt(delta_mx^2+delta_my^2+delta_mz^2);
        dlmwrite(strcat('Data/extraction/rightArmEndEffector/post_process/',num2str(good_subjects(sub)),'/manip',num2str(manip),'_delta1M'),delta_1,'delimiter',' ');
%       delta_2=
%       dlmwrite(strcat('Data/extraction/rightArmEndEffector/post_process/',num2str(good_subjects(sub)),'/manip',num2str(manip),'_delta2M'),delta_2,'delimiter',' ');
        
    end
 end
  
                
                    