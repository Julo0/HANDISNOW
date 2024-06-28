%% This Script is meant to process MVNX files with vicon parameters:
% it takes the cycles determined via vicon and uses that to create the
% cycles on the mvnx files

clear all;
close all;
clc

addpath(genpath('Z:\HANDISNOW'));
addpath(genpath('Z:\mouvement'));

[nomfich, pathfich] = uigetfile('Multiselect','on','*.mvnx');

Vicon = load('Z:\HANDISNOW\Manip 2024\Xsens_snow\mvnx vicon_xsens\Vicon_turns.mat');

frequenceXSENS = 100;
frequenceVICON = 200;

Xsens = struct();

for i = 1:length(fieldnames(Vicon.data_cine))
    sujet = Vicon.data_cine.(['sujet', num2str(i)]);
    for j=1:length(sujet)
        fich = ['snow_S0' , num2str(i), '-00', num2str(j), '.mvnx'];

        % load les turns
        Frame_BS = sujet(j).frame_BS;
        Frame_FS = sujet(j).frame_FS;
        % ATTENTION frequences xsens et vicon pas identiques
        Frame_BS = Frame_BS*frequenceXSENS/frequenceVICON;
        Frame_FS = Frame_FS*frequenceXSENS/frequenceVICON;

        % process and cycle
        essai = load_mvnx(fullfile(pathfich, fich));
        essai_cycle = Cycle_data_determination3(essai, Frame_BS, Frame_FS);
        sgtitle(['snow_S0' , num2str(i), '-00', num2str(j), '.mvnx']);

        essai_set = Cycle_data_set(essai_cycle, []);

        % add the data to the structure ( .mat file)
        Xsens.(['sujet', num2str(i)]).(['essai' , num2str(j)]) = essai_set;

    end

end









