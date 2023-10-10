load('../DATA_BIG.mat')
load('/Users/md5050/Desktop/RA/01_Experiments/(2022) Aperiodic FF/JOCN ANALYSIS/FF.mat');
ix = ~[EXP.exclude]';
TH_web = [EXP.threshold]';
TH_web = TH_web(ix);
TH_in = FF(logical(~FF(:,end)),1);

%%
figure
subplot(121); hold on

% web data
H = histogram(TH_web, 15, 'FaceColor', [0 0.4470 0.7410], 'FaceAlpha', .2, 'EdgeColor', 'none')
histogram(TH_web, 15, 'DisplayStyle', 'stairs',  'EdgeColor', [0 0.4470 0.7410], 'LineWidth', 2)
ylim([0 18])
ylabel('count')

% in person data
histogram(TH_in, H.BinEdges, 'FaceColor', [0.8500 0.3250 0.0980], 'FaceAlpha', .2, 'EdgeColor', 'none')
histogram(TH_in, H.BinEdges, 'DisplayStyle', 'stairs',  'EdgeColor', [0.8500 0.3250 0.0980], 'LineWidth', 2, 'EdgeAlpha', .9)
ylim([0 18])


axis square
xlim([10 75])
xlabel('threshold (ms)')

[H,P, CI, STATS] = ttest2(TH_web, TH_in)

%%
subplot(122); hold on
N = 80;
colorgroup = [zeros(N,1); ones(N,1)];
xData = [ones(N,1)*17; ones(N,1)*17*2; ones(N,1)*17*3; ones(N,1)*17*4; ones(N,1)*17*5;];
xData = [ones(N,1); ones(N,1)*2; ones(N,1)*3; ones(N,1)*4; ones(N,1)*5;];
yData =  [EXP.p_correct]'*100;
yData = reshape(yData(ix, 2:end), [], 1);

b = boxchart(xData,yData, 'BoxWidth', .5, 'MarkerSize', 10^-10, 'LineWidth', 2)
% plot(zeros(1,N)+ (rand(1,N)-.5)*.2, FF(ix1,1), '.', 'MarkerSize', 12, 'Color', [0 0.4470 0.7410])
% plot(ones(1,N) +(rand(1,N)-.5)*.2, FF(ix2,1), '.', 'MarkerSize', 12, 'Color', [0.8500 0.3250 0.0980])
% plot([.15, .85], [65 65], '-k', 'LineWidth', 2) 
% plot(.5, 67, '*k')
xticks([1:5])
xticklabels({17*(1:5)})
xlabel('ISI (ms)')
ylabel('Accuracy (%)')
axis square