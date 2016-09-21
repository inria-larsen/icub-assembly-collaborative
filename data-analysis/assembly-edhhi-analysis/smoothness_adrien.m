%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%
%       Mapping analysis
%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

%% Initialisation
close all;
clear all;

positionH_1 = 0.1; % Home position threshold
PAUSE = 1; % time stop threshold
K = 1;
%% loop on participant ID
for participantId = 1 : 9999

%  for K = 1 : 1
    
    clear task_gui;
    clear task_joy;
   
    % Path to the experiment data repository
    pathDir = strcat('C:/Users/Adrien/Documents/Etudes/Master_SCMN/Stage_Larsen/data analysis/experiments/'...
        ,num2str(participantId));
    
    if(exist(pathDir, 'dir')~=0)
        
        if(exist(strcat(pathDir,sprintf('/GUI'))) ~=0 && ...
                exist(strcat(pathDir,sprintf('/Joystick'))) ~=0)
            participantId
            
            K=K+1;
            
            %% Load of mapping data gui
            p_gui = load(strcat(pathDir,sprintf('/GUI/joint_pos_GUI_%d.mat',...
                participantId)), '-ascii');
            v_gui = load(strcat(pathDir,sprintf('/GUI/joint_vel_GUI_%d.mat',...
                participantId)), '-ascii');
            t_gui = load(strcat(pathDir,sprintf('/GUI/index_GUI_%d.mat',...
                participantId)), '-ascii');
            h_gui = load(strcat(pathDir,sprintf('/GUI/hand_vel_GUI_%d.mat',...
                participantId)), '-ascii');
            cart_gui = load(strcat(pathDir,sprintf('/GUI/cart_pos_GUI_%d.mat',...
                participantId)), '-ascii');

            % Load of mapping data joystick
            cart_joy = load(strcat(pathDir,sprintf('/Joystick/cart_pos_Joystick_%d.mat',...
                participantId)), '-ascii');
            p_joy = load(strcat(pathDir,sprintf('/Joystick/joint_pos_Joystick_%d.mat',...
                participantId)), '-ascii');
            v_joy = load(strcat(pathDir,sprintf('/Joystick/joint_vel_Joystick_%d.mat',...
                participantId)), '-ascii');
            t_joy = load(strcat(pathDir,sprintf('/Joystick/index_Joystick_%d.mat',...
                participantId)), '-ascii');
            h_joy = load(strcat(pathDir,sprintf('/Joystick/hand_vel_Joystick_%d.mat',...
                participantId)), '-ascii');
        %%

            % Filter parameter
            [B,A] = butter(2,0.03);

            % Loop on the 6 joints of the robots
            for i = 1 : 6
                % Home position at (0;0;0;0;0;0)
                p_gui(:,i) = p_gui(:,i) - p_gui(1,i);
                cart_gui(:,i) = cart_gui(:,i) - cart_gui(1,i);
                cart_joy(:,i) = cart_joy(:,i) - cart_joy(1,i);
                p_joy(:,i) = p_joy(:,i) - p_joy(1,i);
                % Velocity filtering
                v_joy(:,i) = filter(B,A,v_joy(:,i));
                v_gui(:,i) = filter(B,A,v_gui(:,i));
            end

            N_cart_gui = zeros(1,length(p_gui));
            vel_gui_n = zeros(1,length(p_gui));

            % Loop on the gui movements
            for i = 1 : length(p_gui)
                % Norm of cartesian position
                N_cart_gui(i) = norm(cart_gui(i,:));
                % Find if there is no movement with velocity = 0
                vel_gui_n(i) = abs(v_gui(i,1))<0.02&...
                    abs(v_gui(i,2))<0.02&...
                    abs(v_gui(i,3))<0.02&...
                    abs(v_gui(i,4))<0.02&...
                    abs(v_gui(i,5))<0.02&...
                    abs(v_gui(i,6))<0.02;
            end

            N_cart_joy = zeros(1,length(p_joy));
            vel_joy_n = zeros(1,length(p_joy));

            % Loop on the joystick movements
            for i = 1 : length(p_joy)
                % Norm of cartesian position
                N_cart_joy(i) = norm(cart_joy(i,:));
                % Find if there is no movement with velocity = 0
                vel_joy_n(i) = abs(v_joy(i,1))<0.02&...
                    abs(v_joy(i,2))<0.02&...
                    abs(v_joy(i,3))<0.02&...
                    abs(v_joy(i,4))<0.02&...
                    abs(v_joy(i,5))<0.02&...
                    abs(v_joy(i,6))<0.02;
            end

            %% Tasks decomposition (GUI)

            k=1;
            flag = 0;
            win = 200; % Size of window

            % Find the begining end end of each task
            for i = win+1 : length(p_gui)
                if(mean(N_cart_gui(i-win:i))>positionH_1)&&(flag==0)
                    task_gui(k).debut = i-win/2;
                    flag = 1;
                end
                if(mean(N_cart_gui(i-win:i)) <= positionH_1)&&(flag==1)
                    task_gui(k).fin = i-win/2;
                    flag = 0;
                    k = k + 1;
                end
            end

            %% Task decomposition (Joystick)
            k=1;
            flag = 0;

            % Find the begining end end of each task
            for i = win+1 : length(p_joy)
                if(mean(N_cart_joy(i-win:i))>positionH_1)&&(flag==0)
                    task_joy(k).debut = i;
                    flag = 1;
                end
                if(mean(N_cart_joy(i-win:i)) <= positionH_1)&&(flag==1)
                    task_joy(k).fin = i;
                    flag = 0;
                    k = k + 1;
                end
            end

            %% hand control

            % Find the moment when a movement is applied to the hand
            h_gui = h_gui(:)>0|h_gui(:)<0;
            h_joy = h_joy(:)>0|h_joy(:)<0;

            %% Position/time/velocity by tasks

            %% GUI   
            total_time_gui = 0;
            time_stop_gui = 0;

            clear pos_gui
            clear time_gui
            clear vel_gui
            clear stop_gui
            clear vel_gui_N
            clear hand_gui
            clear T
            clear mov_gui
            clear t_mov_gui
            clear time_pause_gui

            pos_gui = cell(1,length(task_gui));
            time_gui = cell(1,length(task_gui));
            vel_gui = cell(1,length(task_gui));
            hand_gui = cell(1,length(task_gui));
            vel_gui_N = cell(1,length(task_gui));
            stop_gui = cell(1,length(task_gui));

            t_act_gui = 0;
            nbr_pause_gui = 0;

            % loop on each task
            for i = 1 : length(task_gui)
                total_time_gui = total_time_gui + (t_gui(task_gui(i).fin) - t_gui(task_gui(i).debut))/1000;
                pos_gui{i} = p_gui(task_gui(i).debut:task_gui(i).fin,:);
                time_gui{i} = t_gui(task_gui(i).debut:task_gui(i).fin)-t_gui(task_gui(i).debut);
                vel_gui{i} = v_gui(task_gui(i).debut:task_gui(i).fin,:);
                hand_gui{i} = h_gui(task_gui(i).debut:task_gui(i).fin);
                vel_gui_N{i} = vel_gui_n(task_gui(i).debut:task_gui(i).fin);

                % Find the inactivity samples
                stop_gui{i} = hand_gui{i}|~vel_gui_N{i}';
                time_stop_gui = time_stop_gui + (t_gui(end)-t_gui(1))/length(t_gui)*sum(~stop_gui{i})/1000;

                j = 1; % movement counter
                time = 1;
                flag = 0;

                % Decomposition movements
                while time < length(stop_gui{i})
                    flag_pause = 0;
                    x = 1;
                    s_t = 0;
                    % Activity
                    while (stop_gui{i}(time) == 1) && (time < length(stop_gui{i}))
                        mov_gui{i,j}(x,:) = vel_gui{i}(time,:);
                        t_mov_gui{i,j}(x) = time_gui{i}(time,:);
                        T{i,j}(x) = time_gui{i}(time);
                        time = time + 1;
                        flag = 1;
                        x = x + 1;
                        s_t = 0;
                        t_act_gui = t_act_gui + 1;
                        % Verification if stop <1 second
                        while (s_t*((t_gui(end)-t_gui(1))/length(t_gui)/1000) < PAUSE)...
                                && (stop_gui{i}(time) == 0)...
                                && (time < length(stop_gui{i}))
                            s_t = s_t + 1;
                            time = time + 1;
                            t_act_gui = t_act_gui + 1;

                        end
                        if (s_t*((t_gui(end)-t_gui(1))/length(t_gui)/1000) >= PAUSE)
                            t_act_gui = t_act_gui - s_t;
                        end
                    end

                    % Inactivity
                    while (stop_gui{i}(time) == 0) && (time < length(stop_gui{i}))
                        s_t = s_t + 1;
                        time = time + 1;
                        if(flag_pause == 0)
                            flag_pause = 1;
                            nbr_pause_gui = nbr_pause_gui + 1;
                            time_pause_gui(nbr_pause_gui) = s_t;
                            s_t = 0;
                        end
                        time_pause_gui(nbr_pause_gui) = time_pause_gui(nbr_pause_gui)+1;
                    end
                    % Next movement
                    if(flag == 1)
                        j = j + 1;
                        flag = 0;
                    else
                        time = time + 1;
                    end
                end
            end

            %% Joystick

            total_time_joy = 0;
            time_stop_joy = 0;

            clear pos_joy
            clear time_joy
            clear vel_joy
            clear stop_joy
            clear vel_joy_N
            clear hand_joy
            clear T
            clear mov_joy
            clear t_mov_joy
            clear time_pause_joy

            pos_joy = cell(1,length(task_joy));
            time_joy = cell(1,length(task_joy));
            vel_joy = cell(1,length(task_joy));
            hand_joy = cell(1,length(task_joy));
            vel_joy_N = cell(1,length(task_joy));
            stop_joy = cell(1,length(task_joy));

            t_act_joy = 0;
            nbr_pause_joy = 0;

            % loop on each task
            for i = 1 : length(task_joy)
                total_time_joy = total_time_joy + (t_joy(task_joy(i).fin) - t_joy(task_joy(i).debut))/1000;
                pos_joy{i} = p_joy(task_joy(i).debut:task_joy(i).fin,:);
                time_joy{i} = t_joy(task_joy(i).debut:task_joy(i).fin)-t_joy(task_joy(i).debut);
                vel_joy{i} = v_joy(task_joy(i).debut:task_joy(i).fin,:);
                hand_joy{i} = h_joy(task_joy(i).debut:task_joy(i).fin);
                vel_joy_N{i} = vel_joy_n(task_joy(i).debut:task_joy(i).fin);

                % Find the inactivity samples
                stop_joy{i} = hand_joy{i}|~vel_joy_N{i}';
                time_stop_joy = time_stop_joy + (t_joy(end)-t_joy(1))/length(t_joy)*sum(~stop_joy{i})/1000;

                j = 1;
                time = 1;
                flag = 0;   


                % Decomposition movements
                while time < length(stop_joy{i})
                    s_t = 0;
                    flag_pause = 0;
                    x = 1;
                    % Activity
                    while (stop_joy{i}(time) == 1) && (time < length(stop_joy{i}))
                        mov_joy{i,j}(x,:) = vel_joy{i}(time,:);
                        t_mov_joy{i,j}(x) = time_joy{i}(time,:);
                        T{i,j}(x) = time_joy{i}(time);
                        time = time + 1;
                        flag = 1;
                        x = x + 1;
                        s_t = 0;
                        t_act_joy = t_act_joy + 1;
                        % Test if pause < 1 second
                        while (s_t*((t_joy(end)-t_joy(1))/length(t_joy)/1000) < PAUSE)...
                                && (stop_joy{i}(time) == 0)...
                                && (time < length(stop_joy{i}))
                            s_t = s_t + 1;
                            time = time + 1;
                            t_act_joy = t_act_joy + 1;
                        end
                        if (s_t*((t_joy(end)-t_joy(1))/length(t_joy)/1000) >= PAUSE)
                            t_act_joy = t_act_joy - s_t;
                        end
                    end

                    % Inactivity
                    while (stop_joy{i}(time) == 0) && (time < length(stop_joy{i}))
                        time = time + 1;
                        if(flag_pause == 0)
                            flag_pause = 1;
                            nbr_pause_joy = nbr_pause_joy + 1;
                            time_pause_joy(nbr_pause_joy) = s_t;
                            s_t = 0;
                        end
                        time_pause_joy(nbr_pause_joy) = time_pause_joy(nbr_pause_joy)+1;
                    end
                    if(flag == 1)
                        if length(t_mov_joy{i,j})<10
                            continue;
                        else
                            j = j + 1;
                            flag = 0;
                        end
                    else
                        time = time + 1;
                    end
                end
            end

            % Duration of pauses
            time_pause_gui = time_pause_gui*((t_gui(end)-t_gui(1))/length(t_gui)/1000);
            time_pause_joy = time_pause_joy*((t_joy(end)-t_joy(1))/length(t_joy)/1000);

            % Time of activity
            t_act_joy = t_act_joy*((t_joy(end)-t_joy(1))/length(t_joy)/1000);
            t_act_gui = t_act_gui*((t_gui(end)-t_gui(1))/length(t_gui)/1000);

            % Percentage of activity
            pct_stop_joy = 100*(sum(time_pause_joy)/total_time_joy);
            pct_stop_gui = 100*(sum(time_pause_gui)/total_time_gui);

            %% Smoothness measure : Log Dimensionless Jerk (LDLJ)

            clear DLJ_gui
            clear LDLJ_gui
            clear DLJ_joy
            clear LDLJ_joy

            %% GUI

            U = 0;
            % Loop on the tasks
            for i = 1 : length(task_gui)
                % Loop on the movements
                for u = 1 : length(mov_gui)
                    if isempty(mov_gui{i,u})
                        break;
                    else
                        for m = 1 : 6
                            dV = diff(mov_gui{i,u}(:,m))./diff(t_mov_gui{i,u}(:));
                            dt = t_mov_gui{i,u}(2:end);
                            dv2 = diff(dV)./diff(dt');
                            dt2 = dt(2:end);

                            intV = trapz(dv2.^2);
                            T = ((t_mov_gui{i,u}(end) - t_mov_gui{i,u}(1))).^5;
                            maxV = max(mov_gui{i,u}(:,m)).^2;

                            DLJ_gui(u+U,m) = -T/maxV * intV;
                            LDLJ_gui(u+U,m) = -log(abs(DLJ_gui(u+U,m)));
                        end
                    end
                end
                U = U + u - 1;
            end

            %% Joystick

            U = 0;
            % Loop on the tasks
            for i = 1 : length(task_joy)
                % Loop on the movements
                for u = 1 : length(mov_joy)
                    if isempty(mov_joy{i,u})
                        break;
                    else
                        for m = 1 : 6
                            dV = diff(mov_joy{i,u}(:,m))./diff(t_mov_joy{i,u}(:));
                            dt = t_mov_joy{i,u}(2:end);
                            dv2 = diff(dV)./diff(dt');
                            dt2 = dt(2:end);

                            intV = trapz(dv2.^2);
                            T = ((t_mov_joy{i,u}(end) - t_mov_joy{i,u}(1))).^5;
                            maxV = max(mov_joy{i,u}(:,m)).^2;

                            DLJ_joy(u+U,m) = -T/maxV * intV;
                            LDLJ_joy(u+U,m) = -log(abs(DLJ_joy(u+U,m)));
                        end
                    end
                end
                U = U + u - 1;
            end

            % Mean of LDLJ for a global value
            LDLJ_joy_tot = mean(mean(LDLJ_joy));
            LDLJ_gui_tot = mean(mean(LDLJ_gui));

        %% Save the data on excel file
        xlswrite('C:/Users/Adrien/Documents/Etudes/Master_SCMN/Stage_Larsen/data analysis/data/mapping',[participantId total_time_gui total_time_joy...
            pct_stop_gui pct_stop_joy...
            nbr_pause_gui nbr_pause_joy...
            mean(time_pause_gui) mean(time_pause_joy)...
            std(time_pause_gui) std(time_pause_joy)...
            median(time_pause_gui) median(time_pause_joy)...
            max(time_pause_gui) max(time_pause_joy)...
            LDLJ_gui_tot LDLJ_joy_tot]...
            , 'mapping', strcat('A',num2str(K+1)));
        end
    end
end