% plot les moyennes et ecart types pour les membres inférieurs
% la serie 1 est en bleu
% la série 2 est en rouge

function Compare_mean_corridor_lowerlimbjoint(S1, S2)

figure();

% Right ankle
subplot(3,2,6); hold on
ylim([-30 100]);
plot(S1.XData, S1.ankle(1).MeanR , 'b', LineWidth=1.7);
x1 = [S1.XData', fliplr(S1.XData')];
inBetween1 = [(S1.ankle(1).MeanR + S1.ankle(1).stand_devR)',fliplr((S1.ankle(1).MeanR - S1.ankle(1).stand_devR)')];
fill(x1, inBetween1, 'b','FaceAlpha', 0.1, 'EdgeColor','none');

plot(S2.XData, S2.ankle(1).MeanR , 'r', LineWidth=1.7);
x2 = [S2.XData', fliplr(S2.XData')];
inBetween2 = [(S2.ankle(1).MeanR + S2.ankle(1).stand_devR)',fliplr((S2.ankle(1).MeanR - S2.ankle(1).stand_devR)')];
fill(x2, inBetween2, 'r','FaceAlpha', 0.1, 'EdgeColor','none');

% Left ankle
subplot(3,2,5); hold on
ylim([-30 100]);
plot(S1.XData, S1.ankle(1).MeanL , 'b', LineWidth=1.7);
x1 = [S1.XData', fliplr(S1.XData')];
inBetween1 = [(S1.ankle(1).MeanL + S1.ankle(1).stand_devL)',fliplr((S1.ankle(1).MeanL - S1.ankle(1).stand_devL)')];
fill(x1, inBetween1, 'b','FaceAlpha', 0.1, 'EdgeColor','none');

plot(S2.XData, S2.ankle(1).MeanL , 'r', LineWidth=1.7);
x2 = [S2.XData', fliplr(S2.XData')];
inBetween2 = [(S2.ankle(1).MeanL + S2.ankle(1).stand_devL)',fliplr((S2.ankle(1).MeanL - S2.ankle(1).stand_devL)')];
fill(x2, inBetween2, 'r','FaceAlpha', 0.1, 'EdgeColor','none');

%%
% Right knee
subplot(3,2,4); hold on
ylim([-30 100]);
plot(S1.XData, S1.knee(1).MeanR , 'b', LineWidth=1.7);
x1 = [S1.XData', fliplr(S1.XData')];
inBetween1 = [(S1.knee(1).MeanR + S1.knee(1).stand_devR)',fliplr((S1.knee(1).MeanR - S1.knee(1).stand_devR)')];
fill(x1, inBetween1, 'b','FaceAlpha', 0.1, 'EdgeColor','none');

plot(S2.XData, S2.knee(1).MeanR , 'r', LineWidth=1.7);
x2 = [S2.XData', fliplr(S2.XData')];
inBetween2 = [(S2.knee(1).MeanR + S2.knee(1).stand_devR)',fliplr((S2.knee(1).MeanR - S2.knee(1).stand_devR)')];
fill(x2, inBetween2, 'r','FaceAlpha', 0.1, 'EdgeColor','none');

% Left knee
subplot(3,2,3); hold on
ylim([-30 100]);
plot(S1.XData, S1.knee(1).MeanL , 'b', LineWidth=1.7);
x1 = [S1.XData', fliplr(S1.XData')];
inBetween1 = [(S1.knee(1).MeanL + S1.knee(1).stand_devL)',fliplr((S1.knee(1).MeanL - S1.knee(1).stand_devL)')];
fill(x1, inBetween1, 'b','FaceAlpha', 0.1, 'EdgeColor','none');

plot(S2.XData, S2.knee(1).MeanL , 'r', LineWidth=1.7);
x2 = [S2.XData', fliplr(S2.XData')];
inBetween2 = [(S2.knee(1).MeanL + S2.knee(1).stand_devL)',fliplr((S2.knee(1).MeanL - S2.knee(1).stand_devL)')];
fill(x2, inBetween2, 'r','FaceAlpha', 0.1, 'EdgeColor','none');

%%
% Right hip
subplot(3,2,2); hold on
ylim([-30 100]);
plot(S1.XData, S1.hip(1).MeanR , 'b', LineWidth=1.7);
x1 = [S1.XData', fliplr(S1.XData')];
inBetween1 = [(S1.hip(1).MeanR + S1.hip(1).stand_devR)',fliplr((S1.hip(1).MeanR - S1.hip(1).stand_devR)')];
fill(x1, inBetween1, 'b','FaceAlpha', 0.1, 'EdgeColor','none');

plot(S2.XData, S2.hip(1).MeanR , 'r', LineWidth=1.7);
x2 = [S2.XData', fliplr(S2.XData')];
inBetween2 = [(S2.hip(1).MeanR + S2.hip(1).stand_devR)',fliplr((S2.hip(1).MeanR - S2.hip(1).stand_devR)')];
fill(x2, inBetween2, 'r','FaceAlpha', 0.1, 'EdgeColor','none');

% Left hip
subplot(3,2,1); hold on
ylim([-30 100]);
plot(S1.XData, S1.hip(1).MeanL , 'b', LineWidth=1.7);
x1 = [S1.XData', fliplr(S1.XData')];
inBetween1 = [(S1.hip(1).MeanL + S1.hip(1).stand_devL)',fliplr((S1.hip(1).MeanL - S1.hip(1).stand_devL)')];
fill(x1, inBetween1, 'b','FaceAlpha', 0.1, 'EdgeColor','none');

plot(S2.XData, S2.hip(1).MeanL , 'r', LineWidth=1.7);
x2 = [S2.XData', fliplr(S2.XData')];
inBetween2 = [(S2.hip(1).MeanL + S2.hip(1).stand_devL)',fliplr((S2.hip(1).MeanL - S2.hip(1).stand_devL)')];
fill(x2, inBetween2, 'r','FaceAlpha', 0.1, 'EdgeColor','none');







