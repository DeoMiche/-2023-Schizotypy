load('../DATA_BIG.mat')

ix = ~[EXP.exclude]';
TH = [EXP.threshold]';
TH = TH(ix);

group = [EXP.group]';
group = group(ix);
uni_group = unique(group);

sex = strcmp({EXP.sex}, 'M');
sex = sex(ix);

%% age
figure
subplot(121); hold on

colorG = [0.3010 0.7450 0.9330; ...
     0.4660 0.6740 0.1880; ...
    0.9290 0.6940 0.1250; ...
    0.8500 0.3250 0.0980];


yData =  TH;
xData = group;

b = boxchart(xData',yData', 'BoxWidth', .5, 'MarkerSize', 10^-10, 'LineWidth', 2)
plot([1, 3], [65 65], 'k', 'LineWidth', 2)
plot([1, 4], [67 67], 'k', 'LineWidth', 2)

xticks(uni_group)
xticklabels({'20','30','40','50'})
xlabel('Age Group')
ylabel('two-flash threshold (ms)')
axis square
ylim([10 70])




%% gender
subplot(122)

yData = TH;
xData = sex'+1;
% xData(xData == 1) == 1.25;
% xData(xData == 2) == 1.75;

nM = sum(sex);
nF = sum(~sex);
colorgroup = zeros(80,1);
colorgroup(xData == 1) = 1;

b = boxchart(xData',yData','GroupByColor', colorgroup, 'BoxWidth', .4, 'MarkerSize', 10^-10, 'LineWidth', 2)

xticks([1.25 1.75])
xticklabels({'male','female'})
xlabel('Sex')
ylabel('two-flash threshold (ms)')
axis square
ylim([10 70])
xlim([1 2])





