% VERSION 2 !!!
% This function separate the XSENS data from the different cycles
% and then interpolate to have same size list
%
% this function DOES NOT calculate the mean and sdt, you should use the
% function "cycle_data_set" or "cycle_data_set_membre_inf" depending on the
% case
%
%The method use for the detection of the cycle is based on the function
%"turn_determination" which is specific for xsens data


function cycle_data = Cycle_data_determination2(Struct)


%% initialisation
debutfin = frame_start_end(Struct);
frame_debut = debutfin(1);
frame_fin = debutfin(2);
longueur = frame_fin - frame_debut + 1;


for i = 1:1:size(Struct.frame, 2)
    time(i) = str2num(Struct.frame(i).time);
end
time_col = time';
time = time_col(frame_debut:frame_fin);

[fbs, ffs, tbs, tfs] = turn_determination(Struct,1);

%% fusion of the turns list and sort by frame (time)

merged_data = [fbs, repmat("backside", size(fbs, 1),1); ffs, repmat("frontside", size(ffs, 1),1)];
sort_data = sortrows(merged_data);
frame_turn_sorted = sort(str2double(merged_data(:,1)));
[~,idx] = sort(str2double(merged_data(:,1)));
label_turn_sorted = merged_data(idx,2);


%% joint data
Rjoint_ankle = Struct.jointData(17).jointAngle(:,3);
Ljoint_ankle = Struct.jointData(21).jointAngle(:,3);

Rjoint_knee = Struct.jointData(16).jointAngle(:,3);
Ljoint_knee = Struct.jointData(20).jointAngle(:,3);

Rjoint_hip = Struct.jointData(15).jointAngle(:,3);
Ljoint_hip = Struct.jointData(19).jointAngle(:,3);

R_foot_orientation = rad2deg(unwrap(quat2eul(Struct.segmentData(18).orientation(:,:))));
L_foot_orientation = rad2deg(unwrap(quat2eul(Struct.segmentData(22).orientation(:,:))));
% R_foot_orientation = rad2deg(quat2eul(Struct.segmentData(18).orientation(:,:)));
% L_foot_orientation = rad2deg(quat2eul(Struct.segmentData(22).orientation(:,:)));
snowboard_orientation_y = (R_foot_orientation(:,2)+L_foot_orientation(:,2))/2;
snowboard_orientation_x = (R_foot_orientation(:,1)+L_foot_orientation(:,1))/2;
snowboard_orientation_z = (R_foot_orientation(:,3)+L_foot_orientation(:,3))/2;

sternum_orientation = rad2deg(unwrap(quat2eul(Struct.segmentData(5).orientation(:,:))));

pelvis_orientation = rad2deg(unwrap(quat2eul(Struct.segmentData(1).orientation(:,:))));

cycle_data = struct();
num_cycle = 1;
index_FS = [];


