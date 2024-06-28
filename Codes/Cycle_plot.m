% cycle data and processing : plot the kinematic of lower limb joint

clear all;
close all;
clc;

addpath(genpath('Z:\HANDISNOW'));
Xsens_raw = load('Raw_data_Xsens.mat');
Xsens_cycle = load('Cycle_data_Xsens_sternum_pelvis_board.mat');

%% import the data
nolvl_lull001 = Xsens_raw.Raw_data_Xsens.luli001;

nolvl_mabr001 = Xsens_raw.Raw_data_Xsens.mabr001;

nolvl_pabi010 = Xsens_raw.Raw_data_Xsens.pabi010;

nolvl_paba021 = Xsens_raw.Raw_data_Xsens.paba021;

nolvl_solo001 = Xsens_raw.Raw_data_Xsens.solo001;

nolvl_maxi001 = Xsens_raw.Raw_data_Xsens.maxi001;
nolvl_maxi002 = Xsens_raw.Raw_data_Xsens.maxi002;

%% LULI
% indice_premier_frontside = 12;
% nb_cycle = 10;
% 
% cycle_data_luli = Cycle_data_determination(indice_premier_frontside,nb_cycle, nolvl_lull001 );
cycle_set_luli = Cycle_data_determination2(nolvl_lull001 );
cycle_data_luli = Cycle_data_set(cycle_set_luli, [6, 9, 14, 21, 22, 23, 24]);
% cycle_data_luli = Cycle_data_set(cycle_data_luli2, []);

%% MABR
% indice_premier_frontside = 13;
% nb_cycle = 8;
% 
% cycle_data_mabr = Cycle_data_determination(indice_premier_frontside,nb_cycle, nolvl_mabr001 );
cycle_set_mabr = Cycle_data_determination2(nolvl_mabr001);
cycle_data_mabr = Cycle_data_set(cycle_set_mabr, [9,18]);

%% PABI
% indice_premier_frontside = 1;
% nb_cycle = 7;
% 
% cycle_data_pabi = Cycle_data_determination(indice_premier_frontside,nb_cycle, nolvl_pabi010 );
cycle_set_pabi = Cycle_data_determination2(nolvl_pabi010);
cycle_data_pabi = Cycle_data_set(cycle_set_pabi, [8, 9, 14]);

%% PABA
% indice_premier_frontside = 16;
% nb_cycle = 6;
% 
% cycle_data_paba = Cycle_data_determination(indice_premier_frontside,nb_cycle, nolvl_paba021 );
cycle_set_paba = Cycle_data_determination2(nolvl_paba021);
cycle_data_paba = Cycle_data_set(cycle_set_paba, [2, 6, 9, 13, 15]);

%% SOLO

cycle_data_solo2 = Cycle_data_determination2(nolvl_solo001);
cycle_data_solo = Cycle_data_set(cycle_data_solo2, [2, 9, 13]);

%% MAXIME

cycle_set_maxi1 = Cycle_data_determination2(nolvl_maxi001);
cycle_set_maxi2 = Cycle_data_determination2(nolvl_maxi002);

cycle_set_maxi = struct();
names = fieldnames(cycle_set_maxi1);
for i = 1: length(names)
    names_var = names{i};
    cycle_set_maxi.(names_var) = horzcat( cycle_set_maxi1.(names_var), cycle_set_maxi2.(names_var));
end

cycle_data_maxi = Cycle_data_set(cycle_set_maxi, [1,9,10,14]);


%% import data cycled
cycle_data_luli = Xsens_cycle.ALL.luli;
cycle_data_pabi = Xsens_cycle.ALL.pabi;
cycle_data_paba = Xsens_cycle.ALL.paba;
cycle_data_mabr = Xsens_cycle.ALL.mabr;
cycle_data_solo = Xsens_cycle.ALL.solo;
cycle_data_maxi = Xsens_cycle.ALL.maxi;



%% %%%%
%%%%%% checking the cycle for one subject
subject = cycle_set_maxi1;
figure();
for i = 2 : 8

    % plot data for all the cycles - ANKLE
    subplot(3,1,3)
    hold on
    plot(subject.ankle(i).pdata, subject.ankle(i).Rjoint ,  LineWidth=0.5, DisplayName=['RA', num2str(i)]);%, Color=[0.8500 0.3250 0.0980]);
    plot(subject.ankle(i).pdata, subject.ankle(i).Ljoint , 'LineStyle', '--',   LineWidth=0.5, DisplayName=['LA', num2str(i)]);%, Color=[0.3010 0.7450 0.9330]);

    % KNEE
    subplot(3,1,2)
    hold on
    plot(subject.knee(i).pdata, subject.knee(i).Rjoint ,  LineWidth=0.5, DisplayName=['RK', num2str(i)]);%, Color=[0.8500 0.3250 0.0980]);
    plot(subject.knee(i).pdata, subject.knee(i).Ljoint , 'LineStyle', '--',  LineWidth=0.5, DisplayName=['LK', num2str(i)]);%, Color=[0.3010 0.7450 0.9330]);
    
    % HIP
    subplot(3,1,1)
    hold on
    plot(subject.hip(i).pdata, subject.hip(i).Rjoint ,  LineWidth=0.5, DisplayName=['RH', num2str(i)]);%, Color=[0.8500 0.3250 0.0980]);
    plot(subject.hip(i).pdata, subject.hip(i).Ljoint , 'LineStyle', '--',  LineWidth=0.5, DisplayName=['LH', num2str(i)]);%, Color=[0.3010 0.7450 0.9330]);

end
for i =1:3
    subplot(3,1,i)
    legend();
end

%%%%%%
%% %%%%

%% SUBPLOTS - UL AND LL1

%% LULI %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
figure();
for i = 1 : length(cycle_data_luli.ankle)

    % plot data for all the cycles - ANKLE
    subplot(3,3,7)
    ylim([-20 50]);
    hold on
    plot(cycle_data_luli.ankle(i).pdata, cycle_data_luli.ankle(i).Rjoint ,  LineWidth=0.5, Color=[0.8500 0.3250 0.0980]);
    plot(cycle_data_luli.ankle(i).pdata, cycle_data_luli.ankle(i).Ljoint ,  LineWidth=0.5, Color=[0.3010 0.7450 0.9330]);

    % KNEE
    subplot(3,3,4)
    ylim([-10 80]);
    hold on
    plot(cycle_data_luli.knee(i).pdata, cycle_data_luli.knee(i).Rjoint ,  LineWidth=0.5, Color=[0.8500 0.3250 0.0980]);
    plot(cycle_data_luli.knee(i).pdata, cycle_data_luli.knee(i).Ljoint ,  LineWidth=0.5, Color=[0.3010 0.7450 0.9330]);
    
    % HIP
    subplot(3,3,1)
    ylim([-10 90]);
    hold on
    plot(cycle_data_luli.hip(i).pdata, cycle_data_luli.hip(i).Rjoint ,  LineWidth=0.5, Color=[0.8500 0.3250 0.0980]);
    plot(cycle_data_luli.hip(i).pdata, cycle_data_luli.hip(i).Ljoint ,  LineWidth=0.5, Color=[0.3010 0.7450 0.9330]);

end

% plot stats membres inf
subplot(3,3,7)
% ylim([-20 50]);
ylim([-20 100]);
hold on
plot(cycle_data_luli.XData, cycle_data_luli.ankle(1).MeanR , 'b', LineWidth=1.7);
plot(cycle_data_luli.XData, cycle_data_luli.ankle(1).MeanL , 'r', LineWidth=1.7);
x2 = [cycle_data_luli.XData', fliplr(cycle_data_luli.XData')];
inBetweenR = [(cycle_data_luli.ankle(1).MeanR + cycle_data_luli.ankle(1).stand_devR)',fliplr((cycle_data_luli.ankle(1).MeanR - cycle_data_luli.ankle(1).stand_devR)')];
fill(x2, inBetweenR, 'b','FaceAlpha', 0.1, 'EdgeColor','none');
inBetweenL = [(cycle_data_luli.ankle(1).MeanL + cycle_data_luli.ankle(1).stand_devL)',fliplr((cycle_data_luli.ankle(1).MeanL - cycle_data_luli.ankle(1).stand_devL)')];
fill(x2, inBetweenL, 'r','FaceAlpha', 0.1, 'EdgeColor','none');

subplot(3,3,4)
% ylim([-10 80]);
ylim([-20 100]);
hold on
plot(cycle_data_luli.XData, cycle_data_luli.knee(1).MeanR , 'b', LineWidth=1.7);
plot(cycle_data_luli.XData, cycle_data_luli.knee(1).MeanL , 'r', LineWidth=1.7);
x2 = [cycle_data_luli.XData', fliplr(cycle_data_luli.XData')];
inBetweenR = [(cycle_data_luli.knee(1).MeanR + cycle_data_luli.knee(1).stand_devR)',fliplr((cycle_data_luli.knee(1).MeanR - cycle_data_luli.knee(1).stand_devR)')];
fill(x2, inBetweenR, 'b','FaceAlpha', 0.1, 'EdgeColor','none');
inBetweenL = [(cycle_data_luli.knee(1).MeanL + cycle_data_luli.knee(1).stand_devL)',fliplr((cycle_data_luli.knee(1).MeanL - cycle_data_luli.knee(1).stand_devL)')];
fill(x2, inBetweenL, 'r','FaceAlpha', 0.1, 'EdgeColor','none');

