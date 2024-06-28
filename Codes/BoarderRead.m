clear all;
close all;
clc;

addpath(genpath('Z:\HANDISNOW'));
luli002 = load('boarder_luli.mat');
luli002 = luli002.luli002;
mabr002 = load('boarder_mabr.mat');
mabr002 = mabr002.mabr002;
pabi008 = load('boarder_pabi.mat');
pabi008 = pabi008.pabi008;
paba020 = load('boarder_paba.mat');
paba020 = paba020.paba020;


%% base de temps
debutfin = frame_start_end(luli002);
frame_debut = debutfin(1);
frame_fin = debutfin(2);
longueur = frame_fin - frame_debut + 1;

for i = 1:1:size(luli002.frame, 2)
    time(i) = str2num(luli002.frame(i).time);
end
time_col = time';
time = time_col(frame_debut:frame_fin);

%% virages boardercross
virage = boardercross_frame(pabi008);
label_virage = {'virage 1', 'virage 2', 'virage 3', 'virage 4', 'virage 5', 'virage 6', 'virage 7', 'virage 8' , 'virage 9', 'virage 10' };


[fbs, ffs, tbs, tfs] = turn_determination(pabi008, 0.3);

%% note all the time for the different turns
time_virage = [56.65 , 60.94 ;
    60.94, 67.49 ;
    67.49 , 71.20 ;
    71.20, 74.83 ;
    74.83, 79.84 ;
    79.84, 89.23;
    89.23, 93.09;
    93.09, 97.66;
    101.85, 106.13;
    106.47, 110.38];
data_paba020 = Turn_sep(paba020, time_virage);


% time_virage = [90.10, 95.05;
%     95.05, 101.64;
%     101.64, 105.83;
%     105.83, 110.05;
%     110.05, 115.19;
%     115.19, 123.86;
%     123.86, 127.66;
%     127.66, 133.83;
%     136.98, 141.17;
%     141.17, 146.91];
% data_luli002 = Turn_sep(luli002, time_virage);
%---
time_virage = [90.60, 95.05;
    95.55, 101.64;
    102.04, 105.83;
    105.83, 110.05;
    110.05, 115.19;
    115.19, 123.86;
    124.56, 127.66;
    127.66, 133.83;
    136.98, 141.17;
    141.17, 146.91];
data_luli002 = Turn_sep(luli002, time_virage);


time_virage = [130.86, 137.69;
    137.69, 147.59;
    147.59, 153.15;
    153.15, 158.98;
    158.98, 165.56;
    165.56, 176.80;
    178.85, 183.99;
    183.99, 189.60;
    195.70, 200.55;
    200.55, 206.62];
data_mabr002 = Turn_sep(mabr002, time_virage);


time_virage = [20.04, 24.93;
    24.93, 32.25;
    33.26, 37.18;
    37.18, 41.97;
    41.97, 48.06;
    51.89, 56.1;
    58.3, 62.48;
    62.48, 68.06;
    74, 78.33;
    78.33, 83.52];
data_pabi008 = Turn_sep(pabi008, time_virage);

%% subplot
To_plot = data_luli002.Knee;
% To_plot2 = data_pabi008.Ankle;
% To_plot3 = data_paba020.Ankle;
% To_plot4 = data_mabr002.Ankle;

figure();
for i=1:10
    subplot(2, 5, i);
    hold on;
    % Left joint
    plot(To_plot(i).pdata, To_plot(i).Ljoint, color=[0 0.4470 0.7410]);
%     plot(To_plot2(i).pdata, To_plot2(i).Ljoint, color=[0.1840 0.4780 0.2000]);
%     plot(To_plot3(i).pdata, To_plot3(i).Ljoint, color=[0.7050 0.1130 0.1130]);
%     plot(To_plot4(i).pdata, To_plot4(i).Ljoint, color=[0.8630 0.7370 0.1840]);

    % Right joint
    plot(To_plot(i).pdata, To_plot(i).Rjoint, color=[0.3010 0.7450 0.9330]);%, LineStyle= '--');
