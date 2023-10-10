load('DATA.mat')

idx = ~[EXP.exclude];

tmp = [EXP.threshold]; % use threshold fit

% tmp = [EXP.p_correct];
% tmp = tmp(1,:);     % use catch trials or any ISI

alpha = tmp(idx);

CAPS = [EXP.CAPS];
CAPS_sub = [EXP.CAPS_sub];
SPQ = [EXP.SPQ];
SPQ_sub = [EXP.SPQ_sub];
SPQ_comp = [EXP.SPQ_comp];
age = [EXP.age];
age = age(idx);

%% alpha vs SPQ

figure
subplot(121)
plot(alpha, SPQ(idx), 'o', 'MarkerFaceColor', 'b')
xlabel('threshold (ms)')
ylabel('SPQ score')
[R,p] = corrcoef(alpha, SPQ(idx));
p =p(1,2);
LM = fitlm(alpha, SPQ(idx));
if p<.05
    hold on
    plot(xlim, LM.Coefficients.Estimate(1) + xlim * LM.Coefficients.Estimate(2), 'LineWidth', 4)
    str = {['P : ' num2str(round(p,3))],['R : ' num2str(round(R(1,2),3))]};
    text(45,60, str)
end
% title(['Alpha vs SPQ - P : ' num2str(p)])
axis square

subplot(122)
plot(alpha, CAPS(idx), 'o', 'MarkerFaceColor', 'b')
xlabel('threshold (ms)')
ylabel('CAPS score')
P = coefTest(fitlm(alpha', CAPS(idx)));
[R,p] = corrcoef(alpha, CAPS(idx));
p =p(1,2);
LM = fitlm(alpha, CAPS(idx));
if p<.05
    hold on
    plot(xlim, LM.Coefficients.Estimate(1) + xlim * LM.Coefficients.Estimate(2), 'LineWidth', 4)
    str = {['P : ' num2str(round(p,3))],['R : ' num2str(round(R(1,2),3))]};
    text(45,20, str)
end
% title(['Alpha vs CAPS - P : ' num2str(p)])
% xlim([17 60])
axis square

%% alpha vs CAPS subscale

figure
for i_sub = 1:3   
    subplot(1,3,i_sub)
    plot(alpha, CAPS_sub(i_sub,idx), 'o', 'MarkerFaceColor', 'b')
    xlabel('threshold (ms)')
    LM=fitlm(alpha, CAPS_sub(i_sub,idx), 'RobustOpts','on');
    P = coefTest(LM);
    [R,p] = corrcoef(alpha, CAPS_sub(i_sub,idx));
    p = p(1,2);
    axis square
    
    if p<.05
        hold on
        plot(xlim, LM.Coefficients.Estimate(1) + xlim * LM.Coefficients.Estimate(2), 'LineWidth', 4)
        yLim = ylim;
        str = {['P : ' num2str(round(p,3))],['R : ' num2str(round(R(1,2),3))]};
        text(45,yLim(2)-2, str)
    end
    
    yLim = ylim;
    str = {['P : ' num2str(round(p,3))],['R : ' num2str(round(R(1,2),3))]};
    text(45,yLim(2)-2, str)
    
    ylabel(['CAPS subscale ' num2str(i_sub)])
%     title([labels.SPQ{i_sub} ' - P : ' num2str(p)])
    title([labels.CAPS{i_sub}])
end

%% alpha vs SPQ subscale

figure
for i_sub = 1:9   
    subplot(3,3,i_sub)
    plot(alpha, SPQ_sub(i_sub,idx), 'o', 'MarkerFaceColor', 'b')
    xlabel('threshold (ms)')
    LM=fitlm(alpha, SPQ_sub(i_sub,idx), 'RobustOpts','on');
    P = coefTest(LM);
    [R,p] = corrcoef(alpha, SPQ_sub(i_sub,idx));
    p = p(1,2);
    axis square
    
    if p<.05
        hold on
        plot(xlim, LM.Coefficients.Estimate(1) + xlim * LM.Coefficients.Estimate(2), 'LineWidth', 4)
        yLim = ylim;
        str = {['P : ' num2str(round(p,3))],['R : ' num2str(round(R(1,2),3))]};
        text(45,yLim(2)-2, str)
    end
    
    ylabel(['SPQ subscale ' num2str(i_sub)])
%     title([labels.SPQ{i_sub} ' - P : ' num2str(p)])
    title([labels.SPQ{i_sub}])
end
% sgtitle('Alpha vs SPQ subscales')

%% alpha vs SPQ component

figure
for i_comp = 1:3
    subplot(1,3,i_comp)
    plot(alpha, SPQ_comp(i_comp,idx), 'o', 'MarkerFaceColor', 'b')
    xlabel('threshold (ms)')
    LM=fitlm(alpha, SPQ_comp(i_comp,idx), 'RobustOpts','on');
    P = coefTest(LM);
    [R,p] = corrcoef(alpha, SPQ_comp(i_comp,idx));
    p = p(1,2);
    axis square
    
    if p<.05
        hold on
        plot(xlim, LM.Coefficients.Estimate(1) + xlim * LM.Coefficients.Estimate(2), 'LineWidth', 4)
            yLim = ylim;
        str = {['P : ' num2str(round(p,3))],['R : ' num2str(round(R(1,2),3))]};
        text(45,yLim(2)-5, str)
    end
    
    ylabel(['SPQ component ' num2str(i_comp)])
%     title([labels.SPQ_comp{i_comp} ' - P : ' num2str(p)])
    title([labels.SPQ_comp{i_comp}])
end
% sgtitle('Alpha vs SPQ components')

%% LME for spurious effects

ds = dataset(alpha', SPQ(idx)', age', 'VarNames', {'FF', 'SPQ', 'AGE'});
lme = fitlme(ds,'FF ~ SPQ + AGE')

ds = dataset(alpha', CAPS(idx)', age', 'VarNames', {'FF', 'CAPS', 'AGE'});
lme = fitlme(ds,'FF ~ CAPS + AGE')