subplot(3,3,1)
ylim([-20 100]);
hold on
plot(cycle_data_luli.XData, cycle_data_luli.hip(1).MeanR , 'b', LineWidth=1.7);
plot(cycle_data_luli.XData, cycle_data_luli.hip(1).MeanL , 'r', LineWidth=1.7);
x2 = [cycle_data_luli.XData', fliplr(cycle_data_luli.XData')];
inBetweenR = [(cycle_data_luli.hip(1).MeanR + cycle_data_luli.hip(1).stand_devR)',fliplr((cycle_data_luli.hip(1).MeanR - cycle_data_luli.hip(1).stand_devR)')];
fill(x2, inBetweenR, 'b','FaceAlpha', 0.1, 'EdgeColor','none');
inBetweenL = [(cycle_data_luli.hip(1).MeanL + cycle_data_luli.hip(1).stand_devL)',fliplr((cycle_data_luli.hip(1).MeanL - cycle_data_luli.hip(1).stand_devL)')];
fill(x2, inBetweenL, 'r','FaceAlpha', 0.1, 'EdgeColor','none');

% plot backside limitation membres inf
subplot(3,3,7)
xline(cycle_data_luli.FS.mean, '-k', linewidth=1);
xline(cycle_data_luli.FS.mean-cycle_data_luli.FS.sd, ':k');
xline(cycle_data_luli.FS.mean+cycle_data_luli.FS.sd, ':k');
subplot(3,3,4)
xline(cycle_data_luli.FS.mean, '-k', linewidth=1);
xline(cycle_data_luli.FS.mean-cycle_data_luli.FS.sd, ':k');
xline(cycle_data_luli.FS.mean+cycle_data_luli.FS.sd, ':k');
subplot(3,3,1)
xline(cycle_data_luli.FS.mean, '-k', linewidth=1);
xline(cycle_data_luli.FS.mean-cycle_data_luli.FS.sd, ':k');
xline(cycle_data_luli.FS.mean+cycle_data_luli.FS.sd, ':k');

% snowboard orientation
% figure();
% subplot(3,1,2);
% ylim([-40 200]);
% hold on
% plot(cycle_data_luli.XData, cycle_data_luli.snowboard(1).MeanOriY , 'g', LineWidth=1.5);
% x2 = [cycle_data_luli.XData', fliplr(cycle_data_luli.XData')];
% inBetweenR = [(cycle_data_luli.snowboard(1).MeanOriY + cycle_data_luli.snowboard(1).stand_devSY)',fliplr((cycle_data_luli.snowboard(1).MeanOriY - cycle_data_luli.snowboard(1).stand_devSY)')];
% fill(x2, inBetweenR, 'g','FaceAlpha', 0.1, 'EdgeColor','none');
% xline(cycle_data_luli.FS.mean, '-k', linewidth=1);
% xline(cycle_data_luli.FS.mean-cycle_data_luli.FS.sd, ':k');
% xline(cycle_data_luli.FS.mean+cycle_data_luli.FS.sd, ':k');
% 
% subplot(3,1,1);
% ylim([-40 200]);
% hold on
% plot(cycle_data_luli.XData, cycle_data_luli.snowboard(1).MeanOriX , 'r', LineWidth=1.5);
% x2 = [cycle_data_luli.XData', fliplr(cycle_data_luli.XData')];
% inBetweenR = [(cycle_data_luli.snowboard(1).MeanOriX + cycle_data_luli.snowboard(1).stand_devSX)',fliplr((cycle_data_luli.snowboard(1).MeanOriX - cycle_data_luli.snowboard(1).stand_devSX)')];
% fill(x2, inBetweenR, 'r','FaceAlpha', 0.1, 'EdgeColor','none');
% xline(cycle_data_luli.FS.mean, '-k', linewidth=1);
% xline(cycle_data_luli.FS.mean-cycle_data_luli.FS.sd, ':k');
% xline(cycle_data_luli.FS.mean+cycle_data_luli.FS.sd, ':k');
% 
% subplot(3,1,3);
% ylim([-40 200]);
% hold on
% plot(cycle_data_luli.XData, cycle_data_luli.snowboard(1).MeanOriZ , 'b', LineWidth=1.5);
% x2 = [cycle_data_luli.XData', fliplr(cycle_data_luli.XData')];
% inBetweenR = [(cycle_data_luli.snowboard(1).MeanOriZ + cycle_data_luli.snowboard(1).stand_devSZ)',fliplr((cycle_data_luli.snowboard(1).MeanOriZ - cycle_data_luli.snowboard(1).stand_devSZ)')];
% fill(x2, inBetweenR, 'b','FaceAlpha', 0.1, 'EdgeColor','none');
% xline(cycle_data_luli.FS.mean, '-k', linewidth=1);
% xline(cycle_data_luli.FS.mean-cycle_data_luli.FS.sd, ':k');
% xline(cycle_data_luli.FS.mean+cycle_data_luli.FS.sd, ':k');
% 
% sgtitle('luli Orientation du snowboard selon les axes X, Y et  Z');

figure();
% sternum centrer en 0
subplot(2,1,1)
hold on
moy_ster = cycle_data_luli.sternum(1).Mean-mean(cycle_data_luli.sternum(1).Mean);
Norm_3p = Norm_2a2(moy_ster(:,1), moy_ster(:,2), moy_ster(:,3));
plot(cycle_data_luli.XData, Norm_3p , 'k');
plot(cycle_data_luli.XData, moy_ster(:,1) , 'r');
plot(cycle_data_luli.XData, moy_ster(:,2) , 'g');
plot(cycle_data_luli.XData, moy_ster(:,3) , 'b');
x2 = [cycle_data_luli.XData', fliplr(cycle_data_luli.XData')];
inBetweenX = [(moy_ster(:,1) + cycle_data_luli.sternum(1).stand_dev(:,1))',fliplr((moy_ster(:,1) - cycle_data_luli.sternum(1).stand_dev(:,1))')];
inBetweenY = [(moy_ster(:,2) + cycle_data_luli.sternum(1).stand_dev(:,2))',fliplr((moy_ster(:,2) - cycle_data_luli.sternum(1).stand_dev(:,2))')];
inBetweenZ = [(moy_ster(:,3) + cycle_data_luli.sternum(1).stand_dev(:,3))',fliplr((moy_ster(:,3) - cycle_data_luli.sternum(1).stand_dev(:,3))')];
fill(x2, inBetweenX, 'r','FaceAlpha', 0.1, 'EdgeColor','none');
fill(x2, inBetweenY, 'g','FaceAlpha', 0.1, 'EdgeColor','none');
fill(x2, inBetweenZ, 'b','FaceAlpha', 0.1, 'EdgeColor','none');
xline(cycle_data_luli.FS.mean, '-k', linewidth=1);
xline(cycle_data_luli.FS.mean-cycle_data_luli.FS.sd, ':k');
xline(cycle_data_luli.FS.mean+cycle_data_luli.FS.sd, ':k');
title('luli Sternum orientation');

scatter3(moy_ster(:,1), moy_ster(:,2), moy_ster(:,3)); hold on
scatter3(moy_ster(1,1), moy_ster(1,2), moy_ster(1,3), 'g');
scatter3(0, 0, -30, 'k');
axis equal

figure();
% sternum
subplot(2,1,1)
hold on
plot(cycle_data_luli.XData, cycle_data_luli.sternum(1).Mean(:,1) , 'r');
plot(cycle_data_luli.XData, cycle_data_luli.sternum(1).Mean(:,2) , 'g');
plot(cycle_data_luli.XData, cycle_data_luli.sternum(1).Mean(:,3) , 'b');
x2 = [cycle_data_luli.XData', fliplr(cycle_data_luli.XData')];
inBetweenX = [(cycle_data_luli.sternum(1).Mean(:,1) + cycle_data_luli.sternum(1).stand_dev(:,1))',fliplr((cycle_data_luli.sternum(1).Mean(:,1) - cycle_data_luli.sternum(1).stand_dev(:,1))')];
inBetweenY = [(cycle_data_luli.sternum(1).Mean(:,2) + cycle_data_luli.sternum(1).stand_dev(:,2))',fliplr((cycle_data_luli.sternum(1).Mean(:,2) - cycle_data_luli.sternum(1).stand_dev(:,2))')];
inBetweenZ = [(cycle_data_luli.sternum(1).Mean(:,3) + cycle_data_luli.sternum(1).stand_dev(:,3))',fliplr((cycle_data_luli.sternum(1).Mean(:,3) - cycle_data_luli.sternum(1).stand_dev(:,3))')];
fill(x2, inBetweenX, 'r','FaceAlpha', 0.1, 'EdgeColor','none');
fill(x2, inBetweenY, 'g','FaceAlpha', 0.1, 'EdgeColor','none');
fill(x2, inBetweenZ, 'b','FaceAlpha', 0.1, 'EdgeColor','none');
xline(cycle_data_luli.FS.mean, '-k', linewidth=1);
xline(cycle_data_luli.FS.mean-cycle_data_luli.FS.sd, ':k');
xline(cycle_data_luli.FS.mean+cycle_data_luli.FS.sd, ':k');
title('luli Sternum orientation');


