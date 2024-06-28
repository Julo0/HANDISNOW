clear all;
close all;
clc;

addpath(genpath('Z:\HANDISNOW'));

% load mvnx data
% import the Xsens data
essai1 = 'lull-001_nolvl.mvnx';
essai2 = 'mabr-001_nolvl.mvnx';
essai3 = 'pabi-010_nolvl.mvnx';
essai4 = 'paba-021_nolvl.mvnx';

nolvl_lull001 = load_mvnx(essai1);
nolvl_mabr001 = load_mvnx(essai2);
nolvl_pabi010 = load_mvnx(essai3);
nolvl_paba021 = load_mvnx(essai4);

%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%
label_essai = nolvl_mabr001;

frame_debut = 10900;
frame_fin = 23600;
longueur = frame_fin - frame_debut + 1;
duree = (frame_debut/100);

%% define backside and frontside frame and temporality

[fbs, ffs, tbs, tfs ] = turn_determination(label_essai, 1);
fbs = fbs - frame_debut;
ffs = ffs - frame_debut;
tbs = tbs - duree;
tfs = tfs - duree;

%%
time_col = [];
time =  [];
for i = 1:1:size(label_essai.frame, 2)
    time(i) = str2num(label_essai.frame(i).time);
end
time_col = time';
time = time_col(1:longueur);
%%

% load accelero data
data_accelero = load("DataBlueTrident_All.mat");
data_accelero_stat = load("DataBlueTrident_STA.mat");

data_acce = data_accelero.Data_BlueTrident(3, 2);

% determination cycle
indice_premier_backside = 17;
nb_cycle = 8;

%% retirer la composante continue
data_acce.TS01306.ax = data_acce.TS01306.ax - mean(data_acce.TS01306.ax);
data_acce.TS01306.ay = data_acce.TS01306.ay - mean(data_acce.TS01306.ay);
data_acce.TS01306.az = data_acce.TS01306.az - mean(data_acce.TS01306.az);

data_acce.TS02105.ax = data_acce.TS02105.ax - mean(data_acce.TS02105.ax);
data_acce.TS02105.ay = data_acce.TS02105.ay - mean(data_acce.TS02105.ay);
data_acce.TS02105.az = data_acce.TS02105.az - mean(data_acce.TS02105.az);

data_acce.TS02113.ax = data_acce.TS02113.ax - mean(data_acce.TS02113.ax);
data_acce.TS02113.ay = data_acce.TS02113.ay - mean(data_acce.TS02113.ay);
data_acce.TS02113.az = data_acce.TS02113.az - mean(data_acce.TS02113.az);

data_acce.TS03141.ax = data_acce.TS03141.ax - mean(data_acce.TS03141.ax);
data_acce.TS03141.ay = data_acce.TS03141.ay - mean(data_acce.TS03141.ay);
data_acce.TS03141.az = data_acce.TS03141.az - mean(data_acce.TS03141.az);

data_acce.TS03142.ax = data_acce.TS03142.ax - mean(data_acce.TS03142.ax);
data_acce.TS03142.ay = data_acce.TS03142.ay - mean(data_acce.TS03142.ay);
data_acce.TS03142.az = data_acce.TS03142.az - mean(data_acce.TS03142.az);


cycle_data_acc = Cycle_data_Acc(indice_premier_backside,nb_cycle ,data_acce,label_essai, frame_debut,frame_fin);

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%% moyenne et ecart type des rms sur cycle et backside , frontside SUR AXE VERTICAL
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

RMSx_pelvis = [];
RMSx_pelvis_back = [];
RMSx_pelvis_front = [];

RMSx_Rthigh = [];
RMSx_Rthigh_back = [];
RMSx_Rthigh_front = [];

RMSx_Lthigh = [];
RMSx_Lthigh_back = [];
RMSx_Lthigh_front = [];

RMSx_Rtibia = [];
RMSx_Rtibia_back = [];
RMSx_Rtibia_front = [];

RMSx_Ltibia = [];
RMSx_Ltibia_back = [];
RMSx_Ltibia_front = [];


for i = 1:length(cycle_data_acc.pelvis)
    RMSx_pelvis = [RMSx_pelvis, cycle_data_acc.pelvis(i).RMSaX];
    RMSx_pelvis_back = [RMSx_pelvis_back, cycle_data_acc.pelvis(i).RMSaX_back];
    RMSx_pelvis_front = [RMSx_pelvis_front, cycle_data_acc.pelvis(i).RMSaX_front];

    RMSx_Rthigh = [RMSx_Rthigh, cycle_data_acc.Rthigh(i).RMSaX];
    RMSx_Rthigh_back = [RMSx_Rthigh_back, cycle_data_acc.Rthigh(i).RMSaX_back];
    RMSx_Rthigh_front = [RMSx_Rthigh_front, cycle_data_acc.Rthigh(i).RMSaX_front];

    RMSx_Lthigh = [RMSx_Lthigh, cycle_data_acc.Lthigh(i).RMSaX];
    RMSx_Lthigh_back = [RMSx_Lthigh_back, cycle_data_acc.Lthigh(i).RMSaX_back];
    RMSx_Lthigh_front = [RMSx_Lthigh_front, cycle_data_acc.Lthigh(i).RMSaX_front];

    RMSx_Rtibia = [RMSx_Rtibia, cycle_data_acc.Rtibia(i).RMSaX];
    RMSx_Rtibia_back = [RMSx_Rtibia_back, cycle_data_acc.Rtibia(i).RMSaX_back];
    RMSx_Rtibia_front = [RMSx_Rtibia_front, cycle_data_acc.Rtibia(i).RMSaX_front];


    RMSx_Ltibia = [RMSx_Ltibia, cycle_data_acc.Ltibia(i).RMSaX];
    RMSx_Ltibia_back = [RMSx_Ltibia_back, cycle_data_acc.Ltibia(i).RMSaX_back];
    RMSx_Ltibia_front = [RMSx_Ltibia_front, cycle_data_acc.Ltibia(i).RMSaX_front];
end

