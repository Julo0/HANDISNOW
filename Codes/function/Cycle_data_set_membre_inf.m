% function to deal with the cycle
% it deletes all the useless cycle
% it process the rest of the cycle (interpolation, mean, sd)
% INPUT :
% - data = the structure cut in cycles
% - index_to_delete = list of the index of the cycles to delete


function cycle_data_set_membre_inf = Cycle_data_set_membre_inf(data, index_to_delete)

% calculate the number of cycle after deleting the bad ones
nb_cycle = length(data.ankle) - length(index_to_delete);
 

%% delete the bad cycles
data.ankle(index_to_delete) = [];
data.knee(index_to_delete) = [];
data.hip(index_to_delete) = [];
data.FS_transition(index_to_delete) = [];

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

end

%% calculate the mean and sd
SumRA = 0;
SumLA = 0;
SumRK = 0;
SumLK = 0;
SumRH = 0;
SumLH = 0;
for i = 1 : length(data.ankle)
    SumRA = SumRA + data.ankle(i).Interpolated_dataR(:);
    SumLA = SumLA + data.ankle(i).Interpolated_dataL(:);
    SumRK = SumRK + data.knee(i).Interpolated_dataR(:);
    SumLK = SumLK + data.knee(i).Interpolated_dataL(:);
    SumRH = SumRH + data.hip(i).Interpolated_dataR(:);
    SumLH = SumLH + data.hip(i).Interpolated_dataL(:);
end
meanRA = SumRA/nb_cycle;
meanLA = SumLA/nb_cycle;
meanRK = SumRK/nb_cycle;
meanLK = SumLK/nb_cycle;
meanRH = SumRH/nb_cycle;
meanLH = SumLH/nb_cycle;
data.ankle(1).MeanR = meanRA;
data.ankle(1).MeanL = meanLA;
data.knee(1).MeanR = meanRK;
data.knee(1).MeanL = meanLK;
data.hip(1).MeanR = meanRH;
data.hip(1).MeanL = meanLH;

stand_devRA = zeros( max_size , 1);
stand_devLA = zeros( max_size , 1);
stand_devRK = zeros( max_size , 1);
stand_devLK = zeros( max_size , 1);
stand_devRH = zeros( max_size , 1);
stand_devLH = zeros( max_size , 1);
liste_valueRA = zeros( max_size , length(data.ankle));
liste_valueLA = zeros( max_size , length(data.ankle));
liste_valueRK = zeros( max_size , length(data.knee));
liste_valueLK = zeros( max_size , length(data.knee));
liste_valueRH = zeros( max_size , length(data.hip));
liste_valueLH = zeros( max_size , length(data.hip));
for i = 1 : max_size
    for j = 1 : length(data.ankle)
        liste_valueRA(i,j) = data.ankle(j).Interpolated_dataR(i);
        liste_valueLA(i,j) = data.ankle(j).Interpolated_dataL(i);
        liste_valueRK(i,j) = data.knee(j).Interpolated_dataR(i);
        liste_valueLK(i,j) = data.knee(j).Interpolated_dataL(i);
        liste_valueRH(i,j) = data.hip(j).Interpolated_dataR(i);
        liste_valueLH(i,j) = data.hip(j).Interpolated_dataL(i);
    end
    stand_devRA(i) = std(liste_valueRA(i,:));
    stand_devLA(i) = std(liste_valueLA(i,:));
    stand_devRK(i) = std(liste_valueRK(i,:));
    stand_devLK(i) = std(liste_valueLK(i,:));
    stand_devRH(i) = std(liste_valueRH(i,:));
    stand_devLH(i) = std(liste_valueLH(i,:));
end

data.ankle(1).stand_devR = stand_devRA;
data.ankle(1).stand_devL = stand_devLA;
data.knee(1).stand_devR = stand_devRK;
data.knee(1).stand_devL = stand_devLK;
data.hip(1).stand_devR = stand_devRH;
data.hip(1).stand_devL = stand_devLH;


%% frontside frame
index_FS = data.FS_transition;
for i =1:length(index_FS)
    index_FS(i) = index_FS(i)*100/length(data.ankle(i).Rjoint);
%     plot(cycle_data.ankle(i).pdata, cycle_data.ankle(i).Rjoint ,  LineWidth=0.5);
%     xline(index_FS(i),'--');
end

data.FS(1).mean = mean(index_FS);
data.FS(1).sd = std(index_FS);


cycle_data_set_membre_inf = data;




