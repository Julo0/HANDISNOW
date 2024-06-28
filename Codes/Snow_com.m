% print the position of the board

clear all;
close all;
clc;

addpath(genpath('Z:\HANDISNOW'));
Xsens_raw = load('Raw_data_Xsens.mat');
Xsens_cycle = load('Cycle_data_Xsens.mat');


cycle_data_luli = Xsens_cycle.Cycle_data_Xsens.luli001;
mabr001 = Xsens_cycle.Cycle_data_Xsens.mabr001;
pabi010 = Xsens_cycle.Cycle_data_Xsens.pabi010;
paba021 = Xsens_cycle.Cycle_data_Xsens.paba021;
solo001 = Xsens_cycle.Cycle_data_Xsens.solo001;
maxi12 = Xsens_cycle.Cycle_data_Xsens.maxi1_2;



plot_data = maxi12;
% plot stats luli
subplot(1,3,1)
hold on
plot(plot_data.ankle(1).MeanR, plot_data.knee(1).MeanR , 'r', LineWidth=1.4);
plot(plot_data.ankle(1).MeanL, plot_data.knee(1).MeanL , 'b', LineWidth=1.4);

subplot(1,3,2)
hold on
plot(plot_data.knee(1).MeanR, plot_data.hip(1).MeanR , 'r', LineWidth=1.4);
plot(plot_data.knee(1).MeanL, plot_data.hip(1).MeanL  , 'b', LineWidth=1.4);

subplot(1,3,3)
hold on
plot(plot_data.ankle(1).MeanR, plot_data.hip(1).MeanR , 'r', LineWidth=1.4);
plot(plot_data.ankle(1).MeanL, plot_data.hip(1).MeanL , 'b', LineWidth=1.4);


rawluli = Xsens_raw.Raw_data_Xsens.luli001;

Pos_com = traj_com(rawluli, 1);

Pos_Rfoot = rawluli.segmentData(18).position(10000:19000,:);
Pos_Lfoot = rawluli.segmentData(22).position(10000:19000,:);

planche = Pos_Rfoot - Pos_Lfoot;

%vecteur
quiver3(Pos_Lfoot(:,1), Pos_Lfoot(:,2), Pos_Lfoot(:,3), planche(:,1), planche(:,2), planche(:,3));
hold on;
scatter3(Pos_Lfoot(:,1), Pos_Lfoot(:,2), Pos_Lfoot(:,3), 'r', 'filled');
scatter3(Pos_Rfoot(:,1), Pos_Rfoot(:,2), Pos_Rfoot(:,3), 'k', 'filled');

% plot 3
plot3([Pos_Lfoot(:,1),Pos_Rfoot(:,1)], [Pos_Lfoot(:,2),Pos_Rfoot(:,2)], [Pos_Lfoot(:,3),Pos_Rfoot(:,3)], LineWidth=2);


st_pg = Pos_Lfoot(1,:);
st_pd = Pos_Rfoot(1,:);
en_pg = Pos_Lfoot(end,:);
en_pd = Pos_Rfoot(end,:);
plot3([st_pg(1),st_pd(1)], [st_pg(2),st_pd(2)], [st_pg(3),st_pd(3)], LineWidth=2);
hold on
scatter3(Pos_Rfoot(1,1), Pos_Rfoot(1,2), Pos_Rfoot(1,3), 'k', 'filled');
scatter3(Pos_Lfoot(1,1), Pos_Lfoot(1,2), Pos_Lfoot(1,3), 'k', 'filled');



scatter3(Pos_Lfoot(1,1), Pos_Lfoot(1,2), Pos_Lfoot(1,3), 'r', 'filled');
hold on
scatter3(Pos_Rfoot(1,1), Pos_Rfoot(1,2), Pos_Rfoot(1,3), 'k', 'filled');
plot3([Pos_Lfoot(1,1),Pos_Rfoot(1,1)], [Pos_Lfoot(1,2),Pos_Rfoot(1,2)], [Pos_Lfoot(1,3),Pos_Rfoot(1,3)], LineWidth=2);

scatter3(Pos_Lfoot(2,1), Pos_Lfoot(2,2), Pos_Lfoot(2,3), 'r', 'filled');
hold on
scatter3(Pos_Rfoot(2,1), Pos_Rfoot(2,2), Pos_Rfoot(2,3), 'k', 'filled');
plot3([Pos_Lfoot(2,1),Pos_Rfoot(2,1)], [Pos_Lfoot(2,2),Pos_Rfoot(2,2)], [Pos_Lfoot(2,3),Pos_Rfoot(2,3)], LineWidth=2);

figure();
hold on
for i =1:500
    plot3([Pos_Lfoot(i,1),Pos_Rfoot(i,1)], [Pos_Lfoot(i,2),Pos_Rfoot(i,2)], [Pos_Lfoot(i,3),Pos_Rfoot(i,3)], LineWidth=1, Color='b');
end
plot3(Pos_com(10000:10500,1),Pos_com(10000:10500,2),Pos_com(10000:10500,3), 'r');