RMSx_pelvis_mean = mean(RMSx_pelvis);
RMSx_pelvis_mean_back = mean(RMSx_pelvis_back);
RMSx_pelvis_mean_front = mean(RMSx_pelvis_front);
RMSx_pelvis_std = std(RMSx_pelvis);
RMSx_pelvis_std_back = std(RMSx_pelvis_back);
RMSx_pelvis_std_front = std(RMSx_pelvis_front);

RMSx_Rthigh_mean = mean(RMSx_Rthigh);
RMSx_Rthigh_mean_back = mean(RMSx_Rthigh_back);
RMSx_Rthigh_mean_front = mean(RMSx_Rthigh_front);
RMSx_Rthigh_std = std(RMSx_Rthigh);
RMSx_Rthigh_std_back = std(RMSx_Rthigh_back);
RMSx_Rthigh_std_front = std(RMSx_Rthigh_front);

RMSx_Lthigh_mean = mean(RMSx_Lthigh);
RMSx_Lthigh_mean_back = mean(RMSx_Lthigh_back);
RMSx_Lthigh_mean_front = mean(RMSx_Lthigh_front);
RMSx_Lthigh_std = std(RMSx_Lthigh);
RMSx_Lthigh_std_back = std(RMSx_Lthigh_back);
RMSx_Lthigh_std_front = std(RMSx_Lthigh_front);

RMSx_Rtibia_mean = mean(RMSx_Rtibia);
RMSx_Rtibia_mean_back = mean(RMSx_Rtibia_back);
RMSx_Rtibia_mean_front = mean(RMSx_Rtibia_front);
RMSx_Rtibia_std = std(RMSx_Rtibia);
RMSx_Rtibia_std_back = std(RMSx_Rtibia_back);
RMSx_Rtibia_std_front = std(RMSx_Rtibia_front);

RMSx_Ltibia_mean = mean(RMSx_Ltibia);
RMSx_Ltibia_mean_back = mean(RMSx_Ltibia_back);
RMSx_Ltibia_mean_front = mean(RMSx_Ltibia_front);
RMSx_Ltibia_std = std(RMSx_Ltibia);
RMSx_Ltibia_std_back = std(RMSx_Ltibia_back);
RMSx_Ltibia_std_front = std(RMSx_Ltibia_front);


%% comparaison entre RMS X entre bakcside et frontside

% bar plot thigh
Boxplot_backsideR = RMSx_Rthigh_back;
Boxplot_backsideL = RMSx_Lthigh_back;
Boxplot_frontsideR = RMSx_Rthigh_front;
Boxplot_frontsideL = RMSx_Lthigh_front;

% building the plot
figure();
positions_R = [1, 2]; % Positions pour la jambe droite
positions_L = [4, 5]; % Positions pour la jambe gauche
subplot(3,1,2);
ylim([0 20]);
hold on;
bar(1, mean(Boxplot_backsideR), 0.4, 'FaceColor', [0.8350 0.0780 0.1840], 'EdgeColor', 'k');
bar(2, mean(Boxplot_frontsideR), 0.4, 'FaceColor', [0.3010 0.7450 0.9330], 'EdgeColor', 'k');
bar(4, mean(Boxplot_backsideL), 0.4, 'FaceColor', [0.8350 0.0780 0.1840], 'EdgeColor', 'k');
bar(5, mean(Boxplot_frontsideL), 0.4, 'FaceColor', [0.3010 0.7450 0.9330], 'EdgeColor', 'k');

errorbar(positions_R, [mean(Boxplot_backsideR), mean(Boxplot_frontsideR)], ...
    [std(Boxplot_backsideR), std(Boxplot_frontsideR)], 'k', 'linestyle', 'none');
errorbar(positions_L, [mean(Boxplot_backsideL), mean(Boxplot_frontsideL)], ...
    [std(Boxplot_backsideL), std(Boxplot_frontsideL)], 'k', 'linestyle', 'none');

xticks([1.5, 4.5]);
xticklabels({'Right', 'Left'});
ylabel('RMS x thigh');
legend({'Backside', 'Frontside'});

% bar plot tibia
Boxplot_backsideR = RMSx_Rtibia_back;
Boxplot_backsideL = RMSx_Ltibia_back;
Boxplot_frontsideR = RMSx_Rtibia_front;
Boxplot_frontsideL = RMSx_Ltibia_front;

% building the plot
positions_R = [1, 2]; % Positions pour la jambe droite
positions_L = [4, 5]; % Positions pour la jambe gauche
subplot(3,1,3);
ylim([0 20]);
hold on;
bar(1, mean(Boxplot_backsideR), 0.4, 'FaceColor', [0.8350 0.0780 0.1840], 'EdgeColor', 'k');
bar(2, mean(Boxplot_frontsideR), 0.4, 'FaceColor', [0.3010 0.7450 0.9330], 'EdgeColor', 'k');
bar(4, mean(Boxplot_backsideL), 0.4, 'FaceColor', [0.8350 0.0780 0.1840], 'EdgeColor', 'k');
bar(5, mean(Boxplot_frontsideL), 0.4, 'FaceColor', [0.3010 0.7450 0.9330], 'EdgeColor', 'k');

errorbar(positions_R, [mean(Boxplot_backsideR), mean(Boxplot_frontsideR)], ...
    [std(Boxplot_backsideR), std(Boxplot_frontsideR)], 'k', 'linestyle', 'none');
errorbar(positions_L, [mean(Boxplot_backsideL), mean(Boxplot_frontsideL)], ...
    [std(Boxplot_backsideL), std(Boxplot_frontsideL)], 'k', 'linestyle', 'none');

xticks([1.5, 4.5]);
xticklabels({'Right', 'Left'});
ylabel('RMS x tibia');
legend({'Backside', 'Frontside'});

% plot for pelvis
subplot(3,1,1);
ylim([0 20]);
Boxplot_backsideR = RMSx_pelvis_back;
Boxplot_frontsideR = RMSx_pelvis_front;
positions_R = [1, 2]; % Positions pour la jambe droite
hold on;
bar(1, mean(Boxplot_backsideR), 0.4, 'FaceColor', [0.8350 0.0780 0.1840], 'EdgeColor', 'k');
bar(2, mean(Boxplot_frontsideR), 0.4, 'FaceColor', [0.3010 0.7450 0.9330], 'EdgeColor', 'k');