%     plot(To_plot2(i).pdata, To_plot2(i).Rjoint, color=[0.5450 0.7250 0.3330]);%, LineStyle= '--');
%     plot(To_plot3(i).pdata, To_plot3(i).Rjoint, color=[0.9210 0.4710 0.4390]);%, LineStyle= '--');
%     plot(To_plot4(i).pdata, To_plot4(i).Rjoint, color=[0.9880 0.9450 0.5530]);%, LineStyle= '--');

    ylim([-20 80]);
    title(sprintf('virage %d', i));
end
% legend({'LULI', 'PABI','PABA', 'MABR'});
sgtitle('Right Ankle');


%% filtrage + Calcul de moyenne sur le boarder pour chaque virage
data_struct = data_luli002;

% parametres filtre
freq_acquis = 100;
freq_coup = 0.1;
N = 2;
[b,a] = butter(N, freq_coup/(freq_acquis/2), "low");


figure();
for i =1:10

%     % cheville
%     subplot(2,5,i); hold on
%     ylim([-20 50]);
%     dataR = data_struct.Ankle(i).Rjoint;
%     dataL = data_struct.Ankle(i).Ljoint;
%     % filtrage
%     filter_dataR = filtfilt(b,a,dataR);
%     filter_dataL = filtfilt(b,a,dataL);
%     
%     plot(data_struct.Ankle(i).pdata, dataR, 'b');
%     plot(data_struct.Ankle(i).pdata,filter_dataR, 'r');
% 
%     plot(data_struct.Ankle(i).pdata, dataL, 'b');
%     plot(data_struct.Ankle(i).pdata,filter_dataL, 'r');
% 
%     sgtitle('Ankle');

    % genou
    subplot(2,5,i); hold on
    ylim([-20 70]);
    dataR = data_struct.Knee(i).Rjoint;
    dataL = data_struct.Knee(i).Ljoint;
    % filtrage
    filter_dataR = filtfilt(b,a,dataR);
    filter_dataL = filtfilt(b,a,dataL);
    
    plot(data_struct.Knee(i).pdata, dataR, 'b');
    plot(data_struct.Knee(i).pdata,filter_dataR, 'r');

    plot(data_struct.Knee(i).pdata, dataL, 'b');
    plot(data_struct.Knee(i).pdata,filter_dataL, 'r');

    sgtitle('Knee');


end


%% calcul amplitude moyenne / max lors du virage
data_struct = data_luli002;

%initialisation
moyennes = struct();

moyennes.vir_impair.AnkleR =[];
moyennes.vir_impair.AnkleL =[];
moyennes.vir_pair.AnkleR =[];
moyennes.vir_pair.AnkleL =[];

moyennes.vir_impair.KneeR =[];
moyennes.vir_impair.KneeL =[];
moyennes.vir_pair.KneeR =[];
moyennes.vir_pair.KneeL =[];

moyennes.vir_impair.HipR =[];
moyennes.vir_impair.HipL =[];
moyennes.vir_pair.HipR =[];
moyennes.vir_pair.HipL =[];


for i =1:10

    if rem(i,2) == 0 % indices pairs -> meme type de virages
        moyennes.vir_pair.AnkleR = [moyennes.vir_pair.AnkleR ; mean(data_struct.Ankle(i).Rjoint)];
        moyennes.vir_pair.AnkleL = [moyennes.vir_pair.AnkleL ; mean(data_struct.Ankle(i).Ljoint)];

        moyennes.vir_pair.KneeR = [moyennes.vir_pair.KneeR ; mean(data_struct.Knee(i).Rjoint)];
        moyennes.vir_pair.KneeL = [moyennes.vir_pair.KneeL ; mean(data_struct.Knee(i).Ljoint)];

        moyennes.vir_pair.HipR = [moyennes.vir_pair.HipR ; mean(data_struct.Hip(i).Rjoint)];
        moyennes.vir_pair.HipL = [moyennes.vir_pair.HipL ; mean(data_struct.Hip(i).Ljoint)];

    else % indices impairs
        moyennes.vir_impair.AnkleR = [moyennes.vir_impair.AnkleR ; mean(data_struct.Ankle(i).Rjoint)];
        moyennes.vir_impair.AnkleL = [moyennes.vir_impair.AnkleL ; mean(data_struct.Ankle(i).Ljoint)];

        moyennes.vir_impair.KneeR = [moyennes.vir_impair.KneeR ; mean(data_struct.Knee(i).Rjoint)];
        moyennes.vir_impair.KneeL = [moyennes.vir_impair.KneeL ; mean(data_struct.Knee(i).Ljoint)];

        moyennes.vir_impair.HipR = [moyennes.vir_impair.HipR ; mean(data_struct.Hip(i).Rjoint)];
        moyennes.vir_impair.HipL = [moyennes.vir_impair.HipL ; mean(data_struct.Hip(i).Ljoint)];

    end


