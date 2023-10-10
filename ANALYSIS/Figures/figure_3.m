load('../DATA.mat')

ix = ~[EXP.exclude]';
TH = [EXP.threshold]';
TH = TH(ix);
CAPS = [EXP.CAPS];
CAPS = CAPS(ix);
SPQ = [EXP.SPQ];
SPQ = SPQ(ix);

%%
figure
subplot(121); hold on
plot(TH, CAPS, 'o', 'MarkerSize', 8, 'MarkerFaceColor', [0 0.4470 0.7410], 'MarkerEdgeColor', [1 1 1])
axis square tight
xlabel('two-flash threshold (ms)')
ylabel('CAPS score')

lm = fitlm(TH, CAPS)
plot(xlim, xlim*lm.Coefficients.Estimate(2)+lm.Coefficients.Estimate(1), ':', 'LineWidth', 3, 'Color', [0.8500 0.3250 0.0980])

%%
subplot(122); hold on
plot(TH, SPQ, 'o', 'MarkerSize', 8, 'MarkerFaceColor', [0 0.4470 0.7410], 'MarkerEdgeColor', [1 1 1])
axis square tight
xlabel('two-flash threshold (ms)')
ylabel('SPQ score')

lm = fitlm(TH, SPQ)
plot(xlim, xlim*lm.Coefficients.Estimate(2)+lm.Coefficients.Estimate(1), ':', 'LineWidth', 3, 'Color', [0.8500 0.3250 0.0980])