% pelvis
subplot(2,1,2)
hold on
moy_pelv = cycle_data_luli.pelvis(1).Mean-mean(cycle_data_luli.pelvis(1).Mean);
plot(cycle_data_luli.XData, moy_pelv(:,1) , 'r');
plot(cycle_data_luli.XData, moy_pelv(:,2) , 'g');
plot(cycle_data_luli.XData, moy_pelv(:,3) , 'b');
x2 = [cycle_data_luli.XData', fliplr(cycle_data_luli.XData')];
inBetweenX = [(moy_pelv(:,1) + cycle_data_luli.pelvis(1).stand_dev(:,1))',fliplr((moy_pelv(:,1) - cycle_data_luli.pelvis(1).stand_dev(:,1))')];
inBetweenY = [(moy_pelv(:,2) + cycle_data_luli.pelvis(1).stand_dev(:,2))',fliplr((moy_pelv(:,2) - cycle_data_luli.pelvis(1).stand_dev(:,2))')];
inBetweenZ = [(moy_pelv(:,3) + cycle_data_luli.pelvis(1).stand_dev(:,3))',fliplr((moy_pelv(:,3) - cycle_data_luli.pelvis(1).stand_dev(:,3))')];
fill(x2, inBetweenX, 'r','FaceAlpha', 0.1, 'EdgeColor','none');
fill(x2, inBetweenY, 'g','FaceAlpha', 0.1, 'EdgeColor','none');
fill(x2, inBetweenZ, 'b','FaceAlpha', 0.1, 'EdgeColor','none');
xline(cycle_data_luli.FS.mean, '-k', linewidth=1);
xline(cycle_data_luli.FS.mean-cycle_data_luli.FS.sd, ':k');
xline(cycle_data_luli.FS.mean+cycle_data_luli.FS.sd, ':k');
legend({'X','Y','Z'});
title('luli Pelvis orientation');


%% PABI %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
for i = 1 : length(cycle_data_pabi.ankle)
    % plot raw data for all the cycles
    subplot(3,3,8)
    ylim([-20 50]);
    hold on
    plot(cycle_data_pabi.ankle(i).pdata, cycle_data_pabi.ankle(i).Rjoint ,  LineWidth=0.5, Color=[0.8500 0.3250 0.0980]);
    plot(cycle_data_pabi.ankle(i).pdata, cycle_data_pabi.ankle(i).Ljoint ,  LineWidth=0.5, Color=[0.3010 0.7450 0.9330]);
    subplot(3,3,5)
    ylim([-10 80]);
    hold on
    plot(cycle_data_pabi.knee(i).pdata, cycle_data_pabi.knee(i).Rjoint ,  LineWidth=0.5, Color=[0.8500 0.3250 0.0980]);
    plot(cycle_data_pabi.knee(i).pdata, cycle_data_pabi.knee(i).Ljoint ,  LineWidth=0.5, Color=[0.3010 0.7450 0.9330]);
    subplot(3,3,2)
    ylim([-10 90]);
    hold on
    plot(cycle_data_pabi.hip(i).pdata, cycle_data_pabi.hip(i).Rjoint ,  LineWidth=0.5, Color=[0.8500 0.3250 0.0980]);
    plot(cycle_data_pabi.hip(i).pdata, cycle_data_pabi.hip(i).Ljoint ,  LineWidth=0.5, Color=[0.3010 0.7450 0.9330]);

end

% plot stats
subplot(3,3,8)
% ylim([-20 50]);
ylim([-20 100]);
hold on
plot(cycle_data_pabi.XData, cycle_data_pabi.ankle(1).MeanR , 'b', LineWidth=1.7);
plot(cycle_data_pabi.XData, cycle_data_pabi.ankle(1).MeanL , 'r', LineWidth=1.7);
x2 = [cycle_data_pabi.XData', fliplr(cycle_data_pabi.XData')];
inBetweenR = [(cycle_data_pabi.ankle(1).MeanR + cycle_data_pabi.ankle(1).stand_devR)',fliplr((cycle_data_pabi.ankle(1).MeanR - cycle_data_pabi.ankle(1).stand_devR)')];
fill(x2, inBetweenR, 'b','FaceAlpha', 0.1, 'EdgeColor','none');
inBetweenL = [(cycle_data_pabi.ankle(1).MeanL + cycle_data_pabi.ankle(1).stand_devL)',fliplr((cycle_data_pabi.ankle(1).MeanL - cycle_data_pabi.ankle(1).stand_devL)')];
fill(x2, inBetweenL, 'r','FaceAlpha', 0.1, 'EdgeColor','none');

subplot(3,3,5)
% ylim([-10 80]);
ylim([-20 100]);
hold on
plot(cycle_data_pabi.XData, cycle_data_pabi.knee(1).MeanR , 'b', LineWidth=1.7);
plot(cycle_data_pabi.XData, cycle_data_pabi.knee(1).MeanL , 'r', LineWidth=1.7);
x2 = [cycle_data_pabi.XData', fliplr(cycle_data_pabi.XData')];
inBetweenR = [(cycle_data_pabi.knee(1).MeanR + cycle_data_pabi.knee(1).stand_devR)',fliplr((cycle_data_pabi.knee(1).MeanR - cycle_data_pabi.knee(1).stand_devR)')];
fill(x2, inBetweenR, 'b','FaceAlpha', 0.1, 'EdgeColor','none');
inBetweenL = [(cycle_data_pabi.knee(1).MeanL + cycle_data_pabi.knee(1).stand_devL)',fliplr((cycle_data_pabi.knee(1).MeanL - cycle_data_pabi.knee(1).stand_devL)')];
fill(x2, inBetweenL, 'r','FaceAlpha', 0.1, 'EdgeColor','none');

subplot(3,3,2)
ylim([-20 100]);
hold on
plot(cycle_data_pabi.XData, cycle_data_pabi.hip(1).MeanR , 'b', LineWidth=1.7);
plot(cycle_data_pabi.XData, cycle_data_pabi.hip(1).MeanL , 'r', LineWidth=1.7);
x2 = [cycle_data_pabi.XData', fliplr(cycle_data_pabi.XData')];
inBetweenR = [(cycle_data_pabi.hip(1).MeanR + cycle_data_pabi.hip(1).stand_devR)',fliplr((cycle_data_pabi.hip(1).MeanR - cycle_data_pabi.hip(1).stand_devR)')];
fill(x2, inBetweenR, 'b','FaceAlpha', 0.1, 'EdgeColor','none');
inBetweenL = [(cycle_data_pabi.hip(1).MeanL + cycle_data_pabi.hip(1).stand_devL)',fliplr((cycle_data_pabi.hip(1).MeanL - cycle_data_pabi.hip(1).stand_devL)')];
fill(x2, inBetweenL, 'r','FaceAlpha', 0.1, 'EdgeColor','none');

% plot backside limitation
subplot(3,3,8)
xline(cycle_data_pabi.FS.mean, '-k', linewidth=1);
xline(cycle_data_pabi.FS.mean-cycle_data_pabi.FS.sd, ':k');
xline(cycle_data_pabi.FS.mean+cycle_data_pabi.FS.sd, ':k');
subplot(3,3,5)
xline(cycle_data_pabi.FS.mean, '-k', linewidth=1);
xline(cycle_data_pabi.FS.mean-cycle_data_pabi.FS.sd, ':k');
xline(cycle_data_pabi.FS.mean+cycle_data_pabi.FS.sd, ':k');
subplot(3,3,2)
xline(cycle_data_pabi.FS.mean, '-k', linewidth=1);
xline(cycle_data_pabi.FS.mean-cycle_data_pabi.FS.sd, ':k');
xline(cycle_data_pabi.FS.mean+cycle_data_pabi.FS.sd, ':k');

% snowboard orientation
figure();
subplot(3,1,2);
ylim([-40 260]);
hold on
plot(cycle_data_pabi.XData, cycle_data_pabi.snowboard(1).MeanOriY , 'g', LineWidth=1.5);
x2 = [cycle_data_pabi.XData', fliplr(cycle_data_pabi.XData')];
inBetweenR = [(cycle_data_pabi.snowboard(1).MeanOriY + cycle_data_pabi.snowboard(1).stand_devSY)',fliplr((cycle_data_pabi.snowboard(1).MeanOriY - cycle_data_pabi.snowboard(1).stand_devSY)')];
fill(x2, inBetweenR, 'g','FaceAlpha', 0.1, 'EdgeColor','none');
xline(cycle_data_pabi.FS.mean, '-k', linewidth=1);
xline(cycle_data_pabi.FS.mean-cycle_data_pabi.FS.sd, ':k');
xline(cycle_data_pabi.FS.mean+cycle_data_pabi.FS.sd, ':k');

subplot(3,1,1);
ylim([-40 260]);
hold on
plot(cycle_data_pabi.XData, cycle_data_pabi.snowboard(1).MeanOriX , 'r', LineWidth=1.5);
x2 = [cycle_data_pabi.XData', fliplr(cycle_data_pabi.XData')];
inBetweenR = [(cycle_data_pabi.snowboard(1).MeanOriX + cycle_data_pabi.snowboard(1).stand_devSX)',fliplr((cycle_data_pabi.snowboard(1).MeanOriX - cycle_data_pabi.snowboard(1).stand_devSX)')];
fill(x2, inBetweenR, 'r','FaceAlpha', 0.1, 'EdgeColor','none');
xline(cycle_data_pabi.FS.mean, '-k', linewidth=1);
xline(cycle_data_pabi.FS.mean-cycle_data_pabi.FS.sd, ':k');
xline(cycle_data_pabi.FS.mean+cycle_data_pabi.FS.sd, ':k');

