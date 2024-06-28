% function to deal with the cycle
% it deletes all the useless cycle
% it process the rest of the cycle (interpolation, mean, sd)
% INPUT :
% - data = the structure cut in cycles
% - index_to_delete = list of the index of the cycles to delete


function cycle_data_set = Cycle_data_set(data, index_to_delete)

% calculate the number of cycle after deleting the bad ones
nb_cycle = length(data.ankle) - length(index_to_delete);
 

%% delete the bad cycles
data.ankle(index_to_delete) = [];
data.knee(index_to_delete) = [];
data.hip(index_to_delete) = [];
data.sternum(index_to_delete) = [];
data.pelvis(index_to_delete) = [];
data.FS_transition(index_to_delete) = [];
data.snowboard(index_to_delete) = [];

%%  interpolation to have same size list
max_size =  data.ankle(1).size;
ind_max_size = 1;
for i = 2 : length(data.ankle)
    if data.ankle(i).size > max_size
        max_size = data.ankle(i).size;
        ind_max_size = i;
    end
end

data.XData = data.ankle(ind_max_size).pdata;

% Interpolation + plot
% figure();
% hold on;
for i = 1 : length(data.ankle)
    % ankle
    interpolated_dataR = interp1(data.ankle(i).pdata, data.ankle(i).Rjoint, data.ankle(ind_max_size).pdata, 'spline');
    interpolated_dataL = interp1(data.ankle(i).pdata, data.ankle(i).Ljoint, data.ankle(ind_max_size).pdata, 'spline');
%     plot(data.ankle(i).pdata, data.ankle(i).Rjoint, 'o', data.ankle(ind_max_size).pdata,interpolated_dataR, '.' );
%     plot(data.ankle(i).pdata, data.ankle(i).Ljoint, 'o', data.ankle(ind_max_size).pdata,interpolated_dataL, '.' );
    data.ankle(i).Interpolated_dataR = interpolated_dataR;
    data.ankle(i).Interpolated_dataL = interpolated_dataL;

    % knee
    interpolated_dataR = interp1(data.knee(i).pdata, data.knee(i).Rjoint, data.knee(ind_max_size).pdata, 'spline');
    interpolated_dataL = interp1(data.knee(i).pdata, data.knee(i).Ljoint, data.knee(ind_max_size).pdata, 'spline');
%     plot(data.knee(i).pdata, data.knee(i).Rjoint, 'o', data.knee(ind_max_size).pdata,interpolated_dataR, '.' );
%     plot(data.knee(i).pdata, data.knee(i).Ljoint, 'o', data.knee(ind_max_size).pdata,interpolated_dataL, '.' );
    data.knee(i).Interpolated_dataR = interpolated_dataR;
    data.knee(i).Interpolated_dataL = interpolated_dataL;

    % hip
    interpolated_dataR = interp1(data.hip(i).pdata, data.hip(i).Rjoint, data.hip(ind_max_size).pdata, 'spline');
    interpolated_dataL = interp1(data.hip(i).pdata, data.hip(i).Ljoint, data.hip(ind_max_size).pdata, 'spline');
%     plot(data.hip(i).pdata, data.hip(i).Rjoint, 'o', data.hip(ind_max_size).pdata,interpolated_dataR, '.' );
%     plot(data.hip(i).pdata, data.hip(i).Ljoint, 'o', data.hip(ind_max_size).pdata,interpolated_dataL, '.' );
    data.hip(i).Interpolated_dataR = interpolated_dataR;
    data.hip(i).Interpolated_dataL = interpolated_dataL;

    % sternum
    interpolated_orientation = interp1(data.sternum(i).pdata, data.sternum(i).Orientation, data.sternum(ind_max_size).pdata, 'spline');
    data.sternum(i).interpolated_orientation = interpolated_orientation;

    % pelvis
    interpolated_orientation = interp1(data.pelvis(i).pdata, data.pelvis(i).Orientation, data.pelvis(ind_max_size).pdata, 'spline');
    data.pelvis(i).interpolated_orientation = interpolated_orientation;

    % snowboard
