% This function separate the XSENS data from the different cycles
% and then interpolate to have same size list
% Input :
% - 
% ouput : structure with the data of the cycle

% the function also calculate the mean and sd

function cycle_data = Cycle_data_determination(indice_premier_frontside, nb_cycle, Struct)


debutfin = frame_start_end(Struct);
frame_debut = debutfin(1);
frame_fin = debutfin(2);
longueur = frame_fin - frame_debut + 1;


for i = 1:1:size(Struct.frame, 2)
    time(i) = str2num(Struct.frame(i).time);
end
time_col = time';
time = time_col(frame_debut:frame_fin);

[fbs, ffs, tbs, tfs] = turn_determination(Struct, 1);

% find index of the first backside of interest
for i = 1:length(tbs)
    if tbs(i) > tfs(indice_premier_frontside)
        indice_premier_backside = i;
        break
    end
end

%% Joint ANKLE %%
%%%%%%%%%%%%%%%%%
Rjoint = Struct.jointData(17).jointAngle(:,3);
Ljoint = Struct.jointData(21).jointAngle(:,3);

cycle_data = struct();


% plot the angle for several cycles (in % of cycle)
% figure();
subplot(3,1,3);
hold on;
legend_text = {};
for i = 1:nb_cycle
    frame1 = fbs(indice_premier_backside+i-1);
    frame2 = fbs(indice_premier_backside+i)-1;
    
    xdata = time_col(frame1:frame2)/1000;
    pdata = (xdata-min(xdata))/(max(xdata)-min(xdata))*100;

    ydataR = Rjoint(frame1:frame2);
    ydataL = Ljoint(frame1:frame2);
    
    plot(pdata, ydataR ,  LineWidth=0.5, Color=[0.8500 0.3250 0.0980]);
    plot(pdata, ydataL ,  LineWidth=0.5, Color=[0.3010 0.7450 0.9330]);

    cycle_data.ankle(i).cycle =  i;
    cycle_data.ankle(i).Rjoint =  ydataR;
    cycle_data.ankle(i).Ljoint =  ydataL;
    cycle_data.ankle(i).size = length(pdata);
    cycle_data.ankle(i).pdata = pdata;
    legend_text{end+1} = '';
    legend_text{end+1} = '';
end

%%  interpolation to have same size list
max_size =  cycle_data.ankle(1).size;
ind_max_size = 1;
for i = 2 : length(cycle_data.ankle)
    if cycle_data.ankle(i).size > max_size
        max_size = cycle_data.ankle(i).size;
        ind_max_size = i;
    end
end

cycle_data.XData = cycle_data.ankle(ind_max_size).pdata;

% Interpolation + plot
% figure();
% hold on;
for i = 1 : length(cycle_data.ankle)
    interpolated_dataR = interp1(cycle_data.ankle(i).pdata, cycle_data.ankle(i).Rjoint, cycle_data.ankle(ind_max_size).pdata, 'spline');
    interpolated_dataL = interp1(cycle_data.ankle(i).pdata, cycle_data.ankle(i).Ljoint, cycle_data.ankle(ind_max_size).pdata, 'spline');
%     plot(cycle_data.ankle(i).pdata, cycle_data.ankle(i).Rjoint, 'o', cycle_data.ankle(ind_max_size).pdata,interpolated_dataR, '.' );
%     plot(cycle_data.ankle(i).pdata, cycle_data.ankle(i).Ljoint, 'o', cycle_data.ankle(ind_max_size).pdata,interpolated_dataR, '.' );
    cycle_data.ankle(i).Interpolated_dataR = interpolated_dataR;
    cycle_data.ankle(i).Interpolated_dataL = interpolated_dataL;
end


%% calculate the mean and sd
SumR = 0;
SumL = 0;
stand_devR = zeros( max_size , 1);
stand_devL = zeros( max_size , 1);
for i = 1 : length(cycle_data.ankle)
    SumR = SumR + cycle_data.ankle(i).Interpolated_dataR(:);
    SumL = SumL + cycle_data.ankle(i).Interpolated_dataL(:);
end

