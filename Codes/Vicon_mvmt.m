%% Read the data from Vicon, post mouvement
%  take the kinematic data of res var angle and plot the results
%  turn detection is made here
%  cycling is made here

clear all;
close all;
clc

addpath(genpath('Z:\HANDISNOW'));
addpath(genpath('Z:\mouvement'));

% import data from vicon
%S1
S01_01 = load('Z:\HANDISNOW\Manip 2024\VICON\Vicon_Xsens_7mai\Donnees traitees\NA_S01\resultats_cinemat\Handisnow_NA_S01_test_01\res_var_angle_t.mat');
S01_02 = load('Z:\HANDISNOW\Manip 2024\VICON\Vicon_Xsens_7mai\Donnees traitees\NA_S01\resultats_cinemat\Handisnow_NA_S01_test_02\res_var_angle_t.mat');
S01_03 = load('Z:\HANDISNOW\Manip 2024\VICON\Vicon_Xsens_7mai\Donnees traitees\NA_S01\resultats_cinemat\Handisnow_NA_S01_test_03\res_var_angle_t.mat');
S01_04 = load('Z:\HANDISNOW\Manip 2024\VICON\Vicon_Xsens_7mai\Donnees traitees\NA_S01\resultats_cinemat\Handisnow_NA_S01_test_04\res_var_angle_t.mat');
S01_05 = load('Z:\HANDISNOW\Manip 2024\VICON\Vicon_Xsens_7mai\Donnees traitees\NA_S01\resultats_cinemat\Handisnow_NA_S01_test_05\res_var_angle_t.mat');
%S2
S02_01 = load('Z:\HANDISNOW\Manip 2024\VICON\Vicon_Xsens_7mai\Donnees traitees\NA_S02\resultats_cinemat\Handisnow_NA_S02_test_01\res_var_angle_t.mat');
S02_02 = load('Z:\HANDISNOW\Manip 2024\VICON\Vicon_Xsens_7mai\Donnees traitees\NA_S02\resultats_cinemat\Handisnow_NA_S02_test_02\res_var_angle_t.mat');
S02_03 = load('Z:\HANDISNOW\Manip 2024\VICON\Vicon_Xsens_7mai\Donnees traitees\NA_S02\resultats_cinemat\Handisnow_NA_S02_test_03\res_var_angle_t.mat');
S02_04 = load('Z:\HANDISNOW\Manip 2024\VICON\Vicon_Xsens_7mai\Donnees traitees\NA_S02\resultats_cinemat\Handisnow_NA_S02_test_04\res_var_angle_t.mat');
%S3
S03_01 = load('Z:\HANDISNOW\Manip 2024\VICON\Vicon_Xsens_7mai\Donnees traitees\NA_S03\resultats_cinemat\Handisnow_NA_S03_test_01\res_var_angle_t.mat');
S03_02 = load('Z:\HANDISNOW\Manip 2024\VICON\Vicon_Xsens_7mai\Donnees traitees\NA_S03\resultats_cinemat\Handisnow_NA_S03_test_02\res_var_angle_t.mat');
S03_03 = load('Z:\HANDISNOW\Manip 2024\VICON\Vicon_Xsens_7mai\Donnees traitees\NA_S03\resultats_cinemat\Handisnow_NA_S03_test_03\res_var_angle_t.mat');
S03_04 = load('Z:\HANDISNOW\Manip 2024\VICON\Vicon_Xsens_7mai\Donnees traitees\NA_S03\resultats_cinemat\Handisnow_NA_S03_test_04\res_var_angle_t.mat');
S03_05 = load('Z:\HANDISNOW\Manip 2024\VICON\Vicon_Xsens_7mai\Donnees traitees\NA_S03\resultats_cinemat\Handisnow_NA_S03_test_05\res_var_angle_t.mat');
%S4
S04_01 = load('Z:\HANDISNOW\Manip 2024\VICON\Vicon_Xsens_7mai\Donnees traitees\NA_S04\resultats_cinemat\Handisnow_NA_S04_test_01\res_var_angle_t.mat');
S04_02 = load('Z:\HANDISNOW\Manip 2024\VICON\Vicon_Xsens_7mai\Donnees traitees\NA_S04\resultats_cinemat\Handisnow_NA_S04_test_02\res_var_angle_t.mat');
S04_03 = load('Z:\HANDISNOW\Manip 2024\VICON\Vicon_Xsens_7mai\Donnees traitees\NA_S04\resultats_cinemat\Handisnow_NA_S04_test_03\res_var_angle_t.mat');
S04_04 = load('Z:\HANDISNOW\Manip 2024\VICON\Vicon_Xsens_7mai\Donnees traitees\NA_S04\resultats_cinemat\Handisnow_NA_S04_test_04\res_var_angle_t.mat');
S04_05 = load('Z:\HANDISNOW\Manip 2024\VICON\Vicon_Xsens_7mai\Donnees traitees\NA_S04\resultats_cinemat\Handisnow_NA_S04_test_05\res_var_angle_t.mat');