%     interpolated_OrientationY = interp1(data.snowboard(i).pdata, data.snowboard(i).OrientationY, data.snowboard(ind_max_size).pdata, 'spline');
%     interpolated_OrientationX = interp1(data.snowboard(i).pdata, data.snowboard(i).OrientationX, data.snowboard(ind_max_size).pdata, 'spline');
%     interpolated_OrientationZ = interp1(data.snowboard(i).pdata, data.snowboard(i).OrientationZ, data.snowboard(ind_max_size).pdata, 'spline');
%     data.snowboard(i).Interpolated_OrientationX = interpolated_OrientationX;
%     data.snowboard(i).Interpolated_OrientationY = interpolated_OrientationY;
%     data.snowboard(i).Interpolated_OrientationZ = interpolated_OrientationZ;

end

%% calculate the mean and sd
SumRA = 0;
SumLA = 0;
SumRK = 0;
SumLK = 0;
SumRH = 0;
SumLH = 0;
SumSX = 0;
SumSY = 0;
SumSZ = 0;
SumStern = 0;
SumPel = 0;
for i = 1 : length(data.ankle)
    SumRA = SumRA + data.ankle(i).Interpolated_dataR(:);
    SumLA = SumLA + data.ankle(i).Interpolated_dataL(:);
    SumRK = SumRK + data.knee(i).Interpolated_dataR(:);
    SumLK = SumLK + data.knee(i).Interpolated_dataL(:);
    SumRH = SumRH + data.hip(i).Interpolated_dataR(:);
    SumLH = SumLH + data.hip(i).Interpolated_dataL(:);
%     SumSY = SumSY + data.snowboard(i).Interpolated_OrientationY(:);
%     SumSX = SumSX + data.snowboard(i).Interpolated_OrientationX(:);
%     SumSZ = SumSZ + data.snowboard(i).Interpolated_OrientationZ(:);
    SumStern = SumStern + data.sternum(i).interpolated_orientation;
    SumPel = SumPel + data.pelvis(i).interpolated_orientation;
end
meanRA = SumRA/nb_cycle;
meanLA = SumLA/nb_cycle;
meanRK = SumRK/nb_cycle;
meanLK = SumLK/nb_cycle;
meanRH = SumRH/nb_cycle;
meanLH = SumLH/nb_cycle;
meanSY = SumSY/nb_cycle;
meanSX = SumSX/nb_cycle;
meanSZ = SumSZ/nb_cycle;
meanStern = SumStern/nb_cycle;
meanPel = SumPel/nb_cycle;
data.ankle(1).MeanR = meanRA;
data.ankle(1).MeanL = meanLA;
data.knee(1).MeanR = meanRK;
data.knee(1).MeanL = meanLK;
data.hip(1).MeanR = meanRH;
data.hip(1).MeanL = meanLH;
% data.snowboard(1).MeanOriX = meanSX;
% data.snowboard(1).MeanOriY = meanSY;
% data.snowboard(1).MeanOriZ = meanSZ;
data.sternum(1).Mean = meanStern;
data.pelvis(1).Mean = meanPel;

