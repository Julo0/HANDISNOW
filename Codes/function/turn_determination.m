% function to deal with the mvnx files
% This function aims to determine the frames of the cycles, based on the
% orientation of the foot
%
% it find the frames where there are turns and then create liste with the frame
% liste with the backside and frontside

function [frame_backside , frame_frontside, time_backside, time_frontside] = turn_determination(Struct, time)

Decalage_zero = 0;
% Xsens freq
freq = 100;

% orientation of the foot and 0 determination
ori_pied_droit = rad2deg(quat2eul(Struct.segmentData(18).orientation(:,:)));
frames_zeros = find(diff(sign(ori_pied_droit(:,2)+Decalage_zero)));


% transform the frame into time
for i = 1:length(frames_zeros)
    tz(i) = str2num(Struct.frame(frames_zeros(i)).time);
end
time_zeros = tz';


% filter the list time_zeros to remove the time that are not relevant (ie
% difference < 1s btw 2 values)
time_zeros_filt_index = [];
for i = 1 : length(time_zeros)-1
    if (time_zeros(i+1)/1000-time_zeros(i)/1000) < time
        time_zeros_filt_index = [time_zeros_filt_index, i];
    end
end

time_zeros_filt = [];
for i=1:length(time_zeros_filt_index)
    time_zeros_filt = [time_zeros_filt; time_zeros(time_zeros_filt_index(i)) ];
end

time_zeros_filt = setdiff(time_zeros,time_zeros_filt );


% separation frontside backside
frame_backside = [];
frame_frontside = [];

for i = 1 : length(time_zeros_filt)
    fr = str2double(sprintf('%.0f',(time_zeros_filt(i)/10) +1));
    if ori_pied_droit(fr+1,2) > -Decalage_zero
        frame_frontside = [frame_frontside; fr];
    else
        frame_backside = [frame_backside; fr];
    end
end

% creating time list for turns
time_backside = frame_backside;
time_frontside = frame_frontside;

    for i = 1:length(frame_backside)
        time_backside(i) = str2num(Struct.frame(frame_backside(i)).time)/1000;
    end
    for i = 1:length(frame_frontside)
        time_frontside(i) = str2num(Struct.frame(frame_frontside(i)).time)/1000;
    end

% plot orientation of the right foot
debutfin = frame_start_end(Struct);
frame_debut = debutfin(1);
frame_fin = debutfin(2);
for i = 1:1:size(Struct.frame, 2)
    time(i) = str2num(Struct.frame(i).time);
end
time_col = time';
time = time_col(frame_debut:frame_fin);


liste_nulle_reduce = zeros(length(time_zeros_filt),1)-Decalage_zero;

figure();
plot(time_col/1000, ori_pied_droit(:,2));
hold on
title('Orientation of the right foot in the sagittal plane');
xlabel('time (s)');
ylabel('Angle (°)');
plot(time_zeros_filt/1000, liste_nulle_reduce, '.r');
legend('Angle','0');

% cut the data for the frames of interest
time_cut = time_col(frame_debut:frame_fin)/1000;
ori_pied_droit_cut = ori_pied_droit(frame_debut:frame_fin,2);

freq_exp = freq;
freq_coupure = 0.5;

N = 2;
[b,a] = butter(N, freq_coupure/(freq_exp/2), "low");

filter_data = filtfilt(b,a,ori_pied_droit_cut);

% figure();
% hold on
% plot(time_cut, ori_pied_droit_cut);
% plot(time_cut, filter_data, 'r');