errorbar(positions_R, [mean(Boxplot_backsideR), mean(Boxplot_frontsideR)], ...
    [std(Boxplot_backsideR), std(Boxplot_frontsideR)], 'k', 'linestyle', 'none');

xticks(1.5);
xticklabels({'Pelvis'});
ylabel('RMS');
legend({'Backside', 'Frontside'});


%% comparaison entre RMS X entre membre droit et gauche

% bar plot thigh
Boxplot_backsideR = RMSx_Rthigh_back;
Boxplot_backsideL = RMSx_Lthigh_back;
Boxplot_frontsideR = RMSx_Rthigh_front;
Boxplot_frontsideL = RMSx_Lthigh_front;

% building the plot
figure();
positions_B = [1, 2]; % Positions pour la jambe droite
positions_F = [4, 5]; % Positions pour la jambe gauche
subplot(3,1,2);
ylim([0 14]);
hold on;
bar(1, mean(Boxplot_backsideR), 0.4, 'FaceColor', [0.9290 0.6940 0.1250], 'EdgeColor', 'k');
bar(2, mean(Boxplot_backsideL), 0.4, 'FaceColor', [0 0.4470 0.7410], 'EdgeColor', 'k');
bar(4, mean(Boxplot_frontsideR), 0.4, 'FaceColor', [0.9290 0.6940 0.1250], 'EdgeColor', 'k');
bar(5, mean(Boxplot_frontsideL), 0.4, 'FaceColor', [0 0.4470 0.7410], 'EdgeColor', 'k');

errorbar(positions_B, [mean(Boxplot_backsideR), mean(Boxplot_backsideL)], ...
    [std(Boxplot_backsideR), std(Boxplot_backsideL)], 'k', 'linestyle', 'none');
errorbar(positions_F, [mean(Boxplot_frontsideR), mean(Boxplot_frontsideL)], ...
    [std(Boxplot_frontsideR), std(Boxplot_frontsideL)], 'k', 'linestyle', 'none');

xticks([1.5, 4.5]);
xticklabels({'backside', 'frontside'});
ylabel('RMS x thigh');
legend({'Right', 'Left'});

% bar plot tibia
Boxplot_backsideR = RMSx_Rtibia_back;
Boxplot_backsideL = RMSx_Ltibia_back;
Boxplot_frontsideR = RMSx_Rtibia_front;
Boxplot_frontsideL = RMSx_Ltibia_front;

% building the plot
positions_B = [1, 2]; % Positions pour la jambe droite
positions_F = [4, 5]; % Positions pour la jambe gauche
subplot(3,1,3);
ylim([0 14]);
hold on;
bar(1, mean(Boxplot_backsideR), 0.4, 'FaceColor', [0.9290 0.6940 0.1250], 'EdgeColor', 'k');
bar(2, mean(Boxplot_backsideL), 0.4, 'FaceColor', [0 0.4470 0.7410], 'EdgeColor', 'k');
bar(4, mean(Boxplot_frontsideR), 0.4, 'FaceColor', [0.9290 0.6940 0.1250], 'EdgeColor', 'k');
bar(5, mean(Boxplot_frontsideL), 0.4, 'FaceColor', [0 0.4470 0.7410], 'EdgeColor', 'k');

errorbar(positions_B, [mean(Boxplot_backsideR), mean(Boxplot_backsideL)], ...
    [std(Boxplot_backsideR), std(Boxplot_backsideL)], 'k', 'linestyle', 'none');
errorbar(positions_F, [mean(Boxplot_frontsideR), mean(Boxplot_frontsideL)], ...
    [std(Boxplot_frontsideR), std(Boxplot_frontsideL)], 'k', 'linestyle', 'none');

xticks([1.5, 4.5]);
xticklabels({'backside', 'frontside'});
ylabel('RMS x tibia');
legend({'Right', 'Left'});

% plot for pelvis
subplot(3,1,1);
ylim([0 14]);
Boxplot_backsideR = RMSx_pelvis_back;
Boxplot_frontsideR = RMSx_pelvis_front;
positions_R = [1, 2]; % Positions pour la jambe droite
hold on;
bar(1, mean(Boxplot_backsideR), 0.4, 'FaceColor', [0.9290 0.6940 0.1250], 'EdgeColor', 'k');
bar(2, mean(Boxplot_frontsideR), 0.4, 'FaceColor', [0 0.4470 0.7410], 'EdgeColor', 'k');

errorbar(positions_R, [mean(Boxplot_backsideR), mean(Boxplot_frontsideR)], ...
    [std(Boxplot_backsideR), std(Boxplot_frontsideR)], 'k', 'linestyle', 'none');

xticks([1, 2]);
xticklabels({'backside', 'frontside'});
ylabel('RMS');
% legend({'Backside', 'Frontside'});



%%


% figure vibrations selon x : axe vertical
figure();
for i =1 : length(cycle_data_acc.pelvis)
    subplot(3,2,[1 2]); hold on
    title(['vibrations x pelvis / RMS = ', num2str(RMSx_pelvis_mean)]);
    plot(cycle_data_acc.pelvis(i).pdata, cycle_data_acc.pelvis(i).ax,Color=[0.3010 0.7450 0.9330]);

    subplot(3,2,3); hold on
    title(['vibrations x cuisse droite / RMS = ', num2str(RMSx_Rthigh_mean)]);
    plot(cycle_data_acc.Rthigh(i).pdata, cycle_data_acc.Rthigh(i).ax,Color=[0.3010 0.7450 0.9330]);

    subplot(3,2,4); hold on
    title(['vibrations x cuisse gauche / RMS = ', num2str(RMSx_Lthigh_mean)]);
    plot(cycle_data_acc.Lthigh(i).pdata, cycle_data_acc.Lthigh(i).ax,Color=[0.3010 0.7450 0.9330]);

    subplot(3,2,5); hold on
    title(['vibrations x tibia droit / RMS = ', num2str(RMSx_Rtibia_mean)]);
    plot(cycle_data_acc.Rtibia(i).pdata, cycle_data_acc.Rtibia(i).ax,Color=[0.3010 0.7450 0.9330]);

    subplot(3,2,6); hold on
    title(['vibrations x tibia gauche / RMS = ', num2str(RMSx_Ltibia_mean)]);
    plot(cycle_data_acc.Ltibia(i).pdata, cycle_data_acc.Ltibia(i).ax,Color=[0.3010 0.7450 0.9330]);
