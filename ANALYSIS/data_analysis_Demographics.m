load('DATA.mat')
idx = ~[EXP.exclude];
nSubj = sum(idx);

tmp = [EXP.threshold];
alpha = tmp(idx);

age = [EXP.age];
age = age(idx);

sex = strcmp({EXP.sex}, 'M');
sex = sex(idx);

figure
subplot(121)
plot(age, alpha, 'o', 'MarkerFaceColor', 'b')
% scatter(age, alpha, [], CAPS, 'filled');
% colorbar
xlabel('age (years)')
ylabel('threshold (ms)')
[R,p] = corrcoef(age, alpha);
p =p(1,2);
% LM = fitlm(age, alpha, 'RobustOpts','on');
LM = fitlm(age, alpha);
if p<.05
    hold on
    plot(xlim, LM.Coefficients.Estimate(1) + xlim * LM.Coefficients.Estimate(2), ':', 'LineWidth', 4)
    dim = [.8 .8 .1 .1];
    str = {['P : ' num2str(round(p,3))],['R : ' num2str(round(R(1,2),3))]};
    text(50,50, str)
%     annotation('textbox',dim,'String',str,'FitBoxToText','on');
end
title(['N = ' num2str(sum(idx))])
axis square

nM = sum(sex);
nF = sum(~sex);
subplot(122)
plot(zeros(nM,1)+(rand(nM,1)-.5)*.2, alpha(sex), 'o', 'MarkerFaceColor', 'b')
hold on
plot(ones(nF,1)+(rand(nF,1)-.5)*.2, alpha(~sex), 'o', 'MarkerFaceColor', 'r')
xlim([-1 2])
xticks([0 1])
xticklabels({['male (' num2str(nM) ')'], ['female (' num2str(nF) ')']})
ylabel('threshold')
[H,P] = ttest2( alpha(sex),  alpha(~sex));
% title(['P : ' num2str(P)])
axis square

%%
idx = ~[EXP.exclude];
nSubj = sum(idx);

alpha = [EXP.Beta]';
alpha = alpha(idx,1)';

alpha = [EXP.threshold]';
alpha = alpha(idx);
age = [EXP.age];
age = age(idx);

figure
% subplot(121)
% pie(cob, [1 1 0 1])
subplot(121)
histogram(age, 'BinWidth', 2.5)
xlabel('age (years)')
ylabel('count')

% ylim([0 7])
axis square tight
subplot(122)
histfit(alpha, 20)
% pd = fitdist(alpha,'Normal')
xlabel('FF threshold (ms)')
ylabel('count')
% xlim([0 80])
axis square

% Results=normalitytest(alpha)
[h,p,ksstat,cv] = kstest((alpha-mean(alpha))/std(alpha));

%%

CAPS = [EXP.CAPS];
CAPS = CAPS(idx);

SPQ = [EXP.SPQ];
SPQ = SPQ(idx);

SPQ_sub = [EXP.SPQ_sub];
SPQ_comp = [EXP.SPQ_comp];

corrMat = [age' CAPS' SPQ']; % SPQ_sub' SPQ_comp'];
[R,p] = corrcoef(corrMat);