% construction structure
data_cine = struct();
data_cine.sujet1(1).essai = S01_01;
data_cine.sujet1(2).essai = S01_02;
data_cine.sujet1(3).essai = S01_01;
data_cine.sujet1(4).essai = S01_04;
data_cine.sujet1(5).essai = S01_05;

data_cine.sujet2(1).essai = S02_01;
data_cine.sujet2(2).essai = S02_02;
data_cine.sujet2(3).essai = S02_01;
data_cine.sujet2(4).essai = S02_04;

data_cine.sujet3(1).essai = S03_01;
data_cine.sujet3(2).essai = S03_02;
data_cine.sujet3(3).essai = S03_01;
data_cine.sujet3(4).essai = S03_04;
data_cine.sujet3(5).essai = S03_05;

data_cine.sujet4(1).essai = S04_01;
data_cine.sujet4(2).essai = S04_02;
data_cine.sujet4(3).essai = S04_01;
data_cine.sujet4(4).essai = S04_04;
data_cine.sujet4(5).essai = S04_05;



% donnees de temps pour filtrage des virages
time_btw_turn = [185, 180 , 125 , 155];



%% import data from c3d to track the board
% numero du sujet
numero_sujet = 4;
frequence = 200;

[nomfich, pathfich] = uigetfile('Multiselect','on','*.c3d');
Turns = struct();

for i=1:length(nomfich)
    FICH=lire_donnees_c3d(fullfile(pathfich,nomfich{i}));

    % set different markers
    noms_points= FICH.noms;
    for ii=1:length(noms_points)
        try
        PTS3D.(noms_points{ii})=FICH.coord(:,3*(ii-1)+1:3*(ii-1)+3);
        end
    end

    % plot position planche et detection cycle
    pos_planche = PTS3D.planchearriere(:,3); % position sur l'axe vertical
    figure(); hold on
    plot(pos_planche);

    % filter a bit
    data = pos_planche;
    freq_acquis = 200;
    freq_coup = 5;
    N = 2;
    [b,a] = butter(N, freq_coup/(freq_acquis/2), "low");
    filter_data = filtfilt(b,a,data);

    plot(filter_data, 'r');
    title('Position planche sur l''axe vertical');



    % index of the peaks
    [A, frame_idx] = findpeaks(filter_data);
    time_idx = frame_idx/200;
    scatter(frame_idx, A, 'k');

    % filtre les peaks inutiles
    ind = [];
    for j =1:length(frame_idx)-1
        if (frame_idx(j+1)-frame_idx(j))<time_btw_turn(numero_sujet)
            ind = [ind, j];
        end
    end
    frame_idx(ind) = [];
    A(ind) = [];
    scatter(frame_idx, A, 'r');


    % create the liste of backside and frontside
    frame_backside = frame_idx(1:2:end);
    frame_frontside = frame_idx(2:2:end);
    data_cine.(['sujet', num2str(numero_sujet)])(i).frame_BS = frame_backside;
    data_cine.(['sujet', num2str(numero_sujet)])(i).frame_FS = frame_frontside;
