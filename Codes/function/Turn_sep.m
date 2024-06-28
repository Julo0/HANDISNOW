% function that separates tha data for the baordercross 2024
% INPUT :
% - the mvnx struct
% - the list wih all the time

function Data_turns = Turn_sep(Struct, list_time)

%% converting time in s
for i = 1:1:size(Struct.frame, 2)
    time(i) = str2num(Struct.frame(i).time);
end
time_col = time';

%% transforme the time list in a frame list corresponding
frame_list = list_time*100+1;

%% joint data
Rjoint_ankle = Struct.jointData(17).jointAngle(:,3);
Ljoint_ankle = Struct.jointData(21).jointAngle(:,3);

Rjoint_knee = Struct.jointData(16).jointAngle(:,3);
Ljoint_knee = Struct.jointData(20).jointAngle(:,3);

Rjoint_hip = Struct.jointData(15).jointAngle(:,3);
Ljoint_hip = Struct.jointData(19).jointAngle(:,3);

%%

Data_turns = struct();
for i = 1: size(list_time, 1)
    frame1 = frame_list(i,1);
    frame2 = frame_list(i,2);

    xdata = time_col(frame1:frame2)/1000;
    pdata = (xdata-min(xdata))/(max(xdata)-min(xdata))*100;

    %ankle
    Data_turns.Ankle(i).cycle =  i;
    Data_turns.Ankle(i).Rjoint = Rjoint_ankle(frame1:frame2);
    Data_turns.Ankle(i).Ljoint = Ljoint_ankle(frame1:frame2);
    Data_turns.Ankle(i).pdata = pdata;

    %knee
    Data_turns.Knee(i).cycle =  i;
    Data_turns.Knee(i).Rjoint = Rjoint_knee(frame1:frame2);
    Data_turns.Knee(i).Ljoint = Ljoint_knee(frame1:frame2);
    Data_turns.Knee(i).pdata = pdata;

    %hip
    Data_turns.Hip(i).cycle =  i;
    Data_turns.Hip(i).Rjoint = Rjoint_hip(frame1:frame2);
    Data_turns.Hip(i).Ljoint = Ljoint_hip(frame1:frame2);
    Data_turns.Hip(i).pdata = pdata;

end

