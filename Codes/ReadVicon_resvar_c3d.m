% read VICON data
% load the c3d files to get position of the markers and create the turn
% frame to cycle
% load the res_var_angle result and cycle those

clear all;
close all;
clc

%% construction structure
data_cine = struct();
[nomfich0, pathfich0] = uigetfile('Multiselect','on','*.mat', 'Select the .mat files result calculated with mouvement (res_var_angle_t)');
for i = 1:length(nomfich0)
    data_cine.sujet1(i).essai = load(fullfile(pathfich0,nomfich0{i}));
end
clear nomfich0 pathfich0


%% import data from c3d to track the board --VERSION AVEC LE C3D
% numero du sujet
numero_sujet = 1;
time_btw_turn = 100;
frequence = 200;

% style de snow (goofy/regular) important pour determiner si backside ou
% frontside
style = 'goofy';
methode_cyclage = 'planchearriere';


[nomfich, pathfich] = uigetfile('Multiselect','on','*.c3d', 'Select de c3d files');
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
    pos_planche = PTS3D.(methode_cyclage)(:,1); % position sur l'axe vertical
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
        if (frame_idx(j+1)-frame_idx(j))<time_btw_turn
            ind = [ind, j];
        end
    end
    frame_idx(ind) = [];
    A(ind) = [];
    scatter(frame_idx, A, 'r');


    % create the liste of backside and frontside
    frame_backside = [];
    frame_frontside = [];
        if isequal(style, 'regular') % si regular, backside a l'avant
        for k=1:length(frame_idx)
            if PTS3D.(methode_cyclage)(frame_idx(k)+10,1) > 0
                frame_backside = [frame_backside, frame_idx(k)];
            end
            if PTS3D.(methode_cyclage)(frame_idx(k)+10,1) < 0
                frame_frontside = [frame_frontside, frame_idx(k)];
            end
    
        end
    end
    if isequal(style, 'goofy') % si goofy, backside a l'arrière
        for k=1:length(frame_idx)
            if PTS3D.(methode_cyclage)(frame_idx(k)+10,1) < 0
                frame_backside = [frame_backside, frame_idx(k)];
            end
            if PTS3D.(methode_cyclage)(frame_idx(k)+10,1) > 0
                frame_frontside = [frame_frontside, frame_idx(k)];
            end
    
        end
    end

    data_cine.(['sujet', num2str(numero_sujet)])(i).frame_BS = frame_backside';
    data_cine.(['sujet', num2str(numero_sujet)])(i).frame_FS = frame_frontside';
end


% %% import data from c3d to track the board --VERSION AVEC LE KINEMATIC .MAT (si prblm de nom de marqueurs)
% % numero du sujet
% numero_sujet = 1;
% time_btw_turn = 100;
% frequence = 200;
% 
% % style de snow (goofy/regular) important pour determiner si backside ou
% % frontside
% style = 'goofy';
% methode_cyclage = 'planchearriere';
% 
% [nomfich, pathfich] = uigetfile('*.mat', 'Select the .mat kinematic_data');
% loaded_data = load(fullfile(pathfich,nomfich));
% kinematic_mat = loaded_data.kinematic_data;
% Turns = struct();
% 
% name_trial = fieldnames(kinematic_mat);
% for i=1:length(name_trial)
%     FICH = kinematic_mat.(name_trial{i});
% 
%     % set different markers
%     noms_points= FICH.noms;
%     for ii=1:length(noms_points)
%         try
%         PTS3D.(noms_points{ii})=FICH.coord(:,3*(ii-1)+1:3*(ii-1)+3);
%         end
%     end
% 
%     % plot position planche et detection cycle via le marqueur arriere de
%     % la planche
%     pos_planche = PTS3D.(methode_cyclage)(:,1); % position sur l'axe vertical
%     figure(); hold on
%     plot(pos_planche);
% 
%     % filter a bit
%     data = pos_planche;
%     freq_acquis = 200;
%     freq_coup = 5;
%     N = 2;
%     [b,a] = butter(N, freq_coup/(freq_acquis/2), "low");
%     filter_data = filtfilt(b,a,data);
% 
%     plot(filter_data, 'r');
%     title('Position planche sur l''axe vertical');
% 
% 
% 
%     % index of the peaks
%     frame_idx = find(diff(sign(filter_data)));
%     A = zeros(length(frame_idx),1);
%     scatter(frame_idx, A, 'k');
% 
%     
%     % filtre les peaks inutiles
%     ind = [];
%     for j =1:length(frame_idx)-1
%         if (frame_idx(j+1)-frame_idx(j))<time_btw_turn
%             ind = [ind, j];
%         end
%     end
%     frame_idx(ind) = [];
%     A(ind) = [];
%     scatter(frame_idx, A, 'r');
% 
% 
%     % create the liste of backside and frontside
%     frame_backside = [];
%     frame_frontside = [];
%     if isequal(style, 'regular') % si regular, backside a l'avant
%         for k=1:length(frame_idx)
%             if PTS3D.(methode_cyclage)(frame_idx(k)+10,1) > 0
%                 frame_backside = [frame_backside, frame_idx(k)];
%             end
%             if PTS3D.(methode_cyclage)(frame_idx(k)+10,1) < 0
%                 frame_frontside = [frame_frontside, frame_idx(k)];
%             end
%     
%         end
%     end
%     if isequal(style, 'goofy') % si goofy, backside a l'arrière
%         for k=1:length(frame_idx)
%             if PTS3D.(methode_cyclage)(frame_idx(k)+10,1) < 0
%                 frame_backside = [frame_backside, frame_idx(k)];
%             end
%             if PTS3D.(methode_cyclage)(frame_idx(k)+10,1) > 0
%                 frame_frontside = [frame_frontside, frame_idx(k)];
%             end
%     
%         end
%     end
% 
% 
%     data_cine.(['sujet', num2str(numero_sujet)])(i).frame_BS = frame_backside';
%     data_cine.(['sujet', num2str(numero_sujet)])(i).frame_FS = frame_frontside';
% end









