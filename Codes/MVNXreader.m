% data related to the joint angle

clear all;
close all;
clc;

addpath(genpath('Z:\HANDISNOW'));

essai1 = 'lull-001_nolvl.mvnx';
essai2 = 'mabr-001_nolvl.mvnx';
essai3 = 'pabi-010_nolvl.mvnx';
essai4 = 'paba-021_nolvl.mvnx';

nolvl_lull001 = load_mvnx(essai1);
nolvl_mabr001 = load_mvnx(essai2);
nolvl_pabi010 = load_mvnx(essai3);
nolvl_paba021 = load_mvnx(essai4);

%Pos_com = traj_com(multi);

%%%%%%%%%%%%%
%% SUJET LULI
%%%%%%%%%%%%%

label_essai = nolvl_lull001;

debutfin = frame_start_end(label_essai);
frame_debut = debutfin(1);
frame_fin = debutfin(2);
longueur = frame_fin - frame_debut + 1;

%% base de temps
for i = 1:1:size(label_essai.frame, 2)
    time(i) = str2num(label_essai.frame(i).time);
end
time_col = time';
time = time_col(frame_debut:frame_fin);

%% define backside and frontside frame and temporality

[fbs, ffs, tbs, tfs ] = turn_determination(label_essai);


%% inclinaison corps ?? quels joints ?
% pelvis = multi.jointData(5).jointAngle(frame_debut:frame_fin,3);
% figure();
% plot(pelvis);
% title('pelvis');
% ylabel('Angle (°)');
% legend('Flex/ext');


%% graph membre inf sujet

figure();
%--hanches flex/ext
right_hip = label_essai.jointData(15).jointAngle(frame_debut:frame_fin,3);
left_hip = label_essai.jointData(19).jointAngle(frame_debut:frame_fin,3);
subplot(3,1,1);
p1 = plot(time/1000, right_hip, LineWidth=1.3);
p1.Color = "#4DBEEE";
hold on
p2 = plot(time/1000, left_hip, LineWidth=1.3);
p2.Color ="#0072BD";
title('Flexion/extension hanche');
subtitle(essai1, "FontSize", 7, Color="#0072BD");
xlabel('Temps (s)');
ylabel('Angle (°)');
legend('hanche droite','hanche gauche', 'AutoUpdate', 'off')

xline(tbs, '-m', {'backside'});
xline(tfs, '-b', {'frontside'});


%--genou flex/ext
right_knee = label_essai.jointData(16).jointAngle(frame_debut:frame_fin,3);
left_knee = label_essai.jointData(20).jointAngle(frame_debut:frame_fin,3);
subplot(3,1,2);
p1 = plot(time/1000, right_knee, LineWidth=1.3);
p1.Color = "#4DBEEE";
hold on
p2 = plot(time/1000, left_knee, LineWidth=1.3);
p2.Color ="#0072BD";
title('Flexion/extension genou');
xlabel('Temps (s)');
ylabel('Angle (°)');
legend('genou droite','genou prothétique', 'AutoUpdate', 'off')

xline(tbs, '-m', {'backside'});
xline(tfs, '-b', {'frontside'});


%--chevile dorsi/plantar
right_ankle = label_essai.jointData(17).jointAngle(frame_debut:frame_fin,3);
left_ankle = label_essai.jointData(21).jointAngle(frame_debut:frame_fin,3);
subplot(3,1,3);
p1 = plot(time/1000, right_ankle, LineWidth=1.3);
p1.Color = "#4DBEEE";
hold on
p2 = plot(time/1000, left_ankle, LineWidth=1.3);
p2.Color ="#0072BD";
title('Dorsi/plantar cheville');
xlabel('Temps (s)');
ylabel('Angle (°)');
legend('cheville droite','cheville prothétique', 'AutoUpdate', 'off');

xline(tbs, '-m', {'backside'});
xline(tfs, '-b', {'frontside'});


%%% --------------------------------------------------------------------%%%
%%%---------------------------------------------------------------------%%%


%%%%%%%%%%%%%
%% SUJET MABR
%%%%%%%%%%%%%

label_essai = nolvl_mabr001;

debutfin = frame_start_end(label_essai);
frame_debut = debutfin(1);
frame_fin = debutfin(2);
longueur = frame_fin - frame_debut + 1;

%% base de temps
for i = 1:1:size(label_essai.frame, 2)
    time(i) = str2num(label_essai.frame(i).time);