subplot(3,1,3);
ylim([-40 260]);
hold on
plot(cycle_data_pabi.XData, cycle_data_pabi.snowboard(1).MeanOriZ , 'b', LineWidth=1.5);
x2 = [cycle_data_pabi.XData', fliplr(cycle_data_pabi.XData')];
inBetweenR = [(cycle_data_pabi.snowboard(1).MeanOriZ + cycle_data_pabi.snowboard(1).stand_devSZ)',fliplr((cycle_data_pabi.snowboard(1).MeanOriZ - cycle_data_pabi.snowboard(1).stand_devSZ)')];
fill(x2, inBetweenR, 'b','FaceAlpha', 0.1, 'EdgeColor','none');
xline(cycle_data_pabi.FS.mean, '-k', linewidth=1);
xline(cycle_data_pabi.FS.mean-cycle_data_pabi.FS.sd, ':k');
xline(cycle_data_pabi.FS.mean+cycle_data_pabi.FS.sd, ':k');

sgtitle('pabi Orientation du snowboard selon les axes X, Y et  Z');

%% MAXIME %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
for i = 1 : length(cycle_data_maxi.ankle)
    % plot raw data for all the cycles
    subplot(3,3,9)
    ylim([-20 50]);
    hold on
    plot(cycle_data_maxi.ankle(i).pdata, cycle_data_maxi.ankle(i).Rjoint ,  LineWidth=0.5, Color=[0.8500 0.3250 0.0980]);
    plot(cycle_data_maxi.ankle(i).pdata, cycle_data_maxi.ankle(i).Ljoint ,  LineWidth=0.5, Color=[0.3010 0.7450 0.9330]);
    subplot(3,3,6)
    ylim([-10 80]);
    hold on
    plot(cycle_data_maxi.knee(i).pdata, cycle_data_maxi.knee(i).Rjoint ,  LineWidth=0.5, Color=[0.8500 0.3250 0.0980]);
    plot(cycle_data_maxi.knee(i).pdata, cycle_data_maxi.knee(i).Ljoint ,  LineWidth=0.5, Color=[0.3010 0.7450 0.9330]);
    subplot(3,3,3)
    ylim([-10 90]);
    hold on
    plot(cycle_data_maxi.hip(i).pdata, cycle_data_maxi.hip(i).Rjoint ,  LineWidth=0.5, Color=[0.8500 0.3250 0.0980]);
    plot(cycle_data_maxi.hip(i).pdata, cycle_data_maxi.hip(i).Ljoint ,  LineWidth=0.5, Color=[0.3010 0.7450 0.9330]);

end

% plot stats
subplot(3,3,9)
% ylim([-20 50]);
ylim([-20 100]);
hold on
plot(cycle_data_maxi.XData, cycle_data_maxi.ankle(1).MeanR , 'b', LineWidth=1.7);
plot(cycle_data_maxi.XData, cycle_data_maxi.ankle(1).MeanL , 'r', LineWidth=1.7);
x2 = [cycle_data_maxi.XData', fliplr(cycle_data_maxi.XData')];
inBetweenR = [(cycle_data_maxi.ankle(1).MeanR + cycle_data_maxi.ankle(1).stand_devR)',fliplr((cycle_data_maxi.ankle(1).MeanR - cycle_data_maxi.ankle(1).stand_devR)')];
fill(x2, inBetweenR, 'b','FaceAlpha', 0.1, 'EdgeColor','none');
inBetweenL = [(cycle_data_maxi.ankle(1).MeanL + cycle_data_maxi.ankle(1).stand_devL)',fliplr((cycle_data_maxi.ankle(1).MeanL - cycle_data_maxi.ankle(1).stand_devL)')];
fill(x2, inBetweenL, 'r','FaceAlpha', 0.1, 'EdgeColor','none');

subplot(3,3,6)
% ylim([-10 80]);
ylim([-20 100]);
hold on
plot(cycle_data_maxi.XData, cycle_data_maxi.knee(1).MeanR , 'b', LineWidth=1.7);
plot(cycle_data_maxi.XData, cycle_data_maxi.knee(1).MeanL , 'r', LineWidth=1.7);
x2 = [cycle_data_maxi.XData', fliplr(cycle_data_maxi.XData')];
inBetweenR = [(cycle_data_maxi.knee(1).MeanR + cycle_data_maxi.knee(1).stand_devR)',fliplr((cycle_data_maxi.knee(1).MeanR - cycle_data_maxi.knee(1).stand_devR)')];
fill(x2, inBetweenR, 'b','FaceAlpha', 0.1, 'EdgeColor','none');
inBetweenL = [(cycle_data_maxi.knee(1).MeanL + cycle_data_maxi.knee(1).stand_devL)',fliplr((cycle_data_maxi.knee(1).MeanL - cycle_data_maxi.knee(1).stand_devL)')];
fill(x2, inBetweenL, 'r','FaceAlpha', 0.1, 'EdgeColor','none');

subplot(3,3,3)
ylim([-20 100]);
hold on
plot(cycle_data_maxi.XData, cycle_data_maxi.hip(1).MeanR , 'b', LineWidth=1.7);
plot(cycle_data_maxi.XData, cycle_data_maxi.hip(1).MeanL , 'r', LineWidth=1.7);
x2 = [cycle_data_maxi.XData', fliplr(cycle_data_maxi.XData')];
inBetweenR = [(cycle_data_maxi.hip(1).MeanR + cycle_data_maxi.hip(1).stand_devR)',fliplr((cycle_data_maxi.hip(1).MeanR - cycle_data_maxi.hip(1).stand_devR)')];
fill(x2, inBetweenR, 'b','FaceAlpha', 0.1, 'EdgeColor','none');
inBetweenL = [(cycle_data_maxi.hip(1).MeanL + cycle_data_maxi.hip(1).stand_devL)',fliplr((cycle_data_maxi.hip(1).MeanL - cycle_data_maxi.hip(1).stand_devL)')];
fill(x2, inBetweenL, 'r','FaceAlpha', 0.1, 'EdgeColor','none');

% plot backside limitation
subplot(3,3,9)
xline(cycle_data_maxi.FS.mean, '-k', linewidth=1);
xline(cycle_data_maxi.FS.mean-cycle_data_maxi.FS.sd, ':k');
xline(cycle_data_maxi.FS.mean+cycle_data_maxi.FS.sd, ':k');
subplot(3,3,6)
xline(cycle_data_maxi.FS.mean, '-k', linewidth=1);
xline(cycle_data_maxi.FS.mean-cycle_data_maxi.FS.sd, ':k');
xline(cycle_data_maxi.FS.mean+cycle_data_maxi.FS.sd, ':k');
subplot(3,3,3)
xline(cycle_data_maxi.FS.mean, '-k', linewidth=1);
xline(cycle_data_maxi.FS.mean-cycle_data_maxi.FS.sd, ':k');
xline(cycle_data_maxi.FS.mean+cycle_data_maxi.FS.sd, ':k');


% snowboard orientation
figure();
subplot(3,1,2);
% ylim([-40 40]);
hold on
plot(cycle_data_maxi.XData, cycle_data_maxi.snowboard(1).MeanOriY , 'b', LineWidth=1.5);
x2 = [cycle_data_maxi.XData', fliplr(cycle_data_maxi.XData')];
inBetweenR = [(cycle_data_maxi.snowboard(1).MeanOriY + cycle_data_maxi.snowboard(1).stand_devSY)',fliplr((cycle_data_maxi.snowboard(1).MeanOriY - cycle_data_maxi.snowboard(1).stand_devSY)')];
fill(x2, inBetweenR, 'b','FaceAlpha', 0.1, 'EdgeColor','none');
xline(cycle_data_maxi.FS.mean, '-k', linewidth=1);
xline(cycle_data_maxi.FS.mean-cycle_data_maxi.FS.sd, ':k');
xline(cycle_data_maxi.FS.mean+cycle_data_maxi.FS.sd, ':k');

subplot(3,1,1);
% ylim([-150 10]);
hold on
plot(cycle_data_maxi.XData, cycle_data_maxi.snowboard(1).MeanOriX , 'b', LineWidth=1.5);
x2 = [cycle_data_maxi.XData', fliplr(cycle_data_maxi.XData')];
inBetweenR = [(cycle_data_maxi.snowboard(1).MeanOriX + cycle_data_maxi.snowboard(1).stand_devSX)',fliplr((cycle_data_maxi.snowboard(1).MeanOriX - cycle_data_maxi.snowboard(1).stand_devSX)')];
fill(x2, inBetweenR, 'b','FaceAlpha', 0.1, 'EdgeColor','none');
xline(cycle_data_maxi.FS.mean, '-k', linewidth=1);
xline(cycle_data_maxi.FS.mean-cycle_data_maxi.FS.sd, ':k');
xline(cycle_data_maxi.FS.mean+cycle_data_maxi.FS.sd, ':k');

subplot(3,1,3);
% ylim([-5 25]);
hold on
plot(cycle_data_maxi.XData, cycle_data_maxi.snowboard(1).MeanOriZ , 'b', LineWidth=1.5);
x2 = [cycle_data_maxi.XData', fliplr(cycle_data_maxi.XData')];
inBetweenR = [(cycle_data_maxi.snowboard(1).MeanOriZ + cycle_data_maxi.snowboard(1).stand_devSZ)',fliplr((cycle_data_maxi.snowboard(1).MeanOriZ - cycle_data_maxi.snowboard(1).stand_devSZ)')];
fill(x2, inBetweenR, 'b','FaceAlpha', 0.1, 'EdgeColor','none');
xline(cycle_data_maxi.FS.mean, '-k', linewidth=1);
xline(cycle_data_maxi.FS.mean-cycle_data_maxi.FS.sd, ':k');
xline(cycle_data_maxi.FS.mean+cycle_data_maxi.FS.sd, ':k');