end


figure();

subplot(3, 2, 1)
ylim([-20 80]);
yline(moyennes.vir_pair.HipL, 'r')
yline(moyennes.vir_pair.HipR, 'b')
subplot(3, 2, 2)
ylim([-20 80]);
yline(moyennes.vir_impair.HipL, 'r')
yline(moyennes.vir_impair.HipR, 'b')

subplot(3, 2, 3)
ylim([-20 80]);
yline(moyennes.vir_pair.KneeL, 'r')
yline(moyennes.vir_pair.KneeR, 'b')
subplot(3, 2, 4)
ylim([-20 80]);
yline(moyennes.vir_impair.KneeL, 'r')
yline(moyennes.vir_impair.KneeR, 'b')

subplot(3, 2, 5)
ylim([-20 80]);
yline(moyennes.vir_pair.AnkleL, 'r')
yline(moyennes.vir_pair.AnkleR, 'b')
subplot(3, 2, 6)
ylim([-20 80]);
yline(moyennes.vir_impair.AnkleL, 'r')
yline(moyennes.vir_impair.AnkleR, 'b')






%% graph membre inf

% --- hanches
right_hip = pabi008.jointData(15).jointAngle(frame_debut:frame_fin,3);
left_hip = pabi008.jointData(19).jointAngle(frame_debut:frame_fin,3);
subplot(3,1,1);
p1 = plot(time/1000, right_hip, LineWidth=1);
p1.Color = "#4DBEEE";
hold on
p2 = plot(time/1000, left_hip, LineWidth=1);
p2.Color ="#EDB120";
title('Flexion/extension hanches');
xlabel('Temps (s)');
ylabel('Angle (°)');
legend('hanche droite','hanche gauche', 'AutoUpdate', 'off')


xline(frame_debut/100, 'v');
xline(frame_fin/100, 'r');
xline(virage, '-k', label_virage);


%--genou flex/ext
right_knee = multi.jointData(16).jointAngle(frame_debut:frame_fin,3);
left_knee = multi.jointData(20).jointAngle(frame_debut:frame_fin,3);
subplot(3,1,2);
p1 = plot(time/1000, right_knee, LineWidth=1);
p1.Color = "#4DBEEE";
hold on
p2 = plot(time/1000, left_knee, LineWidth=1);
p2.Color ="#EDB120";
title('Flexion/extension genou');
xlabel('Temps (s)');
ylabel('Angle (°)');
legend('genou droit','genou prothétique', 'AutoUpdate', 'off')

xline(virage, '-k', label_virage);

%--chevile dorsi/plantar
right_ankle = multi.jointData(17).jointAngle(frame_debut:frame_fin,3);
left_ankle = multi.jointData(21).jointAngle(frame_debut:frame_fin,3);
subplot(3,1,3);
p1 = plot(time/1000, right_ankle, LineWidth=1);
p1.Color = "#4DBEEE";
hold on
p2 = plot(time/1000, left_ankle, LineWidth=1);
p2.Color ="#EDB120";
title('Dorsi/plantar cheville');
xlabel('Temps (s)');
ylabel('Angle (°)');
legend('cheville droite','cheville prothétique', 'AutoUpdate', 'off')

xline(virage, '-k', label_virage);


