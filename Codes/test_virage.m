% data related to the joint angle

clear all;
close all;
clc;

addpath(genpath('Z:\HANDISNOW'));

essai = 'paba-021_multi.mvnx';

multi = load_mvnx(essai);

%Pos_com = traj_com(multi);

debutfin = frame_start_end(multi);
frame_debut = debutfin(1);
frame_fin = debutfin(2);
longueur = frame_fin - frame_debut + 1;

%% base de temps
for i = 1:1:size(multi.frame, 2)
    time(i) = str2num(multi.frame(i).time);
end
time_col = time';
time = time_col(frame_debut:frame_fin);



% find zeros
ori_pied_droit = rad2deg(quat2eul(multi.segmentData(18).orientation(:,:)));
liste_zeros = find(diff(sign(ori_pied_droit(:,2))));

% time turn
for i = 1:length(liste_zeros)
    time_zeros(i) = str2num(multi.frame(liste_zeros(i)).time);
end
time_zeros = time_zeros';


% filter liste zeros
time_zeros_filt_ind = [];
for i = 1 : length(time_zeros)-1
    if time_zeros(i+1)/1000-time_zeros(i)/1000 < 1
        time_zeros_filt_ind = [time_zeros_filt_ind, i];
    end
end


time_zeros_filt = [];
for i=1:length(time_zeros_filt_ind)
    time_zeros_filt = [time_zeros_filt; time_zeros(time_zeros_filt_ind(i)) ];
end

time_zeros_filtered = setdiff(time_zeros,time_zeros_filt );




liste_nulle = zeros(length(liste_zeros),1);
liste_nulle_reduce = zeros(length(time_zeros_filtered),1);


figure();
plot(time_col/1000, ori_pied_droit(:,2));
hold on
plot(time_zeros_filtered/1000, liste_nulle_reduce, '.r'); %zeros of turns
% plot(time_zeros/1000, liste_nulle, '.r'); %all the zeros

[f_bs, f_fs, tbs, tfs ] = turn_determination(multi);

%%%%
%--chevile dorsi/plantar
right_ankle = multi.jointData(17).jointAngle(frame_debut:frame_fin,3);
left_ankle = multi.jointData(21).jointAngle(frame_debut:frame_fin,3);
figure();
p1 = plot(time/1000, right_ankle, LineWidth=1.3);
p1.Color = "#4DBEEE";
hold on
p2 = plot(time/1000, left_ankle, LineWidth=1.3);
p2.Color ="#0072BD";
title('Dorsi/plantar cheville');
xlabel('Temps (s)');
ylabel('Angle (°)');
legend('cheville droite','cheville prothétique', 'AutoUpdate', 'off')

xline(tbs, '-m', {'backside'});
xline(tfs, '-c', {'frontside'});

hold on
plot(time_zeros_filtered/1000, liste_nulle_reduce, '.r');