sgtitle('luli Orientation du snowboard selon les axes X, Y et  Z');

figure();
% sternum
subplot(2,1,1)
hold on
plot(cycle_data_maxi.XData, cycle_data_maxi.sternum(1).Mean(:,1) , 'r', cycle_data_maxi.XData, cycle_data_maxi.sternum(1).Mean(:,2) , 'g', cycle_data_maxi.XData, cycle_data_maxi.sternum(1).Mean(:,3) , 'b');
x2 = [cycle_data_maxi.XData', fliplr(cycle_data_maxi.XData')];
inBetweenX = [(cycle_data_maxi.sternum(1).Mean(:,1) + cycle_data_maxi.sternum(1).stand_dev(:,1))',fliplr((cycle_data_maxi.sternum(1).Mean(:,1) - cycle_data_maxi.sternum(1).stand_dev(:,1))')];
inBetweenY = [(cycle_data_maxi.sternum(1).Mean(:,2) + cycle_data_maxi.sternum(1).stand_dev(:,2))',fliplr((cycle_data_maxi.sternum(1).Mean(:,2) - cycle_data_maxi.sternum(1).stand_dev(:,2))')];
inBetweenZ = [(cycle_data_maxi.sternum(1).Mean(:,3) + cycle_data_maxi.sternum(1).stand_dev(:,3))',fliplr((cycle_data_maxi.sternum(1).Mean(:,3) - cycle_data_maxi.sternum(1).stand_dev(:,3))')];
fill(x2, inBetweenX, 'r','FaceAlpha', 0.1, 'EdgeColor','none');
fill(x2, inBetweenY, 'g','FaceAlpha', 0.1, 'EdgeColor','none');
fill(x2, inBetweenZ, 'b','FaceAlpha', 0.1, 'EdgeColor','none');
xline(cycle_data_maxi.FS.mean, '-k', linewidth=1);
xline(cycle_data_maxi.FS.mean-cycle_data_maxi.FS.sd, ':k');
xline(cycle_data_maxi.FS.mean+cycle_data_maxi.FS.sd, ':k');
title('luli Sternum orientation');

% pelvis
subplot(2,1,2)
hold on
plot(cycle_data_maxi.XData, cycle_data_maxi.pelvis(1).Mean(:,1) , 'r', cycle_data_maxi.XData, cycle_data_maxi.pelvis(1).Mean(:,2) , 'g', cycle_data_maxi.XData, cycle_data_maxi.pelvis(1).Mean(:,3) , 'b');
x2 = [cycle_data_maxi.XData', fliplr(cycle_data_maxi.XData')];
inBetweenX = [(cycle_data_maxi.pelvis(1).Mean(:,1) + cycle_data_maxi.pelvis(1).stand_dev(:,1))',fliplr((cycle_data_maxi.pelvis(1).Mean(:,1) - cycle_data_maxi.pelvis(1).stand_dev(:,1))')];
inBetweenY = [(cycle_data_maxi.pelvis(1).Mean(:,2) + cycle_data_maxi.pelvis(1).stand_dev(:,2))',fliplr((cycle_data_maxi.pelvis(1).Mean(:,2) - cycle_data_maxi.pelvis(1).stand_dev(:,2))')];
inBetweenZ = [(cycle_data_maxi.pelvis(1).Mean(:,3) + cycle_data_maxi.pelvis(1).stand_dev(:,3))',fliplr((cycle_data_maxi.pelvis(1).Mean(:,3) - cycle_data_maxi.pelvis(1).stand_dev(:,3))')];
fill(x2, inBetweenX, 'r','FaceAlpha', 0.1, 'EdgeColor','none');
fill(x2, inBetweenY, 'g','FaceAlpha', 0.1, 'EdgeColor','none');
fill(x2, inBetweenZ, 'b','FaceAlpha', 0.1, 'EdgeColor','none');
xline(cycle_data_maxi.FS.mean, '-k', linewidth=1);
xline(cycle_data_maxi.FS.mean-cycle_data_maxi.FS.sd, ':k');
xline(cycle_data_maxi.FS.mean+cycle_data_maxi.FS.sd, ':k');
legend({'X','Y','Z'});
title('luli Pelvis orientation');



%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%
%% SUBPLOT LL2 %%

%% MABR %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
for i = 1 : length(cycle_data_mabr.ankle)
    % plot raw data for all the cycles
    subplot(3,3,7)
    ylim([-20 50]);
    hold on
    plot(cycle_data_mabr.ankle(i).pdata, cycle_data_mabr.ankle(i).Rjoint ,  LineWidth=0.5, Color=[0.8500 0.3250 0.0980]);
    plot(cycle_data_mabr.ankle(i).pdata, cycle_data_mabr.ankle(i).Ljoint ,  LineWidth=0.5, Color=[0.3010 0.7450 0.9330]);
    subplot(3,3,4)
    ylim([-10 70]);
    hold on
    plot(cycle_data_mabr.knee(i).pdata, cycle_data_mabr.knee(i).Rjoint ,  LineWidth=0.5, Color=[0.8500 0.3250 0.0980]);
    plot(cycle_data_mabr.knee(i).pdata, cycle_data_mabr.knee(i).Ljoint ,  LineWidth=0.5, Color=[0.3010 0.7450 0.9330]);
    subplot(3,3,1)
    ylim([-10 90]);
    hold on
    plot(cycle_data_mabr.hip(i).pdata, cycle_data_mabr.hip(i).Rjoint ,  LineWidth=0.5, Color=[0.8500 0.3250 0.0980]);
    plot(cycle_data_mabr.hip(i).pdata, cycle_data_mabr.hip(i).Ljoint ,  LineWidth=0.5, Color=[0.3010 0.7450 0.9330]);

end

% plot stats
subplot(3,3,7)
% ylim([-20 50]);
ylim([-20 100]);
hold on
plot(cycle_data_mabr.XData, cycle_data_mabr.ankle(1).MeanR , 'b', LineWidth=1.7);
plot(cycle_data_mabr.XData, cycle_data_mabr.ankle(1).MeanL , 'r', LineWidth=1.7);
x2 = [cycle_data_mabr.XData', fliplr(cycle_data_mabr.XData')];
inBetweenR = [(cycle_data_mabr.ankle(1).MeanR + cycle_data_mabr.ankle(1).stand_devR)',fliplr((cycle_data_mabr.ankle(1).MeanR - cycle_data_mabr.ankle(1).stand_devR)')];
fill(x2, inBetweenR, 'b','FaceAlpha', 0.1, 'EdgeColor','none');
inBetweenL = [(cycle_data_mabr.ankle(1).MeanL + cycle_data_mabr.ankle(1).stand_devL)',fliplr((cycle_data_mabr.ankle(1).MeanL - cycle_data_mabr.ankle(1).stand_devL)')];
fill(x2, inBetweenL, 'r','FaceAlpha', 0.1, 'EdgeColor','none');

subplot(3,3,4)
% ylim([-10 70]);
ylim([-20 100]);
hold on
plot(cycle_data_mabr.XData, cycle_data_mabr.knee(1).MeanR , 'b', LineWidth=1.7);
plot(cycle_data_mabr.XData, cycle_data_mabr.knee(1).MeanL , 'r', LineWidth=1.7);
x2 = [cycle_data_mabr.XData', fliplr(cycle_data_mabr.XData')];
inBetweenR = [(cycle_data_mabr.knee(1).MeanR + cycle_data_mabr.knee(1).stand_devR)',fliplr((cycle_data_mabr.knee(1).MeanR - cycle_data_mabr.knee(1).stand_devR)')];
fill(x2, inBetweenR, 'b','FaceAlpha', 0.1, 'EdgeColor','none');
inBetweenL = [(cycle_data_mabr.knee(1).MeanL + cycle_data_mabr.knee(1).stand_devL)',fliplr((cycle_data_mabr.knee(1).MeanL - cycle_data_mabr.knee(1).stand_devL)')];
fill(x2, inBetweenL, 'r','FaceAlpha', 0.1, 'EdgeColor','none');

subplot(3,3,1)
ylim([-20 100]);
hold on
plot(cycle_data_mabr.XData, cycle_data_mabr.hip(1).MeanR , 'b', LineWidth=1.7);
plot(cycle_data_mabr.XData, cycle_data_mabr.hip(1).MeanL , 'r', LineWidth=1.7);
x2 = [cycle_data_mabr.XData', fliplr(cycle_data_mabr.XData')];
inBetweenR = [(cycle_data_mabr.hip(1).MeanR + cycle_data_mabr.hip(1).stand_devR)',fliplr((cycle_data_mabr.hip(1).MeanR - cycle_data_mabr.hip(1).stand_devR)')];
fill(x2, inBetweenR, 'b','FaceAlpha', 0.1, 'EdgeColor','none');
inBetweenL = [(cycle_data_mabr.hip(1).MeanL + cycle_data_mabr.hip(1).stand_devL)',fliplr((cycle_data_mabr.hip(1).MeanL - cycle_data_mabr.hip(1).stand_devL)')];
fill(x2, inBetweenL, 'r','FaceAlpha', 0.1, 'EdgeColor','none');