%% cycler les données

for i =1:length(data_cine(1).sujet1)
    data_cine.sujet1(i).donnees_cyclees = Cycle_data_Vicon(data_cine(1).sujet1(i));
end

%% plot raw pour savoir quoi effacer

for j=1:length(data_cine(1).sujet1)
    essai = data_cine(1).sujet1(j);
    
    figure(); hold on
    for i =1:length(essai.donnees_cyclees.ankle)
        plot(essai.donnees_cyclees.pelvis(i).pdata, essai.donnees_cyclees.knee(i).Rjoint);
    end
    title(['essai numero : ', num2str(j)]);
    legend();

end


%% merge the different trials
Merged_struct = data_cine(1).sujet1(1).donnees_cyclees;
for i=2:length(data_cine(1).sujet1)
    Merged_struct = Merge_structure(Merged_struct, data_cine(1).sujet1(i).donnees_cyclees);
end


%% Calculated the mean / sd
DATA_prep = Cycle_data_set(Merged_struct, [1]);
% DATA_prepTF = Cycle_data_set(Mna, [11, 17 ,18]);


%% plot check
% membre inf
to_plot = DATA_prep;
joint = 'ankle';

figure(); hold on
ylim([-20 80]);
plot(to_plot.XData, to_plot.(joint)(1).MeanR , 'b', LineWidth=1.7);
plot(to_plot.XData, to_plot.(joint)(1).MeanL , 'r', LineWidth=1.7);
x2 = [to_plot.XData', fliplr(to_plot.XData')];
inBetweenR = [(to_plot.(joint)(1).MeanR + to_plot.(joint)(1).stand_devR)',fliplr((to_plot.(joint)(1).MeanR - to_plot.(joint)(1).stand_devR)')];
fill(x2, inBetweenR, 'b','FaceAlpha', 0.1, 'EdgeColor','none');
inBetweenL = [(to_plot.(joint)(1).MeanL + to_plot.(joint)(1).stand_devL)',fliplr((to_plot.(joint)(1).MeanL - to_plot.(joint)(1).stand_devL)')];
fill(x2, inBetweenL, 'r','FaceAlpha', 0.1, 'EdgeColor','none');

xline(to_plot.FS.mean, '-k', linewidth=1);
xline(to_plot.FS.mean-to_plot.FS.sd, ':k');
xline(to_plot.FS.mean+to_plot.FS.sd, ':k');

% sternum et pelvis
to_plot = DATA_prep;
segment = 'sternum';

figure(); hold on
ylim([-50 70]);
plot(to_plot.XData, to_plot.(segment)(1).Mean(:,1) , 'r', LineWidth=1.7); %axe X
plot(to_plot.XData, to_plot.(segment)(1).Mean(:,2) , 'g', LineWidth=1.7); %axe Y
plot(to_plot.XData, to_plot.(segment)(1).Mean(:,3) , 'b', LineWidth=1.7); %axe Z
x2 = [to_plot.XData', fliplr(to_plot.XData')];
inBetweenX = [(to_plot.(segment)(1).Mean(:,1) + to_plot.(segment)(1).stand_dev(:,1))',fliplr((to_plot.(segment)(1).Mean(:,1) - to_plot.(segment)(1).stand_dev(:,1))')];
fill(x2, inBetweenX, 'r','FaceAlpha', 0.1, 'EdgeColor','none');
inBetweenY = [(to_plot.(segment)(1).Mean(:,2) + to_plot.(segment)(1).stand_dev(:,2))',fliplr((to_plot.(segment)(1).Mean(:,2) - to_plot.(segment)(1).stand_dev(:,2))')];
fill(x2, inBetweenY, 'g','FaceAlpha', 0.1, 'EdgeColor','none');
inBetweenZ = [(to_plot.(segment)(1).Mean(:,3) + to_plot.(segment)(1).stand_dev(:,3))',fliplr((to_plot.(segment)(1).Mean(:,3) - to_plot.(segment)(1).stand_dev(:,3))')];
fill(x2, inBetweenZ, 'b','FaceAlpha', 0.1, 'EdgeColor','none');

xline(to_plot.FS.mean, '-k', linewidth=1);
xline(to_plot.FS.mean-to_plot.FS.sd, ':k');
xline(to_plot.FS.mean+to_plot.FS.sd, ':k');