end

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%% DANS LE PLAN HORIZONTAL (Y,Z) (NORME)
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

% calculs des RMSyz
RMSyz_pelvis_back = [];
RMSyz_pelvis_front = [];

RMSyz_Rthigh_back = [];
RMSyz_Rthigh_front = [];

RMSyz_Lthigh_back = [];
RMSyz_Lthigh_front = [];

RMSyz_Rtibia_back = [];
RMSyz_Rtibia_front = [];

RMSyz_Ltibia_back = [];
RMSyz_Ltibia_front = [];

for i = 1:length(cycle_data_acc.pelvis)
    RMSyz_pelvis_back = [RMSyz_pelvis_back, cycle_data_acc.pelvis(i).RMSaYZ_back];
    RMSyz_pelvis_front = [RMSyz_pelvis_front, cycle_data_acc.pelvis(i).RMSaYZ_front];

    RMSyz_Rthigh_back = [RMSyz_Rthigh_back, cycle_data_acc.Rthigh(i).RMSaYZ_back];
    RMSyz_Rthigh_front = [RMSyz_Rthigh_front, cycle_data_acc.Rthigh(i).RMSaYZ_front];

    RMSyz_Lthigh_back = [RMSyz_Lthigh_back, cycle_data_acc.Lthigh(i).RMSaYZ_back];
    RMSyz_Lthigh_front = [RMSyz_Lthigh_front, cycle_data_acc.Lthigh(i).RMSaYZ_front];

    RMSyz_Rtibia_back = [RMSyz_Rtibia_back, cycle_data_acc.Rtibia(i).RMSaYZ_back];
    RMSyz_Rtibia_front = [RMSyz_Rtibia_front, cycle_data_acc.Rtibia(i).RMSaYZ_front];

    RMSyz_Ltibia_back = [RMSyz_Ltibia_back, cycle_data_acc.Ltibia(i).RMSaYZ_back];
    RMSyz_Ltibia_front = [RMSyz_Ltibia_front, cycle_data_acc.Ltibia(i).RMSaYZ_front];
end

RMSyz_pelvis_mean_back = mean(RMSyz_pelvis_back);
RMSyz_pelvis_mean_front = mean(RMSyz_pelvis_front);
RMSyz_pelvis_std_back = std(RMSyz_pelvis_back);
RMSyz_pelvis_std_front = std(RMSyz_pelvis_front);

RMSyz_Rthigh_mean_back = mean(RMSyz_Rthigh_back);
RMSyz_Rthigh_mean_front = mean(RMSyz_Rthigh_front);
RMSyz_Rthigh_std_back = std(RMSyz_Rthigh_back);
RMSyz_Rthigh_std_front = std(RMSyz_Rthigh_front);

RMSyz_Lthigh_mean_back = mean(RMSyz_Lthigh_back);
RMSyz_Lthigh_mean_front = mean(RMSyz_Lthigh_front);
RMSyz_Lthigh_std_back = std(RMSyz_Lthigh_back);
RMSyz_Lthigh_std_front = std(RMSyz_Lthigh_front);

RMSyz_Rtibia_mean_back = mean(RMSyz_Rtibia_back);
RMSyz_Rtibia_mean_front = mean(RMSyz_Rtibia_front);
RMSyz_Rtibia_std_back = std(RMSyz_Rtibia_back);
RMSyz_Rtibia_std_front = std(RMSyz_Rtibia_front);

RMSyz_Ltibia_mean_back = mean(RMSyz_Ltibia_back);
RMSyz_Ltibia_mean_front = mean(RMSyz_Ltibia_front);
RMSyz_Ltibia_std_back = std(RMSyz_Ltibia_back);
RMSyz_Ltibia_std_front = std(RMSyz_Ltibia_front);


%% comparaison entre RMS X entre backside et frontside
% plot tibia
Boxplot_backsideR = RMSyz_Rtibia_back;
Boxplot_backsideL = RMSyz_Ltibia_back;
Boxplot_frontsideR = RMSyz_Rtibia_front;
Boxplot_frontsideL = RMSyz_Ltibia_front;

positions_R = [1, 2]; % Positions pour la jambe droite
positions_L = [4, 5]; % Positions pour la jambe gauche
subplot(3,1,3);
ylim([0 17]);
hold on;
bar(1, mean(Boxplot_backsideR), 0.4, 'FaceColor', [0.8350 0.0780 0.1840], 'EdgeColor', 'k');
bar(2, mean(Boxplot_frontsideR), 0.4, 'FaceColor', [0.3010 0.7450 0.9330], 'EdgeColor', 'k');
bar(4, mean(Boxplot_backsideL), 0.4, 'FaceColor', [0.8350 0.0780 0.1840], 'EdgeColor', 'k');
bar(5, mean(Boxplot_frontsideL), 0.4, 'FaceColor', [0.3010 0.7450 0.9330], 'EdgeColor', 'k');

errorbar(positions_R, [mean(Boxplot_backsideR), mean(Boxplot_frontsideR)], ...
    [std(Boxplot_backsideR), std(Boxplot_frontsideR)], 'k', 'linestyle', 'none');
errorbar(positions_L, [mean(Boxplot_backsideL), mean(Boxplot_frontsideL)], ...
    [std(Boxplot_backsideL), std(Boxplot_frontsideL)], 'k', 'linestyle', 'none');

xticks([1.5, 4.5]);
xticklabels({'Right', 'Left'});
ylabel('RMS yz Tibia');
legend({'Backside', 'Frontside'});

% plot cuisse
Boxplot_backsideR = RMSyz_Rthigh_back;
Boxplot_backsideL = RMSyz_Lthigh_back;
Boxplot_frontsideR = RMSyz_Rthigh_front;
Boxplot_frontsideL = RMSyz_Lthigh_front;

