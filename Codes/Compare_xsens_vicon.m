% compare the data from vicon and from xsens

clear all;
close all;
clc

addpath(genpath('Z:\HANDISNOW'));
addpath(genpath('Z:\mouvement'));

%% raw data
% pour vicon res_var_angle_t
DataVicon = load('Z:\HANDISNOW\Manip 2024\Xsens_snow\mvnx vicon_xsens\Vicon_turns.mat');
rawVicon = DataVicon.data_cine.sujet1(1).essai.res_var_angle_t;
temps_total = length(rawVicon.bassin)/200; % frequence vicon 200Hz
frames = 1:length(rawVicon.bassin);
time_vicon = frames'/200;


% pour Xsens mvnx
rawXsens = load_mvnx('Z:\HANDISNOW\Manip 2024\Xsens_snow\mvnx vicon_xsens\snow_S01-001.mvnx');
for i = 1:1:size(rawXsens.frame, 2)
    time(i) = str2num(rawXsens.frame(i).time);
end
time_xsens = time'/1000;

% retirer la moyenne pour centrer sur 0; et gérer les signes
ChevD_Xsens = rawXsens.jointData(17).jointAngle(:,3) - mean(rawXsens.jointData(17).jointAngle(:,3));
ChevD_Vicon = -rawVicon.chevilleD(:,3) - mean(-rawVicon.chevilleD(:,3));



% plot
figure(); hold on
plot(time_xsens, ChevD_Xsens, 'r');
plot(time_vicon, -rawVicon.chevilleD(:,3), 'b');