liste_valueR = zeros( max_size , length(cycle_data.ankle));
liste_valueL = zeros( max_size , length(cycle_data.ankle));
for i = 1 : max_size
    for j = 1 : length(cycle_data.ankle)
        liste_valueR(i,j) = cycle_data.ankle(j).Interpolated_dataR(i);
        liste_valueL(i,j) = cycle_data.ankle(j).Interpolated_dataL(i);
    end
    stand_devR(i) = std(liste_valueR(i,:));
    stand_devL(i) = std(liste_valueL(i,:));
end
meanR = SumR/nb_cycle;
meanL = SumL/nb_cycle;

cycle_data.ankle(1).MeanR = meanR;
cycle_data.ankle(1).MeanL = meanL;
cycle_data.ankle(1).stand_devR = stand_devR;
cycle_data.ankle(1).stand_devL = stand_devL;

%% plot mean and sd area
plot(cycle_data.ankle(ind_max_size).pdata, meanR , 'r', LineWidth=1.7);
plot(cycle_data.ankle(ind_max_size).pdata, meanL , 'b', LineWidth=1.7);

min_plotR = meanR - stand_devR;
max_plotR = meanR + stand_devR;
min_plotL = meanL - stand_devL;
max_plotL = meanL + stand_devL;

x2 = [cycle_data.ankle(ind_max_size).pdata', fliplr(cycle_data.ankle(ind_max_size).pdata')];
inBetweenR = [max_plotR',fliplr(min_plotR')];
fill(x2, inBetweenR, 'r','FaceAlpha', 0.1, 'EdgeColor','none');
inBetweenL = [max_plotL',fliplr(min_plotL')];
fill(x2, inBetweenL, 'b','FaceAlpha', 0.1, 'EdgeColor','none');

%% plot parameters
legend_text{end+1}= 'Right';
legend_text{end+1}= 'Left';
% legend_text{1}= 'Right';
% legend_text{2}= 'Left';
% legend(legend_text, 'AutoUpdate', 'off');
xlabel('Cycle (%)');
ylabel('Angle (°)');

%% KNEE ANGLE %%
%%%%%%%%%%%%%%%%
Rjoint = Struct.jointData(16).jointAngle(:,3);
Ljoint = Struct.jointData(20).jointAngle(:,3);


% plot the angle for several cycles (in % of cycle)
% figure();
subplot(3,1,2);
hold on;
legend_text = {};
for i = 1:nb_cycle
    frame1 = fbs(indice_premier_backside+i-1);
    frame2 = fbs(indice_premier_backside+i)-1;
    
    xdata = time_col(frame1:frame2)/1000;
    pdata = (xdata-min(xdata))/(max(xdata)-min(xdata))*100;

    ydataR = Rjoint(frame1:frame2);
    ydataL = Ljoint(frame1:frame2);
    
    plot(pdata, ydataR ,  LineWidth=0.5, Color=[0.8500 0.3250 0.0980]);
    plot(pdata, ydataL ,  LineWidth=0.5, Color=[0.3010 0.7450 0.9330]);

    cycle_data.knee(i).cycle =  i;
    cycle_data.knee(i).Rjoint =  ydataR;
    cycle_data.knee(i).Ljoint =  ydataL;
    cycle_data.knee(i).size = length(pdata);
    cycle_data.knee(i).pdata = pdata;
    legend_text{end+1} = '';
    legend_text{end+1} = '';
end

%%  interpolation to have same size list
max_size =  cycle_data.knee(1).size;
ind_max_size = 1;
for i = 2 : length(cycle_data.knee)
    if cycle_data.knee(i).size > max_size
        max_size = cycle_data.knee(i).size;
        ind_max_size = i;
    end
end

% Interpolation + plot
% figure();
% hold on;
for i = 1 : length(cycle_data.knee)
    interpolated_dataR = interp1(cycle_data.knee(i).pdata, cycle_data.knee(i).Rjoint, cycle_data.knee(ind_max_size).pdata, 'spline');
    interpolated_dataL = interp1(cycle_data.knee(i).pdata, cycle_data.knee(i).Ljoint, cycle_data.knee(ind_max_size).pdata, 'spline');
%     plot(cycle_data.knee(i).pdata, cycle_data.knee(i).Rjoint, 'o', cycle_data.knee(ind_max_size).pdata,interpolated_dataR, '.' );
%     plot(cycle_data.knee(i).pdata, cycle_data.knee(i).Ljoint, 'o', cycle_data.knee(ind_max_size).pdata,interpolated_dataR, '.' );
    cycle_data.knee(i).Interpolated_dataR = interpolated_dataR;
    cycle_data.knee(i).Interpolated_dataL = interpolated_dataL;