positions_R = [1, 2]; % Positions pour la jambe droite
positions_L = [4, 5]; % Positions pour la jambe gauche
subplot(3,1,2);
ylim([0 17]);
hold on;
bar(1, mean(Boxplot_backsideR), 0.4, 'FaceColor', [0.8350 0.0780 0.1840], 'EdgeColor', 'k');
bar(2, mean(Boxplot_frontsideR), 0.4, 'FaceColor', [0.3010 0.7450 0.9330], 'EdgeColor', 'k');
bar(4, mean(Boxplot_backsideL), 0.4, 'FaceColor', [0.8350 0.0780 0.1840], 'EdgeColor', 'k');
bar(5, mean(Boxplot_frontsideL), 0.4, 'FaceColor', [0.3010 0.7450 0.9330], 'EdgeColor', 'k');

errorbar(positions_R, [mean(Boxplot_backsideR), mean(Boxplot_frontsideR)], ...
    [std(Boxplot_backsideR), std(Boxplot_frontsideR)], 'k', 'linestyle', 'none');
errorbar(positions_L, [mean(Boxplot_backsideL), mean(Boxplot_frontsideL)], ...
    [std(Boxplot_backsideL), std(Boxplot_frontsideL)], 'k', 'linestyle', 'none');

xticks([1.5, 4.5]);
xticklabels({'Right', 'Left'});
ylabel('RMS yz Cuisse');
legend({'Backside', 'Frontside'});

% plot pelvis
subplot(3,1,1);
ylim([0 17]);
Boxplot_backsideR = RMSyz_pelvis_back;
Boxplot_frontsideR = RMSyz_pelvis_front;

positions_R = [1, 2]; % Positions pour la jambe droite
hold on;
bar(1, mean(Boxplot_backsideR), 0.4, 'FaceColor', [0.8350 0.0780 0.1840], 'EdgeColor', 'k');
bar(2, mean(Boxplot_frontsideR), 0.4, 'FaceColor', [0.3010 0.7450 0.9330], 'EdgeColor', 'k');

errorbar(positions_R, [mean(Boxplot_backsideR), mean(Boxplot_frontsideR)], ...
    [std(Boxplot_backsideR), std(Boxplot_frontsideR)], 'k', 'linestyle', 'none');

xticks(1.5);
xticklabels({'Pelvis'});
ylabel('RMS yz Pelvis');
legend({'Backside', 'Frontside'});


%% comparaison entre RMS yz entre membre droit et gauche

% bar plot thigh
Boxplot_backsideR = RMSyz_Rthigh_back;
Boxplot_backsideL = RMSyz_Lthigh_back;
Boxplot_frontsideR = RMSyz_Rthigh_front;
Boxplot_frontsideL = RMSyz_Lthigh_front;

% building the plot
figure();
positions_B = [1, 2]; % Positions pour la jambe droite
positions_F = [4, 5]; % Positions pour la jambe gauche
subplot(3,1,2);
ylim([0 12]);
hold on;
bar(1, mean(Boxplot_backsideR), 0.4, 'FaceColor', [0.9290 0.6940 0.1250], 'EdgeColor', 'k');
bar(2, mean(Boxplot_backsideL), 0.4, 'FaceColor', [0 0.4470 0.7410], 'EdgeColor', 'k');
bar(4, mean(Boxplot_frontsideR), 0.4, 'FaceColor', [0.9290 0.6940 0.1250], 'EdgeColor', 'k');
bar(5, mean(Boxplot_frontsideL), 0.4, 'FaceColor', [0 0.4470 0.7410], 'EdgeColor', 'k');

errorbar(positions_B, [mean(Boxplot_backsideR), mean(Boxplot_backsideL)], ...
    [std(Boxplot_backsideR), std(Boxplot_backsideL)], 'k', 'linestyle', 'none');
errorbar(positions_F, [mean(Boxplot_frontsideR), mean(Boxplot_frontsideL)], ...
    [std(Boxplot_frontsideR), std(Boxplot_frontsideL)], 'k', 'linestyle', 'none');

xticks([1.5, 4.5]);
xticklabels({'backside', 'frontside'});
ylabel('RMS yz thigh');
legend({'Right', 'Left'});

% bar plot tibia
Boxplot_backsideR = RMSyz_Rtibia_back;
Boxplot_backsideL = RMSyz_Ltibia_back;
Boxplot_frontsideR = RMSyz_Rtibia_front;
Boxplot_frontsideL = RMSyz_Ltibia_front;

% building the plot
positions_B = [1, 2]; % Positions pour la jambe droite
positions_F = [4, 5]; % Positions pour la jambe gauche
subplot(3,1,3);
ylim([0 12]);
hold on;
bar(1, mean(Boxplot_backsideR), 0.4, 'FaceColor', [0.9290 0.6940 0.1250], 'EdgeColor', 'k');
bar(2, mean(Boxplot_backsideL), 0.4, 'FaceColor', [0 0.4470 0.7410], 'EdgeColor', 'k');
bar(4, mean(Boxplot_frontsideR), 0.4, 'FaceColor', [0.9290 0.6940 0.1250], 'EdgeColor', 'k');
bar(5, mean(Boxplot_frontsideL), 0.4, 'FaceColor', [0 0.4470 0.7410], 'EdgeColor', 'k');

errorbar(positions_B, [mean(Boxplot_backsideR), mean(Boxplot_backsideL)], ...
    [std(Boxplot_backsideR), std(Boxplot_backsideL)], 'k', 'linestyle', 'none');
errorbar(positions_F, [mean(Boxplot_frontsideR), mean(Boxplot_frontsideL)], ...
    [std(Boxplot_frontsideR), std(Boxplot_frontsideL)], 'k', 'linestyle', 'none');

xticks([1.5, 4.5]);
xticklabels({'backside', 'frontside'});
ylabel('RMS yz tibia');
legend({'Right', 'Left'});

% plot for pelvis
subplot(3,1,1);
ylim([0 12]);
Boxplot_backsideR = RMSyz_pelvis_back;
Boxplot_frontsideR = RMSyz_pelvis_front;
positions_R = [1, 2]; % Positions pour la jambe droite
hold on;
bar(1, mean(Boxplot_backsideR), 0.4, 'FaceColor', [0.9290 0.6940 0.1250], 'EdgeColor', 'k');
bar(2, mean(Boxplot_frontsideR), 0.4, 'FaceColor', [0 0.4470 0.7410], 'EdgeColor', 'k');

