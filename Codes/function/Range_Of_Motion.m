% function that calculates he ranges of motion of cycled data
% it return the mean of the range of motion of all the cycles and the
% standard deviation

function Result = Range_Of_Motion(Struct)

list_RoM_LeftAnkle = [];
list_RoM_RightAnkle = [];

list_RoM_LeftKnee = [];
list_RoM_RightKnee = [];

list_RoM_LeftHip = [];
list_RoM_RightHip = [];

for i=1:length(Struct.ankle)
    list_RoM_RightAnkle = [list_RoM_RightAnkle; max(Struct.ankle(i).Rjoint) - min(Struct.ankle(i).Rjoint)];
    list_RoM_LeftAnkle = [list_RoM_LeftAnkle; max(Struct.ankle(i).Ljoint) - min(Struct.ankle(i).Ljoint)];

    list_RoM_RightKnee = [list_RoM_RightKnee; max(Struct.knee(i).Rjoint) - min(Struct.knee(i).Rjoint)];
    list_RoM_LeftKnee = [list_RoM_LeftKnee; max(Struct.knee(i).Ljoint) - min(Struct.knee(i).Ljoint)];

    list_RoM_RightHip = [list_RoM_RightHip; max(Struct.hip(i).Rjoint) - min(Struct.hip(i).Rjoint)];
    list_RoM_LeftHip = [list_RoM_LeftHip; max(Struct.hip(i).Ljoint) - min(Struct.hip(i).Ljoint)];

end

% MEAN
MeanLA = mean(list_RoM_LeftAnkle);
MeanRA = mean(list_RoM_RightAnkle);

MeanLK = mean(list_RoM_LeftKnee);
MeanRK = mean(list_RoM_RightKnee);

MeanLH = mean(list_RoM_LeftHip);
MeanRH = mean(list_RoM_RightHip);


%STANDARD DEV
SDLA = std(list_RoM_LeftAnkle);
SDRA = std(list_RoM_RightAnkle);

SDLK = std(list_RoM_LeftKnee);
SDRK = std(list_RoM_RightKnee);

SDLH = std(list_RoM_LeftHip);
SDRH = std(list_RoM_RightHip);

%TABLE
Ankle = [MeanLA; MeanRA; SDLA; SDRA];
Knee = [MeanLK; MeanRK; SDLK; SDRK];
Hip = [MeanLH; MeanRH; SDLH; SDRH];

Result = table(Ankle, Knee, Hip);

Result.Properties.RowNames = {'MeanL','MeanR','SDL','SDR'};