% plot backside limitation
subplot(3,3,7)
xline(cycle_data_mabr.FS.mean, '-k', linewidth=1);
xline(cycle_data_mabr.FS.mean-cycle_data_mabr.FS.sd, ':k');
xline(cycle_data_mabr.FS.mean+cycle_data_mabr.FS.sd, ':k');
subplot(3,3,4)
xline(cycle_data_mabr.FS.mean, '-k', linewidth=1);
xline(cycle_data_mabr.FS.mean-cycle_data_mabr.FS.sd, ':k');
xline(cycle_data_mabr.FS.mean+cycle_data_mabr.FS.sd, ':k');
subplot(3,3,1)
xline(cycle_data_mabr.FS.mean, '-k', linewidth=1);
xline(cycle_data_mabr.FS.mean-cycle_data_mabr.FS.sd, ':k');
xline(cycle_data_mabr.FS.mean+cycle_data_mabr.FS.sd, ':k');



%% PABA %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
for i = 1 : length(cycle_data_paba.ankle)
    % plot raw data for all the cycles
    subplot(3,3,8)
    ylim([-20 50]);
%     subplot(3,1,3)
    hold on
    plot(cycle_data_paba.ankle(i).pdata, cycle_data_paba.ankle(i).Rjoint ,  LineWidth=0.5, Color=[0.8500 0.3250 0.0980]);
    plot(cycle_data_paba.ankle(i).pdata, cycle_data_paba.ankle(i).Ljoint ,  LineWidth=0.5, Color=[0.3010 0.7450 0.9330]);
    subplot(3,3,5)
    ylim([-10 70]);
%     subplot(3,1,2)
    hold on
    plot(cycle_data_paba.knee(i).pdata, cycle_data_paba.knee(i).Rjoint ,  LineWidth=0.5, Color=[0.8500 0.3250 0.0980]);
    plot(cycle_data_paba.knee(i).pdata, cycle_data_paba.knee(i).Ljoint ,  LineWidth=0.5, Color=[0.3010 0.7450 0.9330]);
    subplot(3,3,2)
    ylim([-10 90]);
%     subplot(3,1,1)
    hold on
    plot(cycle_data_paba.hip(i).pdata, cycle_data_paba.hip(i).Rjoint ,  LineWidth=0.5, Color=[0.8500 0.3250 0.0980]);
    plot(cycle_data_paba.hip(i).pdata, cycle_data_paba.hip(i).Ljoint ,  LineWidth=0.5, Color=[0.3010 0.7450 0.9330]);

end

% plot stats
subplot(3,3,8)
% ylim([-20 50]);
ylim([-20 100]);
hold on
plot(cycle_data_paba.XData, cycle_data_paba.ankle(1).MeanR , 'b', LineWidth=1.7);
plot(cycle_data_paba.XData, cycle_data_paba.ankle(1).MeanL , 'r', LineWidth=1.7);
x2 = [cycle_data_paba.XData', fliplr(cycle_data_paba.XData')];
inBetweenR = [(cycle_data_paba.ankle(1).MeanR + cycle_data_paba.ankle(1).stand_devR)',fliplr((cycle_data_paba.ankle(1).MeanR - cycle_data_paba.ankle(1).stand_devR)')];
fill(x2, inBetweenR, 'b','FaceAlpha', 0.1, 'EdgeColor','none');
inBetweenL = [(cycle_data_paba.ankle(1).MeanL + cycle_data_paba.ankle(1).stand_devL)',fliplr((cycle_data_paba.ankle(1).MeanL - cycle_data_paba.ankle(1).stand_devL)')];
fill(x2, inBetweenL, 'r','FaceAlpha', 0.1, 'EdgeColor','none');

subplot(3,3,5)
% ylim([-10 70]);
ylim([-20 100]);
hold on
plot(cycle_data_paba.XData, cycle_data_paba.knee(1).MeanR , 'b', LineWidth=1.7);
plot(cycle_data_paba.XData, cycle_data_paba.knee(1).MeanL , 'r', LineWidth=1.7);
x2 = [cycle_data_paba.XData', fliplr(cycle_data_paba.XData')];
inBetweenR = [(cycle_data_paba.knee(1).MeanR + cycle_data_paba.knee(1).stand_devR)',fliplr((cycle_data_paba.knee(1).MeanR - cycle_data_paba.knee(1).stand_devR)')];
fill(x2, inBetweenR, 'b','FaceAlpha', 0.1, 'EdgeColor','none');
inBetweenL = [(cycle_data_paba.knee(1).MeanL + cycle_data_paba.knee(1).stand_devL)',fliplr((cycle_data_paba.knee(1).MeanL - cycle_data_paba.knee(1).stand_devL)')];
fill(x2, inBetweenL, 'r','FaceAlpha', 0.1, 'EdgeColor','none');

subplot(3,3,2)
ylim([-20 100]);
hold on
plot(cycle_data_paba.XData, cycle_data_paba.hip(1).MeanR , 'b', LineWidth=1.7);
plot(cycle_data_paba.XData, cycle_data_paba.hip(1).MeanL , 'r', LineWidth=1.7);
x2 = [cycle_data_paba.XData', fliplr(cycle_data_paba.XData')];
inBetweenR = [(cycle_data_paba.hip(1).MeanR + cycle_data_paba.hip(1).stand_devR)',fliplr((cycle_data_paba.hip(1).MeanR - cycle_data_paba.hip(1).stand_devR)')];
fill(x2, inBetweenR, 'b','FaceAlpha', 0.1, 'EdgeColor','none');
inBetweenL = [(cycle_data_paba.hip(1).MeanL + cycle_data_paba.hip(1).stand_devL)',fliplr((cycle_data_paba.hip(1).MeanL - cycle_data_paba.hip(1).stand_devL)')];
fill(x2, inBetweenL, 'r','FaceAlpha', 0.1, 'EdgeColor','none');

% plot backside limitation
subplot(3,3,8)
xline(cycle_data_paba.FS.mean, '-k', linewidth=1);
xline(cycle_data_paba.FS.mean-cycle_data_paba.FS.sd, ':k');
xline(cycle_data_paba.FS.mean+cycle_data_paba.FS.sd, ':k');
subplot(3,3,5)
xline(cycle_data_paba.FS.mean, '-k', linewidth=1);
xline(cycle_data_paba.FS.mean-cycle_data_paba.FS.sd, ':k');
xline(cycle_data_paba.FS.mean+cycle_data_paba.FS.sd, ':k');
subplot(3,3,2)
xline(cycle_data_paba.FS.mean, '-k', linewidth=1);
xline(cycle_data_paba.FS.mean-cycle_data_paba.FS.sd, ':k');
xline(cycle_data_paba.FS.mean+cycle_data_paba.FS.sd, ':k');


% snowboard orientation
figure();
subplot(3,1,2);
ylim([-40 400]);
hold on
plot(cycle_data_paba.XData, cycle_data_paba.snowboard(1).MeanOriY , 'g', LineWidth=1.5);
x2 = [cycle_data_paba.XData', fliplr(cycle_data_paba.XData')];
inBetweenR = [(cycle_data_paba.snowboard(1).MeanOriY + cycle_data_paba.snowboard(1).stand_devSY)',fliplr((cycle_data_paba.snowboard(1).MeanOriY - cycle_data_paba.snowboard(1).stand_devSY)')];
fill(x2, inBetweenR, 'g','FaceAlpha', 0.1, 'EdgeColor','none');
xline(cycle_data_paba.FS.mean, '-k', linewidth=1);
xline(cycle_data_paba.FS.mean-cycle_data_paba.FS.sd, ':k');
xline(cycle_data_paba.FS.mean+cycle_data_paba.FS.sd, ':k');

subplot(3,1,1);
ylim([-40 400]);
hold on
plot(cycle_data_paba.XData, cycle_data_paba.snowboard(1).MeanOriX , 'r', LineWidth=1.5);
x2 = [cycle_data_paba.XData', fliplr(cycle_data_paba.XData')];
inBetweenR = [(cycle_data_paba.snowboard(1).MeanOriX + cycle_data_paba.snowboard(1).stand_devSX)',fliplr((cycle_data_paba.snowboard(1).MeanOriX - cycle_data_paba.snowboard(1).stand_devSX)')];
fill(x2, inBetweenR, 'r','FaceAlpha', 0.1, 'EdgeColor','none');
xline(cycle_data_paba.FS.mean, '-k', linewidth=1);
xline(cycle_data_paba.FS.mean-cycle_data_paba.FS.sd, ':k');
xline(cycle_data_paba.FS.mean+cycle_data_paba.FS.sd, ':k');

subplot(3,1,3);
ylim([-40 400]);
hold on
plot(cycle_data_paba.XData, cycle_data_paba.snowboard(1).MeanOriZ , 'b', LineWidth=1.5);
x2 = [cycle_data_paba.XData', fliplr(cycle_data_paba.XData')];
inBetweenR = [(cycle_data_paba.snowboard(1).MeanOriZ + cycle_data_paba.snowboard(1).stand_devSZ)',fliplr((cycle_data_paba.snowboard(1).MeanOriZ - cycle_data_paba.snowboard(1).stand_devSZ)')];
fill(x2, inBetweenR, 'b','FaceAlpha', 0.1, 'EdgeColor','none');
xline(cycle_data_paba.FS.mean, '-k', linewidth=1);
xline(cycle_data_paba.FS.mean-cycle_data_paba.FS.sd, ':k');
xline(cycle_data_paba.FS.mean+cycle_data_paba.FS.sd, ':k');

sgtitle('paba Orientation du snowboard selon les axes X, Y et  Z');