errorbar(positions_R, [mean(Boxplot_backsideR), mean(Boxplot_frontsideR)], ...
    [std(Boxplot_backsideR), std(Boxplot_frontsideR)], 'k', 'linestyle', 'none');

xticks([1, 2]);
xticklabels({'backside', 'frontside'});
ylabel('RMS yz pelvis');
% legend({'Backside', 'Frontside'});



%%
% plot acc dans le plan horizontal (y,z)
figure();
for i =1 : length(cycle_data_acc.pelvis)
    % backside
    subplot(3,4,[1 2]); hold on
    ylim([-5 20]);
    title(['BACKSIDE vibrations yz pelvis / RMS = ']);
    plot(cycle_data_acc.pelvis(i).pdata_back  , cycle_data_acc.pelvis(i).ayzback  ,Color=[0.3010 0.7450 0.9330]);

    subplot(3,4,5); hold on
    ylim([-5 65]);
    title(['vibrations yz cuisse droite / RMS = ']);
    plot(cycle_data_acc.Rthigh(i).pdata_back, cycle_data_acc.Rthigh(i).ayzback,Color=[0.3010 0.7450 0.9330]);

    subplot(3,4,6); hold on
    ylim([-5 65]);
    title(['vibrations yz cuisse gauche / RMS = ']);
    plot(cycle_data_acc.Lthigh(i).pdata_back, cycle_data_acc.Lthigh(i).ayzback,Color=[0.3010 0.7450 0.9330]);

    subplot(3,4,9); hold on
    ylim([-5 110]);
    title(['vibrations yz tibia droit / RMS = ']);
    plot(cycle_data_acc.Rtibia(i).pdata_back, cycle_data_acc.Rtibia(i).ayzback,Color=[0.3010 0.7450 0.9330]);

    subplot(3,4,10); hold on
    ylim([-5 110]);
    title(['vibrations yz tibia gauche / RMS = ']);
    plot(cycle_data_acc.Ltibia(i).pdata_back, cycle_data_acc.Ltibia(i).ayzback,Color=[0.3010 0.7450 0.9330]);

    % frontside
    subplot(3,4,[3 4]); hold on
    ylim([-5 20]);
    title(['FRONTSIDE vibrations yz pelvis / RMS = ']);
    plot(cycle_data_acc.pelvis(i).pdata_front  , cycle_data_acc.pelvis(i).ayzfront  ,Color=[0.1010 0.9450 0.9330]);

    subplot(3,4,7); hold on
    ylim([-5 65]);
    title(['vibrations yz cuisse droite / RMS = ']);
    plot(cycle_data_acc.Rthigh(i).pdata_front, cycle_data_acc.Rthigh(i).ayzfront,Color=[0.1010 0.9450 0.9330]);

    subplot(3,4,8); hold on
    ylim([-5 65]);
    title(['vibrations yz cuisse gauche / RMS = ']);
    plot(cycle_data_acc.Lthigh(i).pdata_front, cycle_data_acc.Lthigh(i).ayzfront,Color=[0.1010 0.9450 0.9330]);

    subplot(3,4,11); hold on
    ylim([-5 110]);
    title(['vibrations yz tibia droit / RMS = ']);
    plot(cycle_data_acc.Rtibia(i).pdata_front, cycle_data_acc.Rtibia(i).ayzfront,Color=[0.1010 0.9450 0.9330]);

    subplot(3,4,12); hold on
    ylim([-5 110]);
    title(['vibrations yz tibia gauche / RMS = ']);
    plot(cycle_data_acc.Ltibia(i).pdata_front, cycle_data_acc.Ltibia(i).ayzfront,Color=[0.1010 0.9450 0.9330]);
end


%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%% SUR LES AXES X Y ET Z (NORME)
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

% calculs des RMSyz
RMSxyz_pelvis_back = [];
RMSxyz_pelvis_front = [];

RMSxyz_Rthigh_back = [];
RMSxyz_Rthigh_front = [];

RMSxyz_Lthigh_back = [];
RMSxyz_Lthigh_front = [];

RMSxyz_Rtibia_back = [];
RMSxyz_Rtibia_front = [];

RMSxyz_Ltibia_back = [];
RMSxyz_Ltibia_front = [];

for i = 1:length(cycle_data_acc.pelvis)
    RMSxyz_pelvis_back = [RMSxyz_pelvis_back, cycle_data_acc.pelvis(i).RMSaXYZ_back];
    RMSxyz_pelvis_front = [RMSxyz_pelvis_front, cycle_data_acc.pelvis(i).RMSaXYZ_front];

    RMSxyz_Rthigh_back = [RMSxyz_Rthigh_back, cycle_data_acc.Rthigh(i).RMSaXYZ_back];
    RMSxyz_Rthigh_front = [RMSxyz_Rthigh_front, cycle_data_acc.Rthigh(i).RMSaXYZ_front];

    RMSxyz_Lthigh_back = [RMSxyz_Lthigh_back, cycle_data_acc.Lthigh(i).RMSaXYZ_back];
    RMSxyz_Lthigh_front = [RMSxyz_Lthigh_front, cycle_data_acc.Lthigh(i).RMSaXYZ_front];

    RMSxyz_Rtibia_back = [RMSxyz_Rtibia_back, cycle_data_acc.Rtibia(i).RMSaXYZ_back];
    RMSxyz_Rtibia_front = [RMSxyz_Rtibia_front, cycle_data_acc.Rtibia(i).RMSaXYZ_front];

    RMSxyz_Ltibia_back = [RMSxyz_Ltibia_back, cycle_data_acc.Ltibia(i).RMSaXYZ_back];
    RMSxyz_Ltibia_front = [RMSxyz_Ltibia_front, cycle_data_acc.Ltibia(i).RMSaXYZ_front];
end

RMSxyz_pelvis_mean_back = mean(RMSxyz_pelvis_back);
RMSxyz_pelvis_mean_front = mean(RMSxyz_pelvis_front);
RMSxyz_pelvis_std_back = std(RMSxyz_pelvis_back);
RMSxyz_pelvis_std_front = std(RMSxyz_pelvis_front);

