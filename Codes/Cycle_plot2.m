% Plot the result or one participant for the lower limbs + pelvis and
% sternum orientation

clear all
close all
clc

[nomfich, pathfich] = uigetfile('*.mat', 'Select the .mat files to plot');
data = load(fullfile(pathfich,nomfich));
name = fieldnames(data);
kinematic_data = data.(name{1});

to_plot = kinematic_data;
figure();

% couleur (inverser si necessaire)
% code couleur : 
% rouge = prothese : 'r'
% bleu = membre opposé : 'b'
% dans le cas de non ampute
% rouge = pied arriere : 'r'
% bleu = pied avant : 'b'

droite = 'r';
gauche = 'b';

%
joint = 'ankle';
subplot(1,3,1); hold on
ylim([-30 100]);
plot(to_plot.XData, to_plot.(joint)(1).MeanR , Color=droite, LineWidth=1.7);
plot(to_plot.XData, to_plot.(joint)(1).MeanL , Color=gauche, LineWidth=1.7);
x2 = [to_plot.XData', fliplr(to_plot.XData')];
inBetweenR = [(to_plot.(joint)(1).MeanR + to_plot.(joint)(1).stand_devR)',fliplr((to_plot.(joint)(1).MeanR - to_plot.(joint)(1).stand_devR)')];
fill(x2, inBetweenR, droite,'FaceAlpha', 0.1, 'EdgeColor','none');
inBetweenL = [(to_plot.(joint)(1).MeanL + to_plot.(joint)(1).stand_devL)',fliplr((to_plot.(joint)(1).MeanL - to_plot.(joint)(1).stand_devL)')];
fill(x2, inBetweenL, gauche,'FaceAlpha', 0.1, 'EdgeColor','none');

xline(to_plot.FS.mean, '-k', linewidth=1);
xline(to_plot.FS.mean-to_plot.FS.sd, ':k');
xline(to_plot.FS.mean+to_plot.FS.sd, ':k');

title(joint);

%
joint = 'knee';
subplot(1,3,2); hold on
ylim([-30 100]);
plot(to_plot.XData, to_plot.(joint)(1).MeanR , Color=droite, LineWidth=1.7);
plot(to_plot.XData, to_plot.(joint)(1).MeanL , Color=gauche, LineWidth=1.7);
x2 = [to_plot.XData', fliplr(to_plot.XData')];
inBetweenR = [(to_plot.(joint)(1).MeanR + to_plot.(joint)(1).stand_devR)',fliplr((to_plot.(joint)(1).MeanR - to_plot.(joint)(1).stand_devR)')];
fill(x2, inBetweenR, droite,'FaceAlpha', 0.1, 'EdgeColor','none');
inBetweenL = [(to_plot.(joint)(1).MeanL + to_plot.(joint)(1).stand_devL)',fliplr((to_plot.(joint)(1).MeanL - to_plot.(joint)(1).stand_devL)')];
fill(x2, inBetweenL, gauche,'FaceAlpha', 0.1, 'EdgeColor','none');

xline(to_plot.FS.mean, '-k', linewidth=1);
xline(to_plot.FS.mean-to_plot.FS.sd, ':k');
xline(to_plot.FS.mean+to_plot.FS.sd, ':k');

title(joint);

%
joint = 'hip';
subplot(1,3,3); hold on
ylim([-30 100]);
plot(to_plot.XData, to_plot.(joint)(1).MeanR , Color=droite, LineWidth=1.7);
plot(to_plot.XData, to_plot.(joint)(1).MeanL , Color=gauche, LineWidth=1.7);
x2 = [to_plot.XData', fliplr(to_plot.XData')];
inBetweenR = [(to_plot.(joint)(1).MeanR + to_plot.(joint)(1).stand_devR)',fliplr((to_plot.(joint)(1).MeanR - to_plot.(joint)(1).stand_devR)')];
fill(x2, inBetweenR, droite,'FaceAlpha', 0.1, 'EdgeColor','none');
inBetweenL = [(to_plot.(joint)(1).MeanL + to_plot.(joint)(1).stand_devL)',fliplr((to_plot.(joint)(1).MeanL - to_plot.(joint)(1).stand_devL)')];
fill(x2, inBetweenL, gauche,'FaceAlpha', 0.1, 'EdgeColor','none');

xline(to_plot.FS.mean, '-k', linewidth=1);
xline(to_plot.FS.mean-to_plot.FS.sd, ':k');
xline(to_plot.FS.mean+to_plot.FS.sd, ':k');

title(joint);

legend({droite, gauche});
sgtitle('ferreol , tf, regular, 19 cycles')