figure();
% sternum
subplot(2,1,1)
hold on
plot(cycle_data_paba.XData, cycle_data_paba.sternum(1).Mean(:,1) , 'r', cycle_data_paba.XData, cycle_data_paba.sternum(1).Mean(:,2) , 'g', cycle_data_paba.XData, cycle_data_paba.sternum(1).Mean(:,3) , 'b');
x2 = [cycle_data_paba.XData', fliplr(cycle_data_paba.XData')];
inBetweenX = [(cycle_data_paba.sternum(1).Mean(:,1) + cycle_data_paba.sternum(1).stand_dev(:,1))',fliplr((cycle_data_paba.sternum(1).Mean(:,1) - cycle_data_paba.sternum(1).stand_dev(:,1))')];
inBetweenY = [(cycle_data_paba.sternum(1).Mean(:,2) + cycle_data_paba.sternum(1).stand_dev(:,2))',fliplr((cycle_data_paba.sternum(1).Mean(:,2) - cycle_data_paba.sternum(1).stand_dev(:,2))')];
inBetweenZ = [(cycle_data_paba.sternum(1).Mean(:,3) + cycle_data_paba.sternum(1).stand_dev(:,3))',fliplr((cycle_data_paba.sternum(1).Mean(:,3) - cycle_data_paba.sternum(1).stand_dev(:,3))')];
fill(x2, inBetweenX, 'r','FaceAlpha', 0.1, 'EdgeColor','none');
fill(x2, inBetweenY, 'g','FaceAlpha', 0.1, 'EdgeColor','none');
fill(x2, inBetweenZ, 'b','FaceAlpha', 0.1, 'EdgeColor','none');
xline(cycle_data_paba.FS.mean, '-k', linewidth=1);
xline(cycle_data_paba.FS.mean-cycle_data_paba.FS.sd, ':k');
xline(cycle_data_paba.FS.mean+cycle_data_paba.FS.sd, ':k');
title('paba Sternum orientation');

% pelvis
subplot(2,1,2)
hold on
plot(cycle_data_paba.XData, cycle_data_paba.pelvis(1).Mean(:,1) , 'r', cycle_data_paba.XData, cycle_data_paba.pelvis(1).Mean(:,2) , 'g', cycle_data_paba.XData, cycle_data_paba.pelvis(1).Mean(:,3) , 'b');
x2 = [cycle_data_paba.XData', fliplr(cycle_data_paba.XData')];
inBetweenX = [(cycle_data_paba.pelvis(1).Mean(:,1) + cycle_data_paba.pelvis(1).stand_dev(:,1))',fliplr((cycle_data_paba.pelvis(1).Mean(:,1) - cycle_data_paba.pelvis(1).stand_dev(:,1))')];
inBetweenY = [(cycle_data_paba.pelvis(1).Mean(:,2) + cycle_data_paba.pelvis(1).stand_dev(:,2))',fliplr((cycle_data_paba.pelvis(1).Mean(:,2) - cycle_data_paba.pelvis(1).stand_dev(:,2))')];
inBetweenZ = [(cycle_data_paba.pelvis(1).Mean(:,3) + cycle_data_paba.pelvis(1).stand_dev(:,3))',fliplr((cycle_data_paba.pelvis(1).Mean(:,3) - cycle_data_paba.pelvis(1).stand_dev(:,3))')];
fill(x2, inBetweenX, 'r','FaceAlpha', 0.1, 'EdgeColor','none');
fill(x2, inBetweenY, 'g','FaceAlpha', 0.1, 'EdgeColor','none');
fill(x2, inBetweenZ, 'b','FaceAlpha', 0.1, 'EdgeColor','none');
xline(cycle_data_paba.FS.mean, '-k', linewidth=1);
xline(cycle_data_paba.FS.mean-cycle_data_paba.FS.sd, ':k');
xline(cycle_data_paba.FS.mean+cycle_data_paba.FS.sd, ':k');
legend({'X','Y','Z'});
title('paba Pelvis orientation');



%% SOLO %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
for i = 1 : length(cycle_data_solo.ankle)
    % plot raw data for all the cycles
    subplot(3,3,9)
    ylim([-20 50]);
%     subplot(3,1,3)
    hold on
    plot(cycle_data_solo.ankle(i).pdata, cycle_data_solo.ankle(i).Rjoint ,  LineWidth=0.5, Color=[0.8500 0.3250 0.0980]);
    plot(cycle_data_solo.ankle(i).pdata, cycle_data_solo.ankle(i).Ljoint ,  LineWidth=0.5, Color=[0.3010 0.7450 0.9330]);
    subplot(3,3,6)
    ylim([-10 70]);
%     subplot(3,1,2)
    hold on
    plot(cycle_data_solo.knee(i).pdata, cycle_data_solo.knee(i).Rjoint ,  LineWidth=0.5, Color=[0.8500 0.3250 0.0980]);
    plot(cycle_data_solo.knee(i).pdata, cycle_data_solo.knee(i).Ljoint ,  LineWidth=0.5, Color=[0.3010 0.7450 0.9330]);
    subplot(3,3,3)
    ylim([-10 90]);
%     subplot(3,1,1)
    hold on
    plot(cycle_data_solo.hip(i).pdata, cycle_data_solo.hip(i).Rjoint ,  LineWidth=0.5, Color=[0.8500 0.3250 0.0980]);
    plot(cycle_data_solo.hip(i).pdata, cycle_data_solo.hip(i).Ljoint ,  LineWidth=0.5, Color=[0.3010 0.7450 0.9330]);

end

% plot stats
subplot(3,3,9)
% ylim([-20 50]);
ylim([-20 100]);
hold on
plot(cycle_data_solo.XData, cycle_data_solo.ankle(1).MeanR , 'r', LineWidth=1.7);
plot(cycle_data_solo.XData, cycle_data_solo.ankle(1).MeanL , 'b', LineWidth=1.7);
x2 = [cycle_data_solo.XData', fliplr(cycle_data_solo.XData')];
inBetweenR = [(cycle_data_solo.ankle(1).MeanR + cycle_data_solo.ankle(1).stand_devR)',fliplr((cycle_data_solo.ankle(1).MeanR - cycle_data_solo.ankle(1).stand_devR)')];
fill(x2, inBetweenR, 'r','FaceAlpha', 0.1, 'EdgeColor','none');
inBetweenL = [(cycle_data_solo.ankle(1).MeanL + cycle_data_solo.ankle(1).stand_devL)',fliplr((cycle_data_solo.ankle(1).MeanL - cycle_data_solo.ankle(1).stand_devL)')];
fill(x2, inBetweenL, 'b','FaceAlpha', 0.1, 'EdgeColor','none');

subplot(3,3,6)
% ylim([10 60]);
ylim([-20 100]);
hold on
plot(cycle_data_solo.XData, cycle_data_solo.knee(1).MeanR , 'r', LineWidth=1.7);
plot(cycle_data_solo.XData, cycle_data_solo.knee(1).MeanL , 'b', LineWidth=1.7);
x2 = [cycle_data_solo.XData', fliplr(cycle_data_solo.XData')];
inBetweenR = [(cycle_data_solo.knee(1).MeanR + cycle_data_solo.knee(1).stand_devR)',fliplr((cycle_data_solo.knee(1).MeanR - cycle_data_solo.knee(1).stand_devR)')];
fill(x2, inBetweenR, 'r','FaceAlpha', 0.1, 'EdgeColor','none');
inBetweenL = [(cycle_data_solo.knee(1).MeanL + cycle_data_solo.knee(1).stand_devL)',fliplr((cycle_data_solo.knee(1).MeanL - cycle_data_solo.knee(1).stand_devL)')];
fill(x2, inBetweenL, 'b','FaceAlpha', 0.1, 'EdgeColor','none');

subplot(3,3,3)
ylim([-20 100]);
hold on
plot(cycle_data_solo.XData, cycle_data_solo.hip(1).MeanR , 'r', LineWidth=1.7);
plot(cycle_data_solo.XData, cycle_data_solo.hip(1).MeanL , 'b', LineWidth=1.7);
x2 = [cycle_data_solo.XData', fliplr(cycle_data_solo.XData')];
inBetweenR = [(cycle_data_solo.hip(1).MeanR + cycle_data_solo.hip(1).stand_devR)',fliplr((cycle_data_solo.hip(1).MeanR - cycle_data_solo.hip(1).stand_devR)')];
fill(x2, inBetweenR, 'r','FaceAlpha', 0.1, 'EdgeColor','none');
inBetweenL = [(cycle_data_solo.hip(1).MeanL + cycle_data_solo.hip(1).stand_devL)',fliplr((cycle_data_solo.hip(1).MeanL - cycle_data_solo.hip(1).stand_devL)')];
fill(x2, inBetweenL, 'b','FaceAlpha', 0.1, 'EdgeColor','none');

% plot backside limitation
subplot(3,3,9)
xline(cycle_data_solo.FS.mean, '-k', linewidth=1);
xline(cycle_data_solo.FS.mean-cycle_data_solo.FS.sd, ':k');
xline(cycle_data_solo.FS.mean+cycle_data_solo.FS.sd, ':k');
subplot(3,3,6)
xline(cycle_data_solo.FS.mean, '-k', linewidth=1);
xline(cycle_data_solo.FS.mean-cycle_data_solo.FS.sd, ':k');
xline(cycle_data_solo.FS.mean+cycle_data_solo.FS.sd, ':k');
subplot(3,3,3)
xline(cycle_data_solo.FS.mean, '-k', linewidth=1);
xline(cycle_data_solo.FS.mean-cycle_data_solo.FS.sd, ':k');
xline(cycle_data_solo.FS.mean+cycle_data_solo.FS.sd, ':k');