RMSxyz_Rthigh_mean_back = mean(RMSxyz_Rthigh_back);
RMSxyz_Rthigh_mean_front = mean(RMSxyz_Rthigh_front);
RMSxyz_Rthigh_std_back = std(RMSxyz_Rthigh_back);
RMSxyz_Rthigh_std_front = std(RMSxyz_Rthigh_front);

RMSxyz_Lthigh_mean_back = mean(RMSxyz_Lthigh_back);
RMSxyz_Lthigh_mean_front = mean(RMSxyz_Lthigh_front);
RMSxyz_Lthigh_std_back = std(RMSxyz_Lthigh_back);
RMSxyz_Lthigh_std_front = std(RMSxyz_Lthigh_front);

RMSxyz_Rtibia_mean_back = mean(RMSxyz_Rtibia_back);
RMSxyz_Rtibia_mean_front = mean(RMSxyz_Rtibia_front);
RMSxyz_Rtibia_std_back = std(RMSxyz_Rtibia_back);
RMSxyz_Rtibia_std_front = std(RMSxyz_Rtibia_front);

RMSxyz_Ltibia_mean_back = mean(RMSxyz_Ltibia_back);
RMSxyz_Ltibia_mean_front = mean(RMSxyz_Ltibia_front);
RMSxyz_Ltibia_std_back = std(RMSxyz_Ltibia_back);
RMSxyz_Ltibia_std_front = std(RMSxyz_Ltibia_front);

%% bar plot
% plot tibia
Boxplot_backsideR = RMSxyz_Rtibia_back;
Boxplot_backsideL = RMSxyz_Ltibia_back;
Boxplot_frontsideR = RMSxyz_Rtibia_front;
Boxplot_frontsideL = RMSxyz_Ltibia_front;

positions_R = [1, 2]; % Positions pour la jambe droite
positions_L = [4, 5]; % Positions pour la jambe gauche
subplot(3,1,3);
ylim([0 24]);
hold on;
bar(1, mean(Boxplot_backsideR), 0.4, 'FaceColor', [0.8350 0.0780 0.1840], 'EdgeColor', 'k');
bar(2, mean(Boxplot_frontsideR), 0.4, 'FaceColor', [0.3010 0.7450 0.9330], 'EdgeColor', 'k');
bar(4, mean(Boxplot_backsideL), 0.4, 'FaceColor', [0.8350 0.0780 0.1840], 'EdgeColor', 'k');
bar(5, mean(Boxplot_frontsideL), 0.4, 'FaceColor', [0.3010 0.7450 0.9330], 'EdgeColor', 'k');

errorbar(positions_R, [mean(Boxplot_backsideR), mean(Boxplot_frontsideR)], ...
    [std(Boxplot_backsideR), std(Boxplot_frontsideR)], 'k', 'linestyle', 'none');
errorbar(positions_L, [mean(Boxplot_backsideL), mean(Boxplot_frontsideL)], ...
    [std(Boxplot_backsideL), std(Boxplot_frontsideL)], 'k', 'linestyle', 'none');

xticks([1.5, 4.5]);
xticklabels({'Right', 'Left'});
ylabel('RMS xyz Tibia');
legend({'Backside', 'Frontside'});

% plot cuisse
Boxplot_backsideR = RMSxyz_Rthigh_back;
Boxplot_backsideL = RMSxyz_Lthigh_back;
Boxplot_frontsideR = RMSxyz_Rthigh_front;
Boxplot_frontsideL = RMSxyz_Lthigh_front;

positions_R = [1, 2]; % Positions pour la jambe droite
positions_L = [4, 5]; % Positions pour la jambe gauche
subplot(3,1,2);
ylim([0 24]);
hold on;
bar(1, mean(Boxplot_backsideR), 0.4, 'FaceColor', [0.8350 0.0780 0.1840], 'EdgeColor', 'k');
bar(2, mean(Boxplot_frontsideR), 0.4, 'FaceColor', [0.3010 0.7450 0.9330], 'EdgeColor', 'k');
bar(4, mean(Boxplot_backsideL), 0.4, 'FaceColor', [0.8350 0.0780 0.1840], 'EdgeColor', 'k');
bar(5, mean(Boxplot_frontsideL), 0.4, 'FaceColor', [0.3010 0.7450 0.9330], 'EdgeColor', 'k');

errorbar(positions_R, [mean(Boxplot_backsideR), mean(Boxplot_frontsideR)], ...
    [std(Boxplot_backsideR), std(Boxplot_frontsideR)], 'k', 'linestyle', 'none');
errorbar(positions_L, [mean(Boxplot_backsideL), mean(Boxplot_frontsideL)], ...
    [std(Boxplot_backsideL), std(Boxplot_frontsideL)], 'k', 'linestyle', 'none');

xticks([1.5, 4.5]);
xticklabels({'Right', 'Left'});
ylabel('RMS xyz Cuisse');
legend({'Backside', 'Frontside'});

% plot pelvis
subplot(3,1,1);
ylim([0 24]);
Boxplot_backsideR = RMSxyz_pelvis_back;
Boxplot_frontsideR = RMSxyz_pelvis_front;

positions_R = [1, 2]; % Positions pour la jambe droite
hold on;
bar(1, mean(Boxplot_backsideR), 0.4, 'FaceColor', [0.8350 0.0780 0.1840], 'EdgeColor', 'k');
bar(2, mean(Boxplot_frontsideR), 0.4, 'FaceColor', [0.3010 0.7450 0.9330], 'EdgeColor', 'k');

errorbar(positions_R, [mean(Boxplot_backsideR), mean(Boxplot_frontsideR)], ...
    [std(Boxplot_backsideR), std(Boxplot_frontsideR)], 'k', 'linestyle', 'none');

xticks(1.5);
xticklabels({'Pelvis'});
ylabel('RMS xyz Pelvis');
legend({'Backside', 'Frontside'});

%% comparaison entre RMS xyz entre membre droit et gauche

% bar plot thigh
Boxplot_backsideR = RMSxyz_Rthigh_back;
Boxplot_backsideL = RMSxyz_Lthigh_back;
Boxplot_frontsideR = RMSxyz_Rthigh_front;
Boxplot_frontsideL = RMSxyz_Lthigh_front;

