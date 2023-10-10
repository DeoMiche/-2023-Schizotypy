%% GET DATA

load('DATA.mat')
idx = ~[EXP.exclude];
nSubj = sum(idx);

alpha = [EXP.threshold]';
alpha = alpha(idx);
p_corr = [EXP.p_correct]';
isi_th = p_corr(idx, 3);
p_corr = p_corr(idx,:);
age = [EXP.age];
age = age(idx);
group = [EXP.group];
group = group(idx);


uni_group = unique(group);
%% PLOT
figure
subplot(131); hold on

for i_group = 1:length(uni_group)
    data_group = alpha(group == uni_group(i_group));
    n_group = length(data_group);
    
    x = ones(n_group,1)*i_group+(rand(n_group,1)-.5)*.2;
    plot(x, data_group, '.', 'MarkerSize', 20)
    
end
xlim([min(uni_group)-1 max(uni_group)+1])
xticks(uni_group)
xticklabels({'20','30','40','50'})
xlabel('Age Group')
ylabel('threshold (ms)')
axis square


subplot(132); hold on

for i_group = 1:length(uni_group)
    data_group = isi_th(group == uni_group(i_group));
    n_group = length(data_group);
    
    x = ones(n_group,1)*i_group+(rand(n_group,1)-.5)*.2;
    plot(x, data_group, '.', 'MarkerSize', 20)
    
end
xlim([min(uni_group)-1 max(uni_group)+1])
xticks(uni_group)
xticklabels({'20','30','40','50'})
xlabel('Age Group')
ylabel('two-flash responses (%)')
axis square

subplot(133); hold on
ea_adult = mean(p_corr(age<31,2:end));
mi_adult = mean(p_corr(age>30 & age<41,2:end));
ad_adult = mean(p_corr(age>40 & age<51,2:end));
la_adult = mean(p_corr(age>50,2:end));
isi = (1:5)*17;
plot(isi, ea_adult, '.', 'MarkerSize', 15)
plot(isi, mi_adult, '.', 'MarkerSize', 15)
plot(isi, ad_adult, '.', 'MarkerSize', 15)
plot(isi, la_adult, '.', 'MarkerSize', 15)
ylim([0 1])
xlabel('ISI (ms)')
ylabel('two-flash responses (%)')
axis square
legend({'20s', '30s', '40s', '50s'}, 'Location', 'southeast')
%% STATS
[p,tbl,stats] = anova1(alpha, group, 'off');
[p2,tbl2,stats2] = anova1(isi_th, group, 'off');

eta_sqrd = tbl{2,2}/tbl{4,2};

% post-hoc tests
[H,P,CI,STATS] = ttest2(alpha(group==1), alpha(group==4));
[H,P,CI,STATS] = ttest2(alpha(group==1), alpha(group==3));

[H,P,CI,STATS] = ttest2(isi_th(group==4), isi_th(group==3));

[RHO,PVAL] = corr(alpha, age')