%% SPECIFIQUE PLOT
toplot = cycle_data_solo;
name = 'MABR';
joint = 'sternum';

figure(); hold on
plot(toplot.XData, toplot.(joint)(1).Mean(:,1) , 'r', toplot.XData, toplot.(joint)(1).Mean(:,2) , 'g', toplot.XData, toplot.(joint)(1).Mean(:,3) , 'b');
x2 = [toplot.XData', fliplr(toplot.XData')];
inBetweenX = [(toplot.(joint)(1).Mean(:,1) + toplot.(joint)(1).stand_dev(:,1))',fliplr((toplot.(joint)(1).Mean(:,1) - toplot.(joint)(1).stand_dev(:,1))')];
inBetweenY = [(toplot.(joint)(1).Mean(:,2) + toplot.(joint)(1).stand_dev(:,2))',fliplr((toplot.(joint)(1).Mean(:,2) - toplot.(joint)(1).stand_dev(:,2))')];
inBetweenZ = [(toplot.(joint)(1).Mean(:,3) + toplot.(joint)(1).stand_dev(:,3))',fliplr((toplot.(joint)(1).Mean(:,3) - toplot.(joint)(1).stand_dev(:,3))')];
fill(x2, inBetweenX, 'r','FaceAlpha', 0.1, 'EdgeColor','none');
fill(x2, inBetweenY, 'g','FaceAlpha', 0.1, 'EdgeColor','none');
fill(x2, inBetweenZ, 'b','FaceAlpha', 0.1, 'EdgeColor','none');
xline(toplot.FS.mean, '-k', linewidth=1);
xline(toplot.FS.mean-toplot.FS.sd, ':k');
xline(toplot.FS.mean+toplot.FS.sd, ':k');
legend({'X','Y','Z'});
title([joint , ' -- ' , name]);

% test changement de repere de l'orientation du sternum
data = Xsens_raw.Raw_data_Xsens.luli001;
frames = frame_start_end(data);
ori_sternum = data.segmentData(5).orientation(frames(1):frames(2),:);
R01 = quat2rotm(ori_sternum(1,:));

Mat_rot = quat2rotm(ori_sternum);
new_matrot = zeros(size(Mat_rot));
for i =2:length(Mat_rot)
    new_matrot(:,:,i)= Mat_rot(:,:,i)*inv(R01);
end

angle_rot_ster = rad2deg(rotm2eul(new_matrot));
figure(); hold on
plot(angle_rot_ster(:,1), 'r');
plot(angle_rot_ster(:,2), 'g');
plot(angle_rot_ster(:,3), 'b');

%% Calculs amplitude de mouvement
% luli
cycle_data_luli = Xsens_cycle.Cycle_data_Xsens.luli001;
luli_ROM_ankle_R = max(cycle_data_luli.ankle(1).MeanR) - min(cycle_data_luli.ankle(1).MeanR);
luli_ROM_ankle_L = max(cycle_data_luli.ankle(1).MeanL) - min(cycle_data_luli.ankle(1).MeanL);

luli_ROM_knee_R = max(cycle_data_luli.knee(1).MeanR) - min(cycle_data_luli.knee(1).MeanR);
luli_ROM_knee_L = max(cycle_data_luli.knee(1).MeanL) - min(cycle_data_luli.knee(1).MeanL);

luli_ROM_hip_R = max(cycle_data_luli.hip(1).MeanR) - min(cycle_data_luli.hip(1).MeanR);
luli_ROM_hip_L = max(cycle_data_luli.hip(1).MeanL) - min(cycle_data_luli.hip(1).MeanL);

% mabr
cycle_data_mabr = Xsens_cycle.Cycle_data_Xsens.mabr001;
mabr_ROM_ankle_R = max(cycle_data_mabr.ankle(1).MeanR) - min(cycle_data_mabr.ankle(1).MeanR);
mabr_ROM_ankle_L = max(cycle_data_mabr.ankle(1).MeanL) - min(cycle_data_mabr.ankle(1).MeanL);

mabr_ROM_knee_R = max(cycle_data_mabr.knee(1).MeanR) - min(cycle_data_mabr.knee(1).MeanR);
mabr_ROM_knee_L = max(cycle_data_mabr.knee(1).MeanL) - min(cycle_data_mabr.knee(1).MeanL);

mabr_ROM_hip_R = max(cycle_data_mabr.hip(1).MeanR) - min(cycle_data_mabr.hip(1).MeanR);
mabr_ROM_hip_L = max(cycle_data_mabr.hip(1).MeanL) - min(cycle_data_mabr.hip(1).MeanL);

% pabi
cycle_data_pabi = Xsens_cycle.Cycle_data_Xsens.pabi010;
pabi_ROM_ankle_R = max(cycle_data_pabi.ankle(1).MeanR) - min(cycle_data_pabi.ankle(1).MeanR);
pabi_ROM_ankle_L = max(cycle_data_pabi.ankle(1).MeanL) - min(cycle_data_pabi.ankle(1).MeanL);

pabi_ROM_knee_R = max(cycle_data_pabi.knee(1).MeanR) - min(cycle_data_pabi.knee(1).MeanR);
pabi_ROM_knee_L = max(cycle_data_pabi.knee(1).MeanL) - min(cycle_data_pabi.knee(1).MeanL);

pabi_ROM_hip_R = max(cycle_data_pabi.hip(1).MeanR) - min(cycle_data_pabi.hip(1).MeanR);
pabi_ROM_hip_L = max(cycle_data_pabi.hip(1).MeanL) - min(cycle_data_pabi.hip(1).MeanL);

% paba
cycle_data_paba = Xsens_cycle.Cycle_data_Xsens.paba021;
paba_ROM_ankle_R = max(cycle_data_paba.ankle(1).MeanR) - min(cycle_data_paba.ankle(1).MeanR);
paba_ROM_ankle_L = max(cycle_data_paba.ankle(1).MeanL) - min(cycle_data_paba.ankle(1).MeanL);

paba_ROM_knee_R = max(cycle_data_paba.knee(1).MeanR) - min(cycle_data_paba.knee(1).MeanR);
paba_ROM_knee_L = max(cycle_data_paba.knee(1).MeanL) - min(cycle_data_paba.knee(1).MeanL);

paba_ROM_hip_R = max(cycle_data_paba.hip(1).MeanR) - min(cycle_data_paba.hip(1).MeanR);
paba_ROM_hip_L = max(cycle_data_paba.hip(1).MeanL) - min(cycle_data_paba.hip(1).MeanL);

% solo
cycle_data_solo = Xsens_cycle.Cycle_data_Xsens.solo001;
solo_ROM_ankle_R = max(cycle_data_solo.ankle(1).MeanR) - min(cycle_data_solo.ankle(1).MeanR);
solo_ROM_ankle_L = max(cycle_data_solo.ankle(1).MeanL) - min(cycle_data_solo.ankle(1).MeanL);

solo_ROM_knee_R = max(cycle_data_solo.knee(1).MeanR) - min(cycle_data_solo.knee(1).MeanR);
solo_ROM_knee_L = max(cycle_data_solo.knee(1).MeanL) - min(cycle_data_solo.knee(1).MeanL);

solo_ROM_hip_R = max(cycle_data_solo.hip(1).MeanR) - min(cycle_data_solo.hip(1).MeanR);
solo_ROM_hip_L = max(cycle_data_solo.hip(1).MeanL) - min(cycle_data_solo.hip(1).MeanL);

% maxi
cycle_data_maxi = Xsens_cycle.Cycle_data_Xsens.maxi1_2;
maxi_ROM_ankle_R = max(cycle_data_maxi.ankle(1).MeanR) - min(cycle_data_maxi.ankle(1).MeanR);
maxi_ROM_ankle_L = max(cycle_data_maxi.ankle(1).MeanL) - min(cycle_data_maxi.ankle(1).MeanL);

maxi_ROM_knee_R = max(cycle_data_maxi.knee(1).MeanR) - min(cycle_data_maxi.knee(1).MeanR);
maxi_ROM_knee_L = max(cycle_data_maxi.knee(1).MeanL) - min(cycle_data_maxi.knee(1).MeanL);

maxi_ROM_hip_R = max(cycle_data_maxi.hip(1).MeanR) - min(cycle_data_maxi.hip(1).MeanR);
maxi_ROM_hip_L = max(cycle_data_maxi.hip(1).MeanL) - min(cycle_data_maxi.hip(1).MeanL);


%% courbe angle genou / cheville
nom_sujet = fieldnames(Xsens_cycle.Cycle_data_Xsens);

for i =1:length(fieldnames(Xsens_cycle.Cycle_data_Xsens))
    name = nom_sujet{i};

    chevilleR = Xsens_cycle.Cycle_data_Xsens.(name).ankle(1).MeanR;
    genouR = Xsens_cycle.Cycle_data_Xsens.(name).knee(1).MeanR;

    chevilleL = Xsens_cycle.Cycle_data_Xsens.(name).ankle(1).MeanL;
    genouL = Xsens_cycle.Cycle_data_Xsens.(name).knee(1).MeanL;

    figure(); hold on
    plot(chevilleR, genouR, 'b');
    plot(chevilleL, genouL, 'r');
    axis equal
    title(name)

end