% building the plot
figure();
positions_B = [1, 2]; % Positions pour la jambe droite
positions_F = [4, 5]; % Positions pour la jambe gauche
subplot(3,1,2);
ylim([0 17]);
hold on;
bar(1, mean(Boxplot_backsideR), 0.4, 'FaceColor', [0.9290 0.6940 0.1250], 'EdgeColor', 'k');
bar(2, mean(Boxplot_backsideL), 0.4, 'FaceColor', [0 0.4470 0.7410], 'EdgeColor', 'k');
bar(4, mean(Boxplot_frontsideR), 0.4, 'FaceColor', [0.9290 0.6940 0.1250], 'EdgeColor', 'k');
bar(5, mean(Boxplot_frontsideL), 0.4, 'FaceColor', [0 0.4470 0.7410], 'EdgeColor', 'k');

errorbar(positions_B, [mean(Boxplot_backsideR), mean(Boxplot_backsideL)], ...
    [std(Boxplot_backsideR), std(Boxplot_backsideL)], 'k', 'linestyle', 'none');
errorbar(positions_F, [mean(Boxplot_frontsideR), mean(Boxplot_frontsideL)], ...
    [std(Boxplot_frontsideR), std(Boxplot_frontsideL)], 'k', 'linestyle', 'none');

xticks([1.5, 4.5]);
xticklabels({'backside', 'frontside'});
ylabel('RMS xyz thigh');
legend({'Right', 'Left'});

% bar plot tibia
Boxplot_backsideR = RMSxyz_Rtibia_back;
Boxplot_backsideL = RMSxyz_Ltibia_back;
Boxplot_frontsideR = RMSxyz_Rtibia_front;
Boxplot_frontsideL = RMSxyz_Ltibia_front;

% building the plot
positions_B = [1, 2]; % Positions pour la jambe droite
positions_F = [4, 5]; % Positions pour la jambe gauche
subplot(3,1,3);
ylim([0 17]);
hold on;
bar(1, mean(Boxplot_backsideR), 0.4, 'FaceColor', [0.9290 0.6940 0.1250], 'EdgeColor', 'k');
bar(2, mean(Boxplot_backsideL), 0.4, 'FaceColor', [0 0.4470 0.7410], 'EdgeColor', 'k');
bar(4, mean(Boxplot_frontsideR), 0.4, 'FaceColor', [0.9290 0.6940 0.1250], 'EdgeColor', 'k');
bar(5, mean(Boxplot_frontsideL), 0.4, 'FaceColor', [0 0.4470 0.7410], 'EdgeColor', 'k');

errorbar(positions_B, [mean(Boxplot_backsideR), mean(Boxplot_backsideL)], ...
    [std(Boxplot_backsideR), std(Boxplot_backsideL)], 'k', 'linestyle', 'none');
errorbar(positions_F, [mean(Boxplot_frontsideR), mean(Boxplot_frontsideL)], ...
    [std(Boxplot_frontsideR), std(Boxplot_frontsideL)], 'k', 'linestyle', 'none');

xticks([1.5, 4.5]);
xticklabels({'backside', 'frontside'});
ylabel('RMS xyz tibia');
legend({'Right', 'Left'});

% plot for pelvis
subplot(3,1,1);
ylim([0 17]);
Boxplot_backsideR = RMSxyz_pelvis_back;
Boxplot_frontsideR = RMSxyz_pelvis_front;
positions_R = [1, 2]; % Positions pour la jambe droite
hold on;
bar(1, mean(Boxplot_backsideR), 0.4, 'FaceColor', [0.9290 0.6940 0.1250], 'EdgeColor', 'k');
bar(2, mean(Boxplot_frontsideR), 0.4, 'FaceColor', [0 0.4470 0.7410], 'EdgeColor', 'k');

errorbar(positions_R, [mean(Boxplot_backsideR), mean(Boxplot_frontsideR)], ...
    [std(Boxplot_backsideR), std(Boxplot_frontsideR)], 'k', 'linestyle', 'none');

xticks([1, 2]);
xticklabels({'backside', 'frontside'});
ylabel('RMS xyz pelvis');
% legend({'Backside', 'Frontside'});

%%

matbs = repmat(data_acce.TS01306.Vt, [1 length(tbs)]);
matfs = repmat(data_acce.TS01306.Vt, [1 length(tfs)]);
[minval, closeind_bs] = min(abs(matbs-tbs'));
[minval2, closeind_fs] = min(abs(matfs-tfs'));

frame_bs_acc = closeind_bs';
frame_fs_acc = closeind_fs';

time_bs_acc = [];
time_fs_acc = [];
for i = 1:length(tbs)
    time_bs_acc = [time_bs_acc; data_acce.TS01306.Vt(closeind_bs(i))];
end
for i = 1:length(tfs)
    time_fs_acc = [time_fs_acc; data_acce.TS01306.Vt(closeind_fs(i))];
end




T = data_acce.TS03141.Vt;
pelvis = data_acce.TS03141.ax;
freq_acquis = 1600;
freq_coup = 20;
N = 2;
[b,a] = butter(N, freq_coup/(freq_acquis/2), "low");

filter_data = filtfilt(b,a,pelvis);

figure();
hold on;
% plot(T, pelvis, 'b');
plot(T,filter_data, 'b');


xline(time_bs_acc,'-m', {'backside'});
xline(time_fs_acc, '-c',{'frontside'});

% freqz(b,a,512,freq_acquis);



%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%
T = data_acce.TS01306.Vt;

subplot(2,1,1);
hold on;
plot(T, data_acce.TS01306.ax);
plot(T, data_acce.TS01306.ay);
plot(T, data_acce.TS01306.az);
xlabel('time (s)');
ylabel('Acc x (m/s2)');
title('Accel pelvis');

xline(tbs, '-m', {'backside'});
xline(tfs, '-b', {'frontside'});

subplot(2,1,2);
hold on;
plot(time/1000, label_essai.sensorData(1).sensorFreeAcceleration(frame_debut:frame_fin,1));
plot(time/1000, label_essai.sensorData(1).sensorFreeAcceleration(frame_debut:frame_fin,2));
plot(time/1000, label_essai.sensorData(1).sensorFreeAcceleration(frame_debut:frame_fin,3));

xline(tbs, '-m', {'backside'});
xline(tfs, '-b', {'frontside'});



