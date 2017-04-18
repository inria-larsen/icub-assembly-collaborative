% ratata=3
manip=1
file_size=3000;
% osidj=dlmread(strcat('B/',num2str(ratata),'/C/A/coucou'),' ',[0 1 2 1])

% a=3;
% T=textread(strcat('B/',num2str(a),'/C/A/coucou'),'%s','delimiter','\n');
% nb=size(T,1)

% T=textread(strcat('Data/dump_manip',num2str(manip),'/','41','/leftArmTorques/data.log'),'%s','delimiter','\n');
%     file_size=size(T,1);
    
% path='Data/dump_manip1/41/leftArmTorques/data.log'
% exist(path)
% a=num2str(file_size)
% format long;
% path=strcat('Data/dump_manip',num2str(manip),'/','44','/leftArmTorques/data.log')
% A = dlmread(strcat('Data/dump_manip1/44/leftArmTorques/data.log'));
% LAT=A(:,1)
% % LAT_join3=dlmread(strcat('Data/dump_manip',num2str(manip),'/','44','/leftArmTorques/data.log'),' ',[0 5 num2str(file_size) 5])
% 
% dlmwrite('B/3/file',[LAT,LAT],'delimiter',' ')
% format longEng;
% A=dlmread(strcat('Data/dump_manip1/81/rightArmTorques/data.log'));
B=load(strcat('Data/dump_manip1/39/skin_left_forearm/data.log'),'-ascii');


clc;
% path=strcat('B/','3/','C');
% path=3;
% copyfile('path','A');
% copyfile('B/3/C','A');

% manip=4
% 
% matrix4=[1 2 3 4 5 6 7 8 9]
% matrix2=[11 1 3 5 15 20 32 54 9];
% 
% matrix=strcat('matrix',num2str(manip))
% 
% assignin('base','matrix',matrix4)
% 
% 
% save('untitled2','matrix');dlmread('B/3/C/A/coucou',' ',[0 1 2 1]);
mat=[];
join=1
paf=strcat('mat',num2str(join))
paf=[0 1 -5 -6 3 1 63]
% strcat('mat',num2str(join))=[0 1 5 6 3 1 63]

pif=abs(dlmread('B/3/C/A/coucou'))
pouf=[1;5;3;8;54]
puf=max(paf)













