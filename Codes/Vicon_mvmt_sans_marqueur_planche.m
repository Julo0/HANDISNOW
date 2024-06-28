%% Read the data from Vicon, post mouvement
%  take the kinematic data of res var angle and plot the results
%  turn detection is made here
%  cycling is made here

clear all;
close all;
clc

addpath(genpath('Z:\HANDISNOW'));
addpath(genpath('Z:\mouvement'));

%% import data from vicon
% STF_01 = load('Z:\HANDISNOW\Manip 2024\VICON\Donnees traitees\FE_TF\resultats_cinemat\snow01\res_var_angle_t.mat');
% STF_02 = load('Z:\HANDISNOW\Manip 2024\VICON\Donnees traitees\FE_TF\resultats_cinemat\snow02\res_var_angle_t.mat');
% 
% SNA_01 = load('Z:\HANDISNOW\Manip 2024\VICON\Donnees traitees\FExsens\resultats_cinemat\snow03\res_var_angle_t.mat');
% SNA_02 = load('Z:\HANDISNOW\Manip 2024\VICON\Donnees traitees\FExsens\resultats_cinemat\snow04\res_var_angle_t.mat');

%% construction structure
data_cine = struct();
[nomfich0, pathfich0] = uigetfile('Multiselect','on','*.mat');
for i = 1:length(nomfich0)
    data_cine.sujet1(i).essai = load(fullfile(pathfich0,nomfich0{i}));
end

% data_cine.sujet1(1).essai = STF_01;
% data_cine.sujet1(2).essai = STF_02;
% data_cine.sujet1(3).essai = SNA_01;
% data_cine.sujet1(4).essai = SNA_02;


% donnees de temps pour filtrage des virages
time_btw_turn = [150,150,150,150,150,150,150,150,150];



%% import data from c3d to track the board
% numero du sujet
numero_sujet = 1;
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

    % plot position planche et detection cycle via le marqueur MLD
    pos_planche = PTS3D.MLD(:,1); % position sur l'axe vertical
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
    frame_idx = find(diff(sign(filter_data)));
    A = zeros(length(frame_idx),1);
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
    frame_backside = [];
    frame_frontside = [];
    for k=1:length(frame_idx)
        if PTS3D.MLD(frame_idx(k)+10,1) > 0
            frame_backside = [frame_backside, frame_idx(k)];
        end
        if PTS3D.MLD(frame_idx(k)+10,1) < 0
            frame_frontside = [frame_frontside, frame_idx(k)];
        end

    end

    data_cine.(['sujet', num2str(numero_sujet)])(i).frame_BS = frame_backside';
    data_cine.(['sujet', num2str(numero_sujet)])(i).frame_FS = frame_frontside';
end


%% create the cycle data

% indice_supp = struct();
% indice_supp(1).idx = [];
% indice_supp(2).idx = [1, 6 ,7 ,8];
% indice_supp(3).idx = [];
% indice_supp(4).idx = [];

cycle_data_essai = struct();

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
            cycle_data.ankle(num_cycle).Rjoint =  -Rdata;
            cycle_data.ankle(num_cycle).Ljoint =  -Ldata;
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
            cycle_data.hip(num_cycle).Rjoint =  -unwrap(Rdata);
            cycle_data.hip(num_cycle).Ljoint =  -unwrap(Ldata);
            cycle_data.hip(num_cycle).size = length(pdata);
            cycle_data.hip(num_cycle).pdata = pdata;

            num_cycle = num_cycle + 1;
            
        end
    end
    cycle_data.FS_transition = index_FS;

    cycle_data_essai(n_essai).essai = cycle_data;

%     data_cine.(['sujet', num2str(numero_sujet)])(n_essai).cycle_data = Cycle_data_set_membre_inf(cycle_data, indice_supp(n_essai).idx);
end


% merge struct

names = fieldnames(cycle_data_essai(1).essai);
for i = 1: length(names)
    names_var = names{i};
    cycle_data_essai(1).essai_merge.(names_var) = horzcat( cycle_data_essai(1).essai.(names_var), cycle_data_essai(2).essai.(names_var));
    cycle_data_essai(3).essai_merge.(names_var) = horzcat( cycle_data_essai(3).essai.(names_var), cycle_data_essai(4).essai.(names_var));
end

cycle_data_essai(1).set = Cycle_data_set_membre_inf(cycle_data_essai(1).essai_merge, [11, 16,17,18]);
cycle_data_essai(2).set = Cycle_data_set_membre_inf(cycle_data_essai(3).essai_merge, []);


%% PLOT
TF = cycle_data_essai(1).set;
NA = cycle_data_essai(2).set;
% ankle plot
figure(); hold on
for i =1:length(cycle_data_essai(1).set.ankle)
    subplot(3,2,6); hold on
    plot(TF.ankle(i).pdata, TF.ankle(i).Rjoint, LineWidth=0.5, Color=[0.8500 0.0250 0.0980]);
    ylim([-30 70]);
    subplot(3,2,5); hold on
    plot(TF.ankle(i).pdata, TF.ankle(i).Ljoint, LineWidth=0.5, Color=[0.8500 0.0250 0.0980]);
    ylim([-30 70]);
end
for i =1:length(cycle_data_essai(2).set.ankle)
    subplot(3,2,6); hold on
    plot(NA.ankle(i).pdata, NA.ankle(i).Rjoint, LineWidth=0.5, Color=[0.1010 0.5450 0.9930]);
    subplot(3,2,5); hold on
    plot(NA.ankle(i).pdata, NA.ankle(i).Ljoint, LineWidth=0.5, Color=[0.1010 0.5450 0.9930]);
end
%knee
for i =1:length(cycle_data_essai(1).set.knee)
    subplot(3,2,4); hold on
    plot(TF.knee(i).pdata, TF.knee(i).Rjoint, LineWidth=0.5, Color=[0.8500 0.0250 0.0980]);
    ylim([-30 70]);
    subplot(3,2,3); hold on
    plot(TF.knee(i).pdata, TF.knee(i).Ljoint, LineWidth=0.5, Color=[0.8500 0.0250 0.0980]);
    ylim([-30 70]);
end
for i =1:length(cycle_data_essai(2).set.knee)
    subplot(3,2,4); hold on
    plot(NA.knee(i).pdata, NA.knee(i).Rjoint, LineWidth=0.5, Color=[0.1010 0.5450 0.9930]);
    subplot(3,2,3); hold on
    plot(NA.knee(i).pdata, NA.knee(i).Ljoint, LineWidth=0.5, Color=[0.1010 0.5450 0.9930]);
end
%hip
for i =1:length(cycle_data_essai(1).set.hip)
    subplot(3,2,2); hold on
    plot(TF.hip(i).pdata, TF.hip(i).Rjoint, LineWidth=0.5, Color=[0.8500 0.0250 0.0980]);
    subplot(3,2,1); hold on
    plot(TF.hip(i).pdata, TF.hip(i).Ljoint, LineWidth=0.5, Color=[0.8500 0.0250 0.0980]);
end
for i =1:length(cycle_data_essai(2).set.hip)
    subplot(3,2,2); hold on
    plot(NA.hip(i).pdata, NA.hip(i).Rjoint, LineWidth=0.5, Color=[0.1010 0.5450 0.9930]);
    subplot(3,2,1); hold on
    plot(NA.hip(i).pdata, NA.hip(i).Ljoint, LineWidth=0.5, Color=[0.1010 0.5450 0.9930]);
end


%% plot mean and corridor
Compare_mean_corridor_lowerlimbjoint(NA,TF);