% animation
nb_frame = 9000;
h_seg = plot3([Pos_Lfoot(1,1),Pos_Rfoot(1,1)], [Pos_Lfoot(1,2),Pos_Rfoot(1,2)], [Pos_Lfoot(1,3),Pos_Rfoot(1,3)], LineWidth=3, Color='k');

% h_seg2 = plot3([Pos_Rtibia(1,1),Pos_Rfoot(1,1)], [Pos_Lfoot(1,2),Pos_Rfoot(1,2)], [Pos_Lfoot(1,3),Pos_Rfoot(1,3)], LineWidth=3, Color='k');

figure();

for i =1:nb_frame

    plot3(Pos_com(1000:2000,1),Pos_com(1000:2000,2),Pos_com(1000:2000,3));
    set(h_seg, 'XData', [Pos_Lfoot(i,1),Pos_Rfoot(i,1)], 'YData', [Pos_Lfoot(i,2),Pos_Rfoot(i,2)], 'ZData', [Pos_Lfoot(i,3),Pos_Rfoot(i,3)]);
    xlim([-1 1]);
    ylim([-1 1]);
    zlim([0 1]);
    pause(0.01);

end


figure();
hold on
scatter3(rawluli.segmentData(18).points.jRightAnkle(1), rawluli.segmentData(18).points.jRightAnkle(2), rawluli.segmentData(18).points.jRightAnkle(3), 'k', 'filled');
scatter3(rawluli.segmentData(18).points.jRightBallFoot(1), rawluli.segmentData(18).points.jRightBallFoot(2), rawluli.segmentData(18).points.jRightBallFoot(3), 'b', 'filled');
scatter3(rawluli.segmentData(18).points.pRightHeelFoot(1), rawluli.segmentData(18).points.pRightHeelFoot(2), rawluli.segmentData(18).points.pRightHeelFoot(3), 'b', 'filled');
scatter3(rawluli.segmentData(18).points.pRightFirstMetatarsal(1), rawluli.segmentData(18).points.pRightFirstMetatarsal(2), rawluli.segmentData(18).points.pRightFirstMetatarsal(3), 'r', 'filled');
scatter3(rawluli.segmentData(18).points.pRightFifthMetatarsal(1), rawluli.segmentData(18).points.pRightFifthMetatarsal(2), rawluli.segmentData(18).points.pRightFifthMetatarsal(3), 'r', 'filled');
scatter3(rawluli.segmentData(18).points.pRightPivotFoot(1), rawluli.segmentData(18).points.pRightPivotFoot(2), rawluli.segmentData(18).points.pRightPivotFoot(3), 'k', 'filled');
scatter3(rawluli.segmentData(18).points.pRightHeelCenter(1), rawluli.segmentData(18).points.pRightHeelCenter(2), rawluli.segmentData(18).points.pRightHeelCenter(3), 'k', 'filled');
scatter3(rawluli.segmentData(18).points.pRightTopOfFoot(1), rawluli.segmentData(18).points.pRightTopOfFoot(2), rawluli.segmentData(18).points.pRightTopOfFoot(3), 'k', 'filled');
axis equal

scatter3(rawluli.segmentData(22).points.jLeftAnkle(1), rawluli.segmentData(22).points.jLeftAnkle(2), rawluli.segmentData(22).points.jLeftAnkle(3), 'k', 'filled');
scatter3(rawluli.segmentData(22).points.jLeftBallFoot(1), rawluli.segmentData(22).points.jLeftBallFoot(2), rawluli.segmentData(22).points.jLeftBallFoot(3), 'b', 'filled');
scatter3(rawluli.segmentData(22).points.pLeftHeelFoot(1), rawluli.segmentData(22).points.pLeftHeelFoot(2), rawluli.segmentData(22).points.pLeftHeelFoot(3), 'b', 'filled');
scatter3(rawluli.segmentData(22).points.pLeftFirstMetatarsal(1), rawluli.segmentData(22).points.pLeftFirstMetatarsal(2), rawluli.segmentData(22).points.pLeftFirstMetatarsal(3), 'r', 'filled');
scatter3(rawluli.segmentData(22).points.pLeftFifthMetatarsal(1), rawluli.segmentData(22).points.pLeftFifthMetatarsal(2), rawluli.segmentData(22).points.pLeftFifthMetatarsal(3), 'r', 'filled');
scatter3(rawluli.segmentData(22).points.pLeftPivotFoot(1), rawluli.segmentData(22).points.pLeftPivotFoot(2), rawluli.segmentData(22).points.pLeftPivotFoot(3), 'k', 'filled');
scatter3(rawluli.segmentData(22).points.pLeftHeelCenter(1), rawluli.segmentData(22).points.pLeftHeelCenter(2), rawluli.segmentData(22).points.pLeftHeelCenter(3), 'k', 'filled');
scatter3(rawluli.segmentData(22).points.pLeftTopOfFoot(1), rawluli.segmentData(22).points.pLeftTopOfFoot(2), rawluli.segmentData(22).points.pLeftTopOfFoot(3), 'k', 'filled');




