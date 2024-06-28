% Data related to the center of mass

clear all;
close all;
clc;

addpath(genpath('Z:\HANDISNOW'));

essai = 'pabi-010_multi.mvnx';

multi = load_mvnx(essai);

debutfin = frame_start_end(multi);
frame_debut = debutfin(1);
frame_fin = debutfin(2);

[Liste_bs,Liste_fs, frame_bs, frame_fs] = frame_turn(multi, 12, 10);

%% base de temps
for i = 1:1:size(multi.frame, 2)
    time(i) = str2num(multi.frame(i).time);
end
time_col = time';
time = time_col(frame_debut:frame_fin);

Pos_com = traj_com(multi,0);

%% verify the first turn and last turn to plot it in 3D
if frame_fs(1) < frame_bs(1)
    first_turn = frame_fs;
else
    first_turn = frame_bs;
end

if frame_fs(length(frame_fs)) < frame_bs(length(frame_bs))
    last_turn = frame_bs;
else
    last_turn = frame_fs;
end


%% visualisation trajectory 3D
subplot(2,2,1);
plot3(Pos_com(first_turn(1):last_turn(length(last_turn)),1),Pos_com(first_turn(1):last_turn(length(last_turn)),2),Pos_com(first_turn(1):last_turn(length(last_turn)),3), 'k', 'MarkerSize', 10);
hold on
for i = 1:length(frame_bs)
    plot3(Pos_com(frame_bs(i),1),Pos_com(frame_bs(i),2),Pos_com(frame_bs(i),3), '.b', 'MarkerSize', 12);
end
for i = 1:length(frame_fs)
    plot3(Pos_com(frame_fs(i),1),Pos_com(frame_fs(i),2),Pos_com(frame_fs(i),3), '.m', 'MarkerSize', 12);
end
plot3(Pos_com(first_turn(1),1),Pos_com(first_turn(1),2),Pos_com(first_turn(1),3), '.g', 'MarkerSize', 12);
xlabel('X (m)');
ylabel('Y (m)');
zlabel('Z (m)');
title('Trajectoire du centre de masse');
%axis equal;

%% position through time
subplot(2,2,2);
plot(time/1000, Pos_com(frame_debut:frame_fin,1), 'b');
hold on
plot(time/1000, Pos_com(frame_debut:frame_fin,2), 'r');
hold on
plot(time/1000, Pos_com(frame_debut:frame_fin,3), 'g');
xlabel('time (s)');
ylabel('Position (m)');
legend('X','Y','Z', 'AutoUpdate', 'off');

xline(Liste_bs(1), '--k');
xline(Liste_fs(5), '--k');

%% velocity
Speed_com = zeros(length(multi.frame) ,3);
for i = 1 : length(multi.frame)
    Speed_com(i,:) = multi.frame(i).centerOfMass(4:6)';
end

subplot(2,2,3);
plot(time/1000, Speed_com(frame_debut:frame_fin,1), 'b');
hold on
plot(time/1000, Speed_com(frame_debut:frame_fin,2), 'r');
hold on
plot(time/1000, Speed_com(frame_debut:frame_fin,3), 'g');
xlabel('time (s)');
ylabel('Velocity (m/s)');

%% acceleration
Acc_com = zeros(length(multi.frame) ,3);
for i = 1 : length(multi.frame)
    Acc_com(i,:) = multi.frame(i).centerOfMass(7:9)';
end

subplot(2,2,4);
plot(time/1000, Acc_com(frame_debut:frame_fin,1), 'b');
hold on
plot(time/1000, Acc_com(frame_debut:frame_fin,2), 'r');
hold on
plot(time/1000, Acc_com(frame_debut:frame_fin,3), 'g');
xlabel('time (s)');
ylabel('Acceleration (m/s2)');





