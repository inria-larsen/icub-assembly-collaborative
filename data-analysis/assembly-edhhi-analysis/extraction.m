%%%%%%%%%%%%%%%%%%%%%%%%%%
% % % % Extraction % % % %
%%%%%%%%%%%%%%%%%%%%%%%%%%

% This script extracts and find good subjects for all data from experiment
% made on the iCub for the collaborative assembly task.
%
% authors: Anthony Voilque & Serena Ivaldi (serena.ivaldi@inria.fr)

clear all
clc

all_subjects=load('all_subjects');

%%
extraction_rightArmTorques(all_subjects, N_subjects)
extraction_leftArmTorques(all_subjects, N_subjects)

extraction_rightArmEndEffector(all_subjects, N_subjects)
extraction_leftArmEndEffector(all_subjects, N_subjects)

extraction_CartLeftArm(all_subjects, N_subjects)
extraction_CartRightArm(all_subjects, N_subjects)

extraction_leftSkinForearm(all_subjects, N_subjects)
extraction_rightSkinForearm(all_subjects, N_subjects)