end
time_col = time';
time = time_col(frame_debut:frame_fin);

%% define backside and frontside frame and temporality

[fbs, ffs, tbs, tfs ] = turn_determination(label_essai);


%% graph membre inf sujet

%--hanches flex/ext
right_hip = label_essai.jointData(15).jointAngle(frame_debut:frame_fin,3);
left_hip = label_essai.jointData(19).jointAngle(frame_debut:frame_fin,3);
figure();
p1 = plot(time/1000, right_hip, LineWidth=1.3);
p1.Color = "#4DBEEE";
hold on
p2 = plot(time/1000, left_hip, LineWidth=1.3);
p2.Color ="#0072BD";
title('Flexion/extension hanche');
subtitle(essai1, "FontSize", 7, Color="#0072BD");
xlabel('Temps (s)');
ylabel('Angle (°)');
legend('hanche droite','hanche gauche', 'AutoUpdate', 'off')

xline(tbs, '-m', {'backside'});
xline(tfs, '-b', {'frontside'});


%--genou flex/ext
right_knee = label_essai.jointData(16).jointAngle(frame_debut:frame_fin,3);
left_knee = label_essai.jointData(20).jointAngle(frame_debut:frame_fin,3);
figure();
p1 = plot(time/1000, right_knee, LineWidth=1.3);
p1.Color = "#4DBEEE";
hold on
p2 = plot(time/1000, left_knee, LineWidth=1.3);
p2.Color ="#0072BD";
title('Flexion/extension genou');
xlabel('Temps (s)');
ylabel('Angle (°)');
legend('genou droite','genou prothétique', 'AutoUpdate', 'off')

xline(tbs, '-m', {'backside'});
xline(tfs, '-b', {'frontside'});


%--chevile dorsi/plantar
right_ankle = label_essai.jointData(17).jointAngle(frame_debut:frame_fin,3);
left_ankle = label_essai.jointData(21).jointAngle(frame_debut:frame_fin,3);
figure();
p1 = plot(time/1000, right_ankle, LineWidth=1.3);
p1.Color = "#4DBEEE";
hold on
p2 = plot(time/1000, left_ankle, LineWidth=1.3);
p2.Color ="#0072BD";
title('Dorsi/plantar cheville');
xlabel('Temps (s)');
ylabel('Angle (°)');
legend('cheville droite','cheville prothétique', 'AutoUpdate', 'off');

xline(tbs, '-m', {'backside'});
xline(tfs, '-b', {'frontside'});


%%% --------------------------------------------------------------------%%%
%%%---------------------------------------------------------------------%%%


%%%%%%%%%%%%%
%% SUJET PABI
%%%%%%%%%%%%%

label_essai = nolvl_pabi007;

debutfin = frame_start_end(label_essai);
frame_debut = debutfin(1);
frame_fin = debutfin(2);
longueur = frame_fin - frame_debut + 1;

%% base de temps
for i = 1:1:size(label_essai.frame, 2)
    time(i) = str2num(label_essai.frame(i).time);
end
time_col = time';
time = time_col(frame_debut:frame_fin);

%% define backside and frontside frame and temporality

[fbs, ffs, tbs, tfs ] = turn_determination(label_essai);


%% graph membre inf sujet

%--hanches flex/ext
right_hip = label_essai.jointData(15).jointAngle(frame_debut:frame_fin,3);
left_hip = label_essai.jointData(19).jointAngle(frame_debut:frame_fin,3);
figure();
p1 = plot(time/1000, right_hip, LineWidth=1.3);
p1.Color = "#4DBEEE";
hold on
p2 = plot(time/1000, left_hip, LineWidth=1.3);
p2.Color ="#0072BD";
title('Flexion/extension hanche');
subtitle('t', "FontSize", 7, Color="#0072BD");
xlabel('Temps (s)');
ylabel('Angle (°)');
legend('hanche droite','hanche gauche', 'AutoUpdate', 'off')

xline(tbs, '-m', {'backside'});
xline(tfs, '-b', {'frontside'});


%--genou flex/ext
right_knee = label_essai.jointData(16).jointAngle(frame_debut:frame_fin,3);
left_knee = label_essai.jointData(20).jointAngle(frame_debut:frame_fin,3);
figure();
p1 = plot(time/1000, right_knee, LineWidth=1.3);
p1.Color = "#4DBEEE";
hold on
p2 = plot(time/1000, left_knee, LineWidth=1.3);
p2.Color ="#0072BD";
title('Flexion/extension genou');
xlabel('Temps (s)');
ylabel('Angle (°)');
legend('genou droite','genou prothétique', 'AutoUpdate', 'off')

