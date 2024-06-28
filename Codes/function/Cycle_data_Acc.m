% determinate cycles for the data from the blue trident accelerometer


function cycle_data = Cycle_data_Acc(indice_premier_backside, nb_cycle, Struct_acc, struct_xsens, frame_debut, frame_fin)

%frequence xsens
f=100;
longueur = frame_fin - frame_debut + 1;
duree = (frame_debut/f);

% label backside frontside from xsens data
[fbs, ffs, tbs, tfs ] = turn_determination(struct_xsens, 1); % fbs : frame des backsides, ffs : frame des frontside, tbs : temps des backsides, tfs : temps des frontside;
% remettre sur la meme base de temps que les acceleros
fbs = fbs - frame_debut;
ffs = ffs - frame_debut;
tbs = tbs - duree;
tfs = tfs - duree;

% chercher l'indice du premier frontside
for i = 1:length(tfs)
    if tfs(i) > tbs(indice_premier_backside)
        indice_premier_frontside = i;
        break
    end
end

%% define the frame and time of the turn in the data from the accelerometer
% PELVIS
% determine les indices (closeind_bs et closeind_fs) des virages dans la
% base de temps des acceleros
matbs = repmat(Struct_acc.TS01306.Vt, [1 length(tbs)]);
matfs = repmat(Struct_acc.TS01306.Vt, [1 length(tfs)]);
[minval, closeind_bs] = min(abs(matbs-tbs'));
[minval2, closeind_fs] = min(abs(matfs-tfs'));

% ces indices correspondent aussi au numero de la frame des donnees des
% accelero
frame_bs_acc = closeind_bs';
frame_fs_acc = closeind_fs';

% on creer les listes de temps : on va chercher les temps dans les datas des acceleros
% correspondant au frames des virages
time_bs_acc = [];
time_fs_acc = [];
for i = 1:length(tbs)
    time_bs_acc = [time_bs_acc; Struct_acc.TS01306.Vt(closeind_bs(i))];
end
for i = 1:length(tfs)
    time_fs_acc = [time_fs_acc; Struct_acc.TS01306.Vt(closeind_fs(i))];
end

% create strucutre with all the infos of the cycles
cycle_data = struct();

% figure();
% hold on
for i = 1 : nb_cycle
    cycle_data.pelvis(i).cycle = i;

    frame1 = frame_bs_acc(indice_premier_backside+i-1);
    frame_front = frame_fs_acc(indice_premier_frontside+i-1);
    frame2 = frame_bs_acc(indice_premier_backside+i);

% donnees sur un cycle
    xdata = Struct_acc.TS01306.Vt(frame1:frame2);
    pdata = (xdata-min(xdata))/(max(xdata)-min(xdata))*100;

%     plot(pdata, Struct_acc.TS01306.az(frame1:frame2) ,  LineWidth=0.5, Color=[0.8500 0.3250 0.0980]);

    cycle_data.pelvis(i).time = xdata;
    cycle_data.pelvis(i).pdata = pdata;

    cycle_data.pelvis(i).ax = Struct_acc.TS01306.ax(frame1:frame2);
    cycle_data.pelvis(i).ay = Struct_acc.TS01306.ay(frame1:frame2);
    cycle_data.pelvis(i).az = Struct_acc.TS01306.az(frame1:frame2);

    
% ajout donnees back et front
    cycle_data.pelvis(i).timeback = Struct_acc.TS01306.Vt(frame1:frame_front-1);
    x_data_back = Struct_acc.TS01306.Vt(frame1:frame_front-1);
    cycle_data.pelvis(i).pdata_back = (x_data_back-min(x_data_back))/(max(x_data_back)-min(x_data_back))*100;
    cycle_data.pelvis(i).axback = Struct_acc.TS01306.ax(frame1:frame_front-1);
    cycle_data.pelvis(i).ayback = Struct_acc.TS01306.ay(frame1:frame_front-1);
    cycle_data.pelvis(i).azback = Struct_acc.TS01306.az(frame1:frame_front-1);
    cycle_data.pelvis(i).ayzback = Norm_2a2(Struct_acc.TS01306.ay(frame1:frame_front-1), Struct_acc.TS01306.az(frame1:frame_front-1));
    cycle_data.pelvis(i).axyzback = Norm_2a2(Struct_acc.TS01306.ax(frame1:frame_front-1), Struct_acc.TS01306.ay(frame1:frame_front-1), Struct_acc.TS01306.az(frame1:frame_front-1));

    cycle_data.pelvis(i).timefront = Struct_acc.TS01306.Vt(frame_front:frame2);
    x_data_front = Struct_acc.TS01306.Vt(frame_front:frame2);
    cycle_data.pelvis(i).pdata_front = (x_data_front-min(x_data_front))/(max(x_data_front)-min(x_data_front))*100;
    cycle_data.pelvis(i).axfront = Struct_acc.TS01306.ax(frame_front:frame2);
    cycle_data.pelvis(i).ayfront = Struct_acc.TS01306.ay(frame_front:frame2);
    cycle_data.pelvis(i).azfront = Struct_acc.TS01306.az(frame_front:frame2);
    cycle_data.pelvis(i).ayzfront = Norm_2a2(Struct_acc.TS01306.ay(frame_front:frame2), Struct_acc.TS01306.az(frame_front:frame2));
    cycle_data.pelvis(i).axyzfront = Norm_2a2(Struct_acc.TS01306.ax(frame_front:frame2), Struct_acc.TS01306.ay(frame_front:frame2), Struct_acc.TS01306.az(frame_front:frame2));


    cycle_data.pelvis(i).size = length(pdata);

    cycle_data.pelvis(i).RMSaX = rms(Struct_acc.TS01306.ax(frame1:frame2));
    cycle_data.pelvis(i).RMSaX_back = rms(Struct_acc.TS01306.ax(frame1:frame_front-1));
    cycle_data.pelvis(i).RMSaX_front = rms(Struct_acc.TS01306.ax(frame_front:frame2));
    cycle_data.pelvis(i).RMSaYZ_back = rms(cycle_data.pelvis(i).ayzback);
    cycle_data.pelvis(i).RMSaYZ_front = rms(cycle_data.pelvis(i).ayzfront);
    cycle_data.pelvis(i).RMSaXYZ_back = rms(cycle_data.pelvis(i).axyzback);
    cycle_data.pelvis(i).RMSaXYZ_front = rms(cycle_data.pelvis(i).axyzfront);


end

%% define the frame and time of the turn in the data from the accelerometer
% CUISSE DROITE
matbs = repmat(Struct_acc.TS03142.Vt, [1 length(tbs)]);
matfs = repmat(Struct_acc.TS03142.Vt, [1 length(tfs)]);
[minval, closeind_bs] = min(abs(matbs-tbs'));
[minval2, closeind_fs] = min(abs(matfs-tfs'));

frame_bs_acc = closeind_bs';
frame_fs_acc = closeind_fs';

time_bs_acc = [];
time_fs_acc = [];
for i = 1:length(tbs)
    time_bs_acc = [time_bs_acc; Struct_acc.TS03142.Vt(closeind_bs(i))];
end
for i = 1:length(tfs)
    time_fs_acc = [time_fs_acc; Struct_acc.TS03142.Vt(closeind_fs(i))];
end


% add elements to the strucutre with all the infos of the cycles

% figure();
% hold on
for i = 1 : nb_cycle
    cycle_data.Rthigh(i).cycle = i;

    frame1 = frame_bs_acc(indice_premier_backside+i-1);
    frame_front = frame_fs_acc(indice_premier_frontside+i-1);
    frame2 = frame_bs_acc(indice_premier_backside+i);

    xdata = Struct_acc.TS03142.Vt(frame1:frame2);
    pdata = (xdata-min(xdata))/(max(xdata)-min(xdata))*100;

%     plot(pdata, Struct_acc.TS01306.az(frame1:frame2) ,  LineWidth=0.5, Color=[0.8500 0.3250 0.0980]);

    cycle_data.Rthigh(i).time = xdata;
    cycle_data.Rthigh(i).pdata = pdata;

    cycle_data.Rthigh(i).ax = Struct_acc.TS03142.ax(frame1:frame2);
    cycle_data.Rthigh(i).ay = Struct_acc.TS03142.ay(frame1:frame2);
    cycle_data.Rthigh(i).az = Struct_acc.TS03142.az(frame1:frame2);

    % ajout donnees back et front
    cycle_data.Rthigh(i).timeback = Struct_acc.TS03142.Vt(frame1:frame_front-1);
    x_data_back = Struct_acc.TS03142.Vt(frame1:frame_front-1);
    cycle_data.Rthigh(i).pdata_back = (x_data_back-min(x_data_back))/(max(x_data_back)-min(x_data_back))*100;
    cycle_data.Rthigh(i).axback = Struct_acc.TS03142.ax(frame1:frame_front-1);
    cycle_data.Rthigh(i).ayback = Struct_acc.TS03142.ay(frame1:frame_front-1);
    cycle_data.Rthigh(i).azback = Struct_acc.TS03142.az(frame1:frame_front-1);
    cycle_data.Rthigh(i).ayzback = Norm_2a2(Struct_acc.TS03142.ay(frame1:frame_front-1), Struct_acc.TS03142.az(frame1:frame_front-1));
    cycle_data.Rthigh(i).axyzback = Norm_2a2(Struct_acc.TS03142.ax(frame1:frame_front-1), Struct_acc.TS03142.ay(frame1:frame_front-1), Struct_acc.TS03142.az(frame1:frame_front-1));

    cycle_data.Rthigh(i).timefront = Struct_acc.TS03142.Vt(frame_front:frame2);
    x_data_front = Struct_acc.TS03142.Vt(frame_front:frame2);
    cycle_data.Rthigh(i).pdata_front = (x_data_front-min(x_data_front))/(max(x_data_front)-min(x_data_front))*100;
    cycle_data.Rthigh(i).axfront = Struct_acc.TS03142.ax(frame_front:frame2);
    cycle_data.Rthigh(i).ayfront = Struct_acc.TS03142.ay(frame_front:frame2);
    cycle_data.Rthigh(i).azfront = Struct_acc.TS03142.az(frame_front:frame2);
    cycle_data.Rthigh(i).ayzfront = Norm_2a2(Struct_acc.TS03142.ay(frame_front:frame2), Struct_acc.TS03142.az(frame_front:frame2));
    cycle_data.Rthigh(i).axyzfront = Norm_2a2(Struct_acc.TS03142.ax(frame_front:frame2), Struct_acc.TS03142.ay(frame_front:frame2), Struct_acc.TS03142.az(frame_front:frame2));


    cycle_data.Rthigh(i).size = length(pdata);

    cycle_data.Rthigh(i).RMSaX = rms(Struct_acc.TS03142.ax(frame1:frame2));
    cycle_data.Rthigh(i).RMSaX_back = rms(Struct_acc.TS03142.ax(frame1:frame_front-1));
    cycle_data.Rthigh(i).RMSaX_front = rms(Struct_acc.TS03142.ax(frame_front:frame2));
    cycle_data.Rthigh(i).RMSaYZ_back = rms(cycle_data.Rthigh(i).ayzback);
    cycle_data.Rthigh(i).RMSaYZ_front = rms(cycle_data.Rthigh(i).ayzfront);
    cycle_data.Rthigh(i).RMSaXYZ_back = rms(cycle_data.Rthigh(i).axyzback);
    cycle_data.Rthigh(i).RMSaXYZ_front = rms(cycle_data.Rthigh(i).axyzfront);
end


%% define the frame and time of the turn in the data from the accelerometer
% CUISSE GAUCHE
matbs = repmat(Struct_acc.TS02113.Vt, [1 length(tbs)]);
matfs = repmat(Struct_acc.TS02113.Vt, [1 length(tfs)]);
[minval, closeind_bs] = min(abs(matbs-tbs'));
[minval2, closeind_fs] = min(abs(matfs-tfs'));

frame_bs_acc = closeind_bs';
frame_fs_acc = closeind_fs';

time_bs_acc = [];
time_fs_acc = [];
for i = 1:length(tbs)
    time_bs_acc = [time_bs_acc; Struct_acc.TS02113.Vt(closeind_bs(i))];
end
for i = 1:length(tfs)
    time_fs_acc = [time_fs_acc; Struct_acc.TS02113.Vt(closeind_fs(i))];
end


% add elements to the strucutre with all the infos of the cycles

% figure();
% hold on
for i = 1 : nb_cycle
    cycle_data.Lthigh(i).cycle = i;

    frame1 = frame_bs_acc(indice_premier_backside+i-1);
    frame_front = frame_fs_acc(indice_premier_frontside+i-1);
    frame2 = frame_bs_acc(indice_premier_backside+i);

    xdata = Struct_acc.TS02113.Vt(frame1:frame2);
    pdata = (xdata-min(xdata))/(max(xdata)-min(xdata))*100;

%     plot(pdata, Struct_acc.TS01306.az(frame1:frame2) ,  LineWidth=0.5, Color=[0.8500 0.3250 0.0980]);

    cycle_data.Lthigh(i).time = xdata;
    cycle_data.Lthigh(i).pdata = pdata;

    cycle_data.Lthigh(i).ax = Struct_acc.TS02113.ax(frame1:frame2);
    cycle_data.Lthigh(i).ay = Struct_acc.TS02113.ay(frame1:frame2);
    cycle_data.Lthigh(i).az = Struct_acc.TS02113.az(frame1:frame2);

    % ajout donnees back et front
    cycle_data.Lthigh(i).timeback = Struct_acc.TS02113.Vt(frame1:frame_front-1);
    x_data_back = Struct_acc.TS02113.Vt(frame1:frame_front-1);
    cycle_data.Lthigh(i).pdata_back = (x_data_back-min(x_data_back))/(max(x_data_back)-min(x_data_back))*100;
    cycle_data.Lthigh(i).axback = Struct_acc.TS02113.ax(frame1:frame_front-1);
    cycle_data.Lthigh(i).ayback = Struct_acc.TS02113.ay(frame1:frame_front-1);
    cycle_data.Lthigh(i).azback = Struct_acc.TS02113.az(frame1:frame_front-1);
    cycle_data.Lthigh(i).ayzback = Norm_2a2(Struct_acc.TS02113.ay(frame1:frame_front-1), Struct_acc.TS02113.az(frame1:frame_front-1));
    cycle_data.Lthigh(i).axyzback = Norm_2a2(Struct_acc.TS02113.ax(frame1:frame_front-1), Struct_acc.TS02113.ay(frame1:frame_front-1), Struct_acc.TS02113.az(frame1:frame_front-1));

    cycle_data.Lthigh(i).timefront = Struct_acc.TS02113.Vt(frame_front:frame2);
    x_data_front = Struct_acc.TS02113.Vt(frame_front:frame2);
    cycle_data.Lthigh(i).pdata_front = (x_data_front-min(x_data_front))/(max(x_data_front)-min(x_data_front))*100;
    cycle_data.Lthigh(i).axfront = Struct_acc.TS02113.ax(frame_front:frame2);
    cycle_data.Lthigh(i).ayfront = Struct_acc.TS02113.ay(frame_front:frame2);
    cycle_data.Lthigh(i).azfront = Struct_acc.TS02113.az(frame_front:frame2);
    cycle_data.Lthigh(i).ayzfront = Norm_2a2(Struct_acc.TS02113.ay(frame_front:frame2), Struct_acc.TS02113.az(frame_front:frame2));
    cycle_data.Lthigh(i).axyzfront = Norm_2a2(Struct_acc.TS02113.ax(frame_front:frame2), Struct_acc.TS02113.ay(frame_front:frame2), Struct_acc.TS02113.az(frame_front:frame2));


    cycle_data.Lthigh(i).size = length(pdata);

    cycle_data.Lthigh(i).RMSaX = rms(Struct_acc.TS02113.ax(frame1:frame2));
    cycle_data.Lthigh(i).RMSaX_back = rms(Struct_acc.TS02113.ax(frame1:frame_front-1));
    cycle_data.Lthigh(i).RMSaX_front = rms(Struct_acc.TS02113.ax(frame_front:frame2));
    cycle_data.Lthigh(i).RMSaYZ_back = rms(cycle_data.Lthigh(i).ayzback);
    cycle_data.Lthigh(i).RMSaYZ_front = rms(cycle_data.Lthigh(i).ayzfront);
    cycle_data.Lthigh(i).RMSaXYZ_back = rms(cycle_data.Lthigh(i).axyzback);
    cycle_data.Lthigh(i).RMSaXYZ_front = rms(cycle_data.Lthigh(i).axyzfront);
end




%% define the frame and time of the turn in the data from the accelerometer
% TIBIA GAUCHE
matbs = repmat(Struct_acc.TS02105.Vt, [1 length(tbs)]);
matfs = repmat(Struct_acc.TS02105.Vt, [1 length(tfs)]);
[minval, closeind_bs] = min(abs(matbs-tbs'));
[minval2, closeind_fs] = min(abs(matfs-tfs'));

frame_bs_acc = closeind_bs';
frame_fs_acc = closeind_fs';

time_bs_acc = [];
time_fs_acc = [];
for i = 1:length(tbs)
    time_bs_acc = [time_bs_acc; Struct_acc.TS02105.Vt(closeind_bs(i))];
end
for i = 1:length(tfs)
    time_fs_acc = [time_fs_acc; Struct_acc.TS02105.Vt(closeind_fs(i))];
end


% add elements to the strucutre with all the infos of the cycles

% figure();
% hold on
for i = 1 : nb_cycle
    cycle_data.Ltibia(i).cycle = i;

    frame1 = frame_bs_acc(indice_premier_backside+i-1);
    frame_front = frame_fs_acc(indice_premier_frontside+i-1);
    frame2 = frame_bs_acc(indice_premier_backside+i);

    xdata = Struct_acc.TS02105.Vt(frame1:frame2);
    pdata = (xdata-min(xdata))/(max(xdata)-min(xdata))*100;

%     plot(pdata, Struct_acc.TS01306.az(frame1:frame2) ,  LineWidth=0.5, Color=[0.8500 0.3250 0.0980]);

    cycle_data.Ltibia(i).time = xdata;
    cycle_data.Ltibia(i).pdata = pdata;

    cycle_data.Ltibia(i).ax = Struct_acc.TS02105.ax(frame1:frame2);
    cycle_data.Ltibia(i).ay = Struct_acc.TS02105.ay(frame1:frame2);
    cycle_data.Ltibia(i).az = Struct_acc.TS02105.az(frame1:frame2);

    % ajout donnees back et front
    cycle_data.Ltibia(i).timeback = Struct_acc.TS02105.Vt(frame1:frame_front-1);
    x_data_back = Struct_acc.TS02105.Vt(frame1:frame_front-1);
    cycle_data.Ltibia(i).pdata_back = (x_data_back-min(x_data_back))/(max(x_data_back)-min(x_data_back))*100;
    cycle_data.Ltibia(i).axback = Struct_acc.TS02105.ax(frame1:frame_front-1);
    cycle_data.Ltibia(i).ayback = Struct_acc.TS02105.ay(frame1:frame_front-1);
    cycle_data.Ltibia(i).azback = Struct_acc.TS02105.az(frame1:frame_front-1);
    cycle_data.Ltibia(i).ayzback = Norm_2a2(Struct_acc.TS02105.ay(frame1:frame_front-1), Struct_acc.TS02105.az(frame1:frame_front-1));
    cycle_data.Ltibia(i).axyzback = Norm_2a2(Struct_acc.TS02105.ax(frame1:frame_front-1), Struct_acc.TS02105.ay(frame1:frame_front-1), Struct_acc.TS02105.az(frame1:frame_front-1));

    cycle_data.Ltibia(i).timefront = Struct_acc.TS02105.Vt(frame_front:frame2);
    x_data_front = Struct_acc.TS02105.Vt(frame_front:frame2);
    cycle_data.Ltibia(i).pdata_front = (x_data_front-min(x_data_front))/(max(x_data_front)-min(x_data_front))*100;
    cycle_data.Ltibia(i).axfront = Struct_acc.TS02105.ax(frame_front:frame2);
    cycle_data.Ltibia(i).ayfront = Struct_acc.TS02105.ay(frame_front:frame2);
    cycle_data.Ltibia(i).azfront = Struct_acc.TS02105.az(frame_front:frame2);
    cycle_data.Ltibia(i).ayzfront = Norm_2a2(Struct_acc.TS02105.ay(frame_front:frame2), Struct_acc.TS02105.az(frame_front:frame2));
    cycle_data.Ltibia(i).axyzfront = Norm_2a2(Struct_acc.TS02105.ax(frame_front:frame2), Struct_acc.TS02105.ay(frame_front:frame2), Struct_acc.TS02105.az(frame_front:frame2));

    cycle_data.Ltibia(i).size = length(pdata);

    cycle_data.Ltibia(i).RMSaX = rms(Struct_acc.TS02105.ax(frame1:frame2));
    cycle_data.Ltibia(i).RMSaX_back = rms(Struct_acc.TS02105.ax(frame1:frame_front-1));
    cycle_data.Ltibia(i).RMSaX_front = rms(Struct_acc.TS02105.ax(frame_front:frame2));
    cycle_data.Ltibia(i).RMSaYZ_back = rms(cycle_data.Ltibia(i).ayzback);
    cycle_data.Ltibia(i).RMSaYZ_front = rms(cycle_data.Ltibia(i).ayzfront);
    cycle_data.Ltibia(i).RMSaXYZ_back = rms(cycle_data.Ltibia(i).axyzback);
    cycle_data.Ltibia(i).RMSaXYZ_front = rms(cycle_data.Ltibia(i).axyzfront);
end



%% define the frame and time of the turn in the data from the accelerometer
% TIBIA DROIT
matbs = repmat(Struct_acc.TS03141.Vt, [1 length(tbs)]);
matfs = repmat(Struct_acc.TS03141.Vt, [1 length(tfs)]);
[minval, closeind_bs] = min(abs(matbs-tbs'));
[minval2, closeind_fs] = min(abs(matfs-tfs'));

frame_bs_acc = closeind_bs';
frame_fs_acc = closeind_fs';

time_bs_acc = [];
time_fs_acc = [];
for i = 1:length(tbs)
    time_bs_acc = [time_bs_acc; Struct_acc.TS03141.Vt(closeind_bs(i))];
end
for i = 1:length(tfs)
    time_fs_acc = [time_fs_acc; Struct_acc.TS03141.Vt(closeind_fs(i))];
end


% add elements to the strucutre with all the infos of the cycles

% figure();
% hold on
for i = 1 : nb_cycle
    cycle_data.Rtibia(i).cycle = i;

    frame1 = frame_bs_acc(indice_premier_backside+i-1);
    frame_front = frame_fs_acc(indice_premier_frontside+i-1);
    frame2 = frame_bs_acc(indice_premier_backside+i);

    xdata = Struct_acc.TS03141.Vt(frame1:frame2);
    pdata = (xdata-min(xdata))/(max(xdata)-min(xdata))*100;

%     plot(pdata, Struct_acc.TS01306.az(frame1:frame2) ,  LineWidth=0.5, Color=[0.8500 0.3250 0.0980]);

    cycle_data.Rtibia(i).time = xdata;
    cycle_data.Rtibia(i).pdata = pdata;

    cycle_data.Rtibia(i).ax = Struct_acc.TS03141.ax(frame1:frame2);
    cycle_data.Rtibia(i).ay = Struct_acc.TS03141.ay(frame1:frame2);
    cycle_data.Rtibia(i).az = Struct_acc.TS03141.az(frame1:frame2);

    % ajout donnees back et front
    cycle_data.Rtibia(i).timeback = Struct_acc.TS03141.Vt(frame1:frame_front-1);
    x_data_back = Struct_acc.TS03141.Vt(frame1:frame_front-1);
    cycle_data.Rtibia(i).pdata_back = (x_data_back-min(x_data_back))/(max(x_data_back)-min(x_data_back))*100;
    cycle_data.Rtibia(i).axback = Struct_acc.TS03141.ax(frame1:frame_front-1);
    cycle_data.Rtibia(i).ayback = Struct_acc.TS03141.ay(frame1:frame_front-1);
    cycle_data.Rtibia(i).azback = Struct_acc.TS03141.az(frame1:frame_front-1);
    cycle_data.Rtibia(i).ayzback = Norm_2a2(Struct_acc.TS03141.ay(frame1:frame_front-1), Struct_acc.TS03141.az(frame1:frame_front-1));
    cycle_data.Rtibia(i).axyzback = Norm_2a2(Struct_acc.TS03141.ax(frame1:frame_front-1), Struct_acc.TS03141.ay(frame1:frame_front-1), Struct_acc.TS03141.az(frame1:frame_front-1));

    cycle_data.Rtibia(i).timefront = Struct_acc.TS03141.Vt(frame_front:frame2);
    x_data_front = Struct_acc.TS03141.Vt(frame_front:frame2);
    cycle_data.Rtibia(i).pdata_front = (x_data_front-min(x_data_front))/(max(x_data_front)-min(x_data_front))*100;
    cycle_data.Rtibia(i).axfront = Struct_acc.TS03141.ax(frame_front:frame2);
    cycle_data.Rtibia(i).ayfront = Struct_acc.TS03141.ay(frame_front:frame2);
    cycle_data.Rtibia(i).azfront = Struct_acc.TS03141.az(frame_front:frame2);
    cycle_data.Rtibia(i).ayzfront = Norm_2a2(Struct_acc.TS03141.ay(frame_front:frame2), Struct_acc.TS03141.az(frame_front:frame2));
    cycle_data.Rtibia(i).axyzfront = Norm_2a2(Struct_acc.TS03141.ax(frame_front:frame2), Struct_acc.TS03141.ay(frame_front:frame2), Struct_acc.TS03141.az(frame_front:frame2));


    cycle_data.Rtibia(i).size = length(pdata);

    cycle_data.Rtibia(i).RMSaX = rms(Struct_acc.TS03141.ax(frame1:frame2));
    cycle_data.Rtibia(i).RMSaX_back = rms(Struct_acc.TS03141.ax(frame1:frame_front-1));
    cycle_data.Rtibia(i).RMSaX_front = rms(Struct_acc.TS03141.ax(frame_front:frame2));
    cycle_data.Rtibia(i).RMSaYZ_back = rms(cycle_data.Rtibia(i).ayzback);
    cycle_data.Rtibia(i).RMSaYZ_front = rms(cycle_data.Rtibia(i).ayzfront);
    cycle_data.Rtibia(i).RMSaXYZ_back = rms(cycle_data.Rtibia(i).axyzback);
    cycle_data.Rtibia(i).RMSaXYZ_front = rms(cycle_data.Rtibia(i).axyzfront);
end