end


%% calculate the mean and sd
SumR = 0;
SumL = 0;
stand_devR = zeros( max_size , 1);
stand_devL = zeros( max_size , 1);
for i = 1 : length(cycle_data.knee)
    SumR = SumR + cycle_data.knee(i).Interpolated_dataR(:);
    SumL = SumL + cycle_data.knee(i).Interpolated_dataL(:);
end

liste_valueR = zeros( max_size , length(cycle_data.knee));
liste_valueL = zeros( max_size , length(cycle_data.knee));
for i = 1 : max_size
    for j = 1 : length(cycle_data.knee)
        liste_valueR(i,j) = cycle_data.knee(j).Interpolated_dataR(i);
        liste_valueL(i,j) = cycle_data.knee(j).Interpolated_dataL(i);
    end
    stand_devR(i) = std(liste_valueR(i,:));
    stand_devL(i) = std(liste_valueL(i,:));
end
meanR = SumR/nb_cycle;
meanL = SumL/nb_cycle;

cycle_data.knee(1).MeanR = meanR;
cycle_data.knee(1).MeanL = meanL;
cycle_data.knee(1).stand_devR = stand_devR;
cycle_data.knee(1).stand_devL = stand_devL;

%% plot mean and sd area
plot(cycle_data.knee(ind_max_size).pdata, meanR , 'r', LineWidth=1.7);
plot(cycle_data.knee(ind_max_size).pdata, meanL , 'b', LineWidth=1.7);

min_plotR = meanR - stand_devR;
max_plotR = meanR + stand_devR;
min_plotL = meanL - stand_devL;
max_plotL = meanL + stand_devL;

x2 = [cycle_data.knee(ind_max_size).pdata', fliplr(cycle_data.knee(ind_max_size).pdata')];
inBetweenR = [max_plotR',fliplr(min_plotR')];
fill(x2, inBetweenR, 'r','FaceAlpha', 0.1, 'EdgeColor','none');
inBetweenL = [max_plotL',fliplr(min_plotL')];
fill(x2, inBetweenL, 'b','FaceAlpha', 0.1, 'EdgeColor','none');

%% plot parameters
legend_text{end+1}= 'Right';
legend_text{end+1}= 'Left';
% legend_text{1}= 'Right';
% legend_text{2}= 'Left';
% legend(legend_text, 'AutoUpdate', 'off');
xlabel('Cycle (%)');
ylabel('Angle (°)');


%% HIP ANGLE %%
%%%%%%%%%%%%%%%
Rjoint = Struct.jointData(15).jointAngle(:,3);
Ljoint = Struct.jointData(19).jointAngle(:,3);


% plot the angle for several cycles (in % of cycle)
% figure();
subplot(3,1,1);
hold on;
legend_text = {};
for i = 1:nb_cycle
    frame1 = fbs(indice_premier_backside+i-1);
    frame2 = fbs(indice_premier_backside+i)-1;
    
    xdata = time_col(frame1:frame2)/1000;
    pdata = (xdata-min(xdata))/(max(xdata)-min(xdata))*100;

    ydataR = Rjoint(frame1:frame2);
    ydataL = Ljoint(frame1:frame2);
    
    plot(pdata, ydataR ,  LineWidth=0.5, Color=[0.8500 0.3250 0.0980]);
    plot(pdata, ydataL ,  LineWidth=0.5, Color=[0.3010 0.7450 0.9330]);

    cycle_data.hip(i).cycle =  i;
    cycle_data.hip(i).Rjoint =  ydataR;
    cycle_data.hip(i).Ljoint =  ydataL;
    cycle_data.hip(i).size = length(pdata);
    cycle_data.hip(i).pdata = pdata;
    legend_text{end+1} = '';
    legend_text{end+1} = '';
end

%%  interpolation to have same size list
max_size =  cycle_data.hip(1).size;
ind_max_size = 1;
for i = 2 : length(cycle_data.hip)
    if cycle_data.hip(i).size > max_size
        max_size = cycle_data.hip(i).size;
        ind_max_size = i;
    end
end