figure();
hold on
legend('off');
for i = 1:(length(frame_turn_sorted)-2)
    
    if (label_turn_sorted(i) =="backside") && (label_turn_sorted(i+1) =="frontside")
        frame1 = frame_turn_sorted(i);
        frame_front = frame_turn_sorted(i+1);
        frame2 = frame_turn_sorted(i+2)-1;

        index_FS = [index_FS, frame_front-frame1];

        xdata = time_col(frame1:frame2)/1000;
        pdata = (xdata-min(xdata))/(max(xdata)-min(xdata))*100;

        % ankle
        ydataR = Rjoint_ankle(frame1:frame2);
        ydataL = Ljoint_ankle(frame1:frame2);
        
        subplot(3,2,5); hold on
        plot(pdata, ydataR ,  LineWidth=0.5, Color=[0.8500 0.3250 0.0980]);
        plot(pdata, ydataL ,  LineWidth=0.5, Color=[0.3010 0.7450 0.9330]);
        title('ankle angle');
    
        cycle_data.ankle(num_cycle).cycle =  num_cycle;
        cycle_data.ankle(num_cycle).Rjoint =  ydataR;
        cycle_data.ankle(num_cycle).Ljoint =  ydataL;
        cycle_data.ankle(num_cycle).size = length(pdata);
        cycle_data.ankle(num_cycle).pdata = pdata;

        % knee
        ydataR = Rjoint_knee(frame1:frame2);
        ydataL = Ljoint_knee(frame1:frame2);
        
        subplot(3,2,3); hold on
        plot(pdata, ydataR ,  LineWidth=0.5, Color=[0.8500 0.3250 0.0980]);
        plot(pdata, ydataL ,  LineWidth=0.5, Color=[0.3010 0.7450 0.9330]);
        title('knee angle');
    
        cycle_data.knee(num_cycle).cycle =  num_cycle;
        cycle_data.knee(num_cycle).Rjoint =  ydataR;
        cycle_data.knee(num_cycle).Ljoint =  ydataL;
        cycle_data.knee(num_cycle).size = length(pdata);
        cycle_data.knee(num_cycle).pdata = pdata;

        % hip
        ydataR = Rjoint_hip(frame1:frame2);
        ydataL = Ljoint_hip(frame1:frame2);
        
        subplot(3,2,1); hold on
        plot(pdata, ydataR ,  LineWidth=0.5, Color=[0.8500 0.3250 0.0980]);
        plot(pdata, ydataL ,  LineWidth=0.5, Color=[0.3010 0.7450 0.9330]);
        title('hip angle');
    
        cycle_data.hip(num_cycle).cycle =  num_cycle;
        cycle_data.hip(num_cycle).Rjoint =  ydataR;
        cycle_data.hip(num_cycle).Ljoint =  ydataL;
        cycle_data.hip(num_cycle).size = length(pdata);
        cycle_data.hip(num_cycle).pdata = pdata;
        
        % snowboard
        cycle_data.snowboard(num_cycle).cycle = num_cycle;
        cycle_data.snowboard(num_cycle).OrientationX = snowboard_orientation_x(frame1:frame2);
        cycle_data.snowboard(num_cycle).OrientationY = snowboard_orientation_y(frame1:frame2);
        cycle_data.snowboard(num_cycle).OrientationZ = snowboard_orientation_z(frame1:frame2);
        cycle_data.snowboard(num_cycle).pdata = pdata;

        subplot(3,2,6); hold on
        plot(pdata, snowboard_orientation_x(frame1:frame2) ,  LineWidth=0.5, Color=[0.8500 0.3250 0.0980]);
        plot(pdata, snowboard_orientation_y(frame1:frame2) ,  LineWidth=0.5, Color=[0.2500 0.8250 0.0980]);
        plot(pdata, snowboard_orientation_z(frame1:frame2) ,  LineWidth=0.5, Color=[0.1500 0.3250 0.8980]);
        title('snowboard orientation');

        % sternum
        cycle_data.sternum(num_cycle).cycle = num_cycle;
        cycle_data.sternum(num_cycle).Orientation = sternum_orientation(frame1:frame2,:);
        cycle_data.sternum(num_cycle).pdata = pdata;

        subplot(3,2,2); hold on
        plot(pdata, sternum_orientation(frame1:frame2,:) ,  LineWidth=0.5);
        title('sternum orientation');

        % bassin
        cycle_data.pelvis(num_cycle).cycle = num_cycle;
        cycle_data.pelvis(num_cycle).Orientation = pelvis_orientation(frame1:frame2,:);
        cycle_data.pelvis(num_cycle).pdata = pdata;

        subplot(3,2,4); hold on
        plot(pdata, pelvis_orientation(frame1:frame2,:) ,  LineWidth=0.5);
        title('pelvis orientation');


        num_cycle = num_cycle + 1;

    end

end

cycle_data.FS_transition = index_FS;

%% frontside frame
% for i =1:length(index_FS)
%     index_FS(i) = index_FS(i)*100/length(cycle_data.ankle(i).Rjoint);
% %     plot(cycle_data.ankle(i).pdata, cycle_data.ankle(i).Rjoint ,  LineWidth=0.5);
% %     xline(index_FS(i),'--');
% end
% 
% cycle_data.FS(1).mean = mean(index_FS);
% cycle_data.FS(1).sd = std(index_FS);