end


%% create the cycle data

% on boucle sur le nombre d'essais par sujet
for n_essai = 1:length(nomfich)

    % merge and order data from the turn to check validity of the cycle
    fbs = data_cine.(['sujet', num2str(numero_sujet)])(n_essai).frame_BS;
    ffs = data_cine.(['sujet', num2str(numero_sujet)])(n_essai).frame_FS ;
    merged_data = [fbs, repmat("backside", size(fbs, 1),1); ffs, repmat("frontside", size(ffs, 1),1)];
    frame_turn_sorted = sort(str2double(merged_data(:,1)));
    [~,idx] = sort(str2double(merged_data(:,1)));
    label_turn_sorted = merged_data(idx,2);

    % base de temps
    nb_frame = length(data_cine.(['sujet', num2str(numero_sujet)])(n_essai).essai.res_var_angle_t.chevilleD);
    T = zeros(nb_frame, 1);
    for t =1 : nb_frame
        T(t) = t/frequence;
    end

    num_cycle = 1;
    cycle_data = struct();
    index_FS = [];

    for i = 1:(length(frame_turn_sorted)-2)
    
        if (label_turn_sorted(i) =="backside") && (label_turn_sorted(i+1) =="frontside")
            frame1 = frame_turn_sorted(i);
            frame_front = frame_turn_sorted(i+1);
            frame2 = frame_turn_sorted(i+2)-1;
    
            index_FS = [index_FS, frame_front-frame1];

            xdata = T(frame1:frame2);
            pdata = (xdata-min(xdata))/(max(xdata)-min(xdata))*100;
        
            % ankle
            Rdata = data_cine.sujet1(n_essai).essai.res_var_angle_t.chevilleD(frame1:frame2,3);
            Ldata = data_cine.sujet1(n_essai).essai.res_var_angle_t.chevilleG(frame1:frame2,3);
        
            cycle_data.ankle(num_cycle).cycle =  num_cycle;
            cycle_data.ankle(num_cycle).Rjoint =  Rdata;
            cycle_data.ankle(num_cycle).Ljoint =  Ldata;
            cycle_data.ankle(num_cycle).size = length(pdata);
            cycle_data.ankle(num_cycle).pdata = pdata;
        
            % knee
            Rdata = data_cine.sujet1(n_essai).essai.res_var_angle_t.genouD(frame1:frame2,3);
            Ldata = data_cine.sujet1(n_essai).essai.res_var_angle_t.genouG(frame1:frame2,3);
        
            cycle_data.knee(num_cycle).cycle =  num_cycle;
            cycle_data.knee(num_cycle).Rjoint =  Rdata;
            cycle_data.knee(num_cycle).Ljoint =  Ldata;
            cycle_data.knee(num_cycle).size = length(pdata);
            cycle_data.knee(num_cycle).pdata = pdata;
        
            % hip
            Rdata = data_cine.sujet1(n_essai).essai.res_var_angle_t.hancheD(frame1:frame2,3);
            Ldata = data_cine.sujet1(n_essai).essai.res_var_angle_t.hancheG(frame1:frame2,3);
        
            cycle_data.hip(num_cycle).cycle =  num_cycle;
            cycle_data.hip(num_cycle).Rjoint =  Rdata;
            cycle_data.hip(num_cycle).Ljoint =  Ldata;
            cycle_data.hip(num_cycle).size = length(pdata);
            cycle_data.hip(num_cycle).pdata = pdata;

            num_cycle = num_cycle + 1;
            
        end
    end
    cycle_data.FS_transition = index_FS;
    data_cine.(['sujet', num2str(numero_sujet)])(1).cycle_data = Cycle_data_set_membre_inf(cycle_data, []);
end


figure(); hold on
for i =1:length(data_cine.sujet1(1).cycle_data.ankle)
    plot(data_cine.sujet1(1).cycle_data.ankle(i).pdata, data_cine.sujet1(1).cycle_data.ankle(i).Rjoint);
end