stand_devRA = zeros( max_size , 1);
stand_devLA = zeros( max_size , 1);
stand_devRK = zeros( max_size , 1);
stand_devLK = zeros( max_size , 1);
stand_devRH = zeros( max_size , 1);
stand_devLH = zeros( max_size , 1);
stand_devSY = zeros( max_size , 1);
stand_devSX = zeros( max_size , 1);
stand_devSZ = zeros( max_size , 1);
stand_devStern = zeros( max_size , 3);
stand_devPel = zeros( max_size , 3);
liste_valueRA = zeros( max_size , length(data.ankle));
liste_valueLA = zeros( max_size , length(data.ankle));
liste_valueRK = zeros( max_size , length(data.knee));
liste_valueLK = zeros( max_size , length(data.knee));
liste_valueRH = zeros( max_size , length(data.hip));
liste_valueLH = zeros( max_size , length(data.hip));
% liste_valueSY = zeros( max_size , length(data.snowboard));
% liste_valueSX = zeros( max_size , length(data.snowboard));
% liste_valueSZ = zeros( max_size , length(data.snowboard));
liste_valueSternX = zeros( max_size , length(data.sternum));
liste_valueSternY = zeros( max_size , length(data.sternum));
liste_valueSternZ = zeros( max_size , length(data.sternum));
liste_valuePelX = zeros( max_size , length(data.pelvis));
liste_valuePelY = zeros( max_size , length(data.pelvis));
liste_valuePelZ = zeros( max_size , length(data.pelvis));
for i = 1 : max_size
    for j = 1 : length(data.ankle)
        liste_valueRA(i,j) = data.ankle(j).Interpolated_dataR(i);
        liste_valueLA(i,j) = data.ankle(j).Interpolated_dataL(i);
        liste_valueRK(i,j) = data.knee(j).Interpolated_dataR(i);
        liste_valueLK(i,j) = data.knee(j).Interpolated_dataL(i);
        liste_valueRH(i,j) = data.hip(j).Interpolated_dataR(i);
        liste_valueLH(i,j) = data.hip(j).Interpolated_dataL(i);
%         liste_valueSY(i,j) = data.snowboard(j).Interpolated_OrientationY(i);
%         liste_valueSX(i,j) = data.snowboard(j).Interpolated_OrientationX(i);
%         liste_valueSZ(i,j) = data.snowboard(j).Interpolated_OrientationZ(i);
        liste_valueSternX(i,j) = data.sternum(j).interpolated_orientation(i,1);
        liste_valueSternY(i,j) = data.sternum(j).interpolated_orientation(i,2);
        liste_valueSternZ(i,j) = data.sternum(j).interpolated_orientation(i,3);
        liste_valuePelX(i,j) = data.pelvis(j).interpolated_orientation(i,1);
        liste_valuePelY(i,j) = data.pelvis(j).interpolated_orientation(i,2);
        liste_valuePelZ(i,j) = data.pelvis(j).interpolated_orientation(i,3);
    end
    stand_devRA(i) = std(liste_valueRA(i,:));
    stand_devLA(i) = std(liste_valueLA(i,:));
    stand_devRK(i) = std(liste_valueRK(i,:));
    stand_devLK(i) = std(liste_valueLK(i,:));
    stand_devRH(i) = std(liste_valueRH(i,:));
    stand_devLH(i) = std(liste_valueLH(i,:));
%     stand_devSY(i) = std(liste_valueSY(i,:));
%     stand_devSX(i) = std(liste_valueSX(i,:));
%     stand_devSZ(i) = std(liste_valueSZ(i,:));
    stand_devStern(i,1) = std(liste_valueSternX(i,:));
    stand_devStern(i,2) = std(liste_valueSternY(i,:));
    stand_devStern(i,3) = std(liste_valueSternZ(i,:));
    stand_devPel(i,1) = std(liste_valuePelX(i,:));
    stand_devPel(i,2) = std(liste_valuePelY(i,:));
    stand_devPel(i,3) = std(liste_valuePelZ(i,:));
end

data.ankle(1).stand_devR = stand_devRA;
data.ankle(1).stand_devL = stand_devLA;
data.knee(1).stand_devR = stand_devRK;
data.knee(1).stand_devL = stand_devLK;
data.hip(1).stand_devR = stand_devRH;
data.hip(1).stand_devL = stand_devLH;
% data.snowboard(1).stand_devSX = stand_devSX;
% data.snowboard(1).stand_devSY = stand_devSY;
% data.snowboard(1).stand_devSZ = stand_devSZ;
data.sternum(1).stand_dev = stand_devStern;
data.pelvis(1).stand_dev = stand_devPel;


%% frontside frame
index_FS = data.FS_transition;
for i =1:length(index_FS)
    index_FS(i) = index_FS(i)*100/length(data.ankle(i).Rjoint);
%     plot(cycle_data.ankle(i).pdata, cycle_data.ankle(i).Rjoint ,  LineWidth=0.5);
%     xline(index_FS(i),'--');
end

data.FS(1).mean = mean(index_FS);
data.FS(1).sd = std(index_FS);


cycle_data_set = data;