% Interpolation + plot
% figure();
% hold on;
for i = 1 : length(cycle_data.hip)
    interpolated_dataR = interp1(cycle_data.hip(i).pdata, cycle_data.hip(i).Rjoint, cycle_data.hip(ind_max_size).pdata, 'spline');
    interpolated_dataL = interp1(cycle_data.hip(i).pdata, cycle_data.hip(i).Ljoint, cycle_data.hip(ind_max_size).pdata, 'spline');
%     plot(cycle_data.hip(i).pdata, cycle_data.hip(i).Rjoint, 'o', cycle_data.hip(ind_max_size).pdata,interpolated_dataR, '.' );
%     plot(cycle_data.hip(i).pdata, cycle_data.hip(i).Ljoint, 'o', cycle_data.hip(ind_max_size).pdata,interpolated_dataR, '.' );
    cycle_data.hip(i).Interpolated_dataR = interpolated_dataR;
    cycle_data.hip(i).Interpolated_dataL = interpolated_dataL;
end


%% calculate the mean and sd
SumR = 0;
SumL = 0;
stand_devR = zeros( max_size , 1);
stand_devL = zeros( max_size , 1);
for i = 1 : length(cycle_data.hip)
    SumR = SumR + cycle_data.hip(i).Interpolated_dataR(:);
    SumL = SumL + cycle_data.hip(i).Interpolated_dataL(:);
end

liste_valueR = zeros( max_size , length(cycle_data.hip));
liste_valueL = zeros( max_size , length(cycle_data.hip));
for i = 1 : max_size
    for j = 1 : length(cycle_data.hip)
        liste_valueR(i,j) = cycle_data.hip(j).Interpolated_dataR(i);
        liste_valueL(i,j) = cycle_data.hip(j).Interpolated_dataL(i);
    end
    stand_devR(i) = std(liste_valueR(i,:));
    stand_devL(i) = std(liste_valueL(i,:));
end
meanR = SumR/nb_cycle;
meanL = SumL/nb_cycle;

cycle_data.hip(1).MeanR = meanR;
cycle_data.hip(1).MeanL = meanL;
cycle_data.hip(1).stand_devR = stand_devR;
cycle_data.hip(1).stand_devL = stand_devL;

%% plot mean and sd area
plot(cycle_data.hip(ind_max_size).pdata, meanR , 'r', LineWidth=1.7);
plot(cycle_data.hip(ind_max_size).pdata, meanL , 'b', LineWidth=1.7);

min_plotR = meanR - stand_devR;
max_plotR = meanR + stand_devR;
min_plotL = meanL - stand_devL;
max_plotL = meanL + stand_devL;

x2 = [cycle_data.hip(ind_max_size).pdata', fliplr(cycle_data.hip(ind_max_size).pdata')];
inBetweenR = [max_plotR',fliplr(min_plotR')];
fill(x2, inBetweenR, 'r','FaceAlpha', 0.1, 'EdgeColor','none');
inBetweenL = [max_plotL',fliplr(min_plotL')];
fill(x2, inBetweenL, 'b','FaceAlpha', 0.1, 'EdgeColor','none');

%% plot parameters
legend_text{end+1}= 'Right';
legend_text{end+1}= 'Left';
% legend_text{1}= 'Right';
% legend_text{2}= 'Left';
% legend(legend_text, 'AutoUpdate', 'off');
xlabel('Cycle (%)');
ylabel('Angle (°)');


% backside specification
index_bs = [];
figure();
hold on
for i = 1 : length(cycle_data.ankle)
    frame_fs = ffs(indice_premier_frontside+i-1);
    for j = 1 : length(fbs)
        if fbs(j) > frame_fs
            index_bs = [index_bs, (fbs(j)-frame_fs)];
            break
        end
    end
    index_bs(i) = index_bs(i)*100/length(cycle_data.ankle(i).Rjoint);
    plot(cycle_data.ankle(i).pdata, cycle_data.ankle(i).Rjoint ,  LineWidth=0.5);
    xline(index_bs(i),'--');
end

xline( mean(index_bs), 'k', linewidth=2);
sd = std(index_bs);
xline(mean(index_bs)-sd, '.k');
xline(mean(index_bs)+sd, '.k');

cycle_data.FS(1).mean = mean(index_bs);
cycle_data.FS(1).sd = std(index_bs);