xline(tbs, '-m', {'backside'});
xline(tfs, '-b', {'frontside'});


%--chevile dorsi/plantar
right_ankle = label_essai.jointData(17).jointAngle(frame_debut:frame_fin,3);
left_ankle = label_essai.jointData(21).jointAngle(frame_debut:frame_fin,3);
figure();
p1 = plot(time/1000, right_ankle, LineWidth=1.3);
p1.Color = "#4DBEEE";
hold on
p2 = plot(time/1000, left_ankle, LineWidth=1.3);
p2.Color ="#0072BD";
title('Dorsi/plantar cheville');
xlabel('Temps (s)');
ylabel('Angle (°)');
legend('cheville droite','cheville prothétique', 'AutoUpdate', 'off');

xline(tbs, '-m', {'backside'});
xline(tfs, '-b', {'frontside'});


%%% --------------------------------------------------------------------%%%
%%%---------------------------------------------------------------------%%%

%%%%%%%%%%%%%
%% SUJET PABA
%%%%%%%%%%%%%

label_essai = nolvl_paba021;

debutfin = frame_start_end(label_essai);
frame_debut = debutfin(1);
frame_fin = debutfin(2);
longueur = frame_fin - frame_debut + 1;

%% base de temps
for i = 1:1:size(label_essai.frame, 2)
    time(i) = str2num(label_essai.frame(i).time);
end
time_col = time';
time = time_col(frame_debut:frame_fin);

%% define backside and frontside frame and temporality

[fbs, ffs, tbs, tfs ] = turn_determination(label_essai);


%% graph membre inf sujet

%--hanches flex/ext
right_hip = label_essai.jointData(15).jointAngle(frame_debut:frame_fin,3);
left_hip = label_essai.jointData(19).jointAngle(frame_debut:frame_fin,3);
figure();
p1 = plot(time/1000, right_hip, LineWidth=1.3);
p1.Color = "#4DBEEE";
hold on
p2 = plot(time/1000, left_hip, LineWidth=1.3);
p2.Color ="#0072BD";
title('Flexion/extension hanche');
subtitle(essai1, "FontSize", 7, Color="#0072BD");
xlabel('Temps (s)');
ylabel('Angle (°)');
legend('hanche droite','hanche gauche', 'AutoUpdate', 'off')

xline(tbs, '-m', {'backside'});
xline(tfs, '-b', {'frontside'});


%--genou flex/ext
right_knee = label_essai.jointData(16).jointAngle(frame_debut:frame_fin,3);
left_knee = label_essai.jointData(20).jointAngle(frame_debut:frame_fin,3);
figure();
p1 = plot(time/1000, right_knee, LineWidth=1.3);
p1.Color = "#4DBEEE";
hold on
p2 = plot(time/1000, left_knee, LineWidth=1.3);
p2.Color ="#0072BD";
title('Flexion/extension genou');
xlabel('Temps (s)');
ylabel('Angle (°)');
legend('genou droite','genou prothétique', 'AutoUpdate', 'off')

xline(tbs, '-m', {'backside'});
xline(tfs, '-b', {'frontside'});


%--chevile dorsi/plantar
right_ankle = label_essai.jointData(17).jointAngle(frame_debut:frame_fin,3);
left_ankle = label_essai.jointData(21).jointAngle(frame_debut:frame_fin,3);
figure();
p1 = plot(time/1000, right_ankle, LineWidth=1.3);
p1.Color = "#4DBEEE";
hold on
p2 = plot(time/1000, left_ankle, LineWidth=1.3);
p2.Color ="#0072BD";
title('Dorsi/plantar cheville');
xlabel('Temps (s)');
ylabel('Angle (°)');
legend('cheville droite','cheville prothétique', 'AutoUpdate', 'off');

xline(tbs, '-m', {'backside'});
xline(tfs, '-b', {'frontside'});


%%% --------------------------------------------------------------------%%%
%%%---------------------------------------------------------------------%%%

ori_pied_droit = rad2deg(quat2eul(nolvl_lull001.segmentData(18).orientation(:,:)));

figure();
hold on
plot(time, ori_pied_droit(frame_debut:frame_fin,3));









