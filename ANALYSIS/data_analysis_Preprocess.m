i = 1;

i_block = 1;
% data_dir_fn = '/Users/md5050/Desktop/RA/01_Experiments/(2022) Aging Resolution/dataset_aging/data';
data_dir_fn = '../DATA';
data_dir = dir([data_dir_fn '/*.csv']);
data_fn = {data_dir.name};
    
for i_subj = 1:length(data_fn)
    data = readtable(fullfile(data_dir_fn, data_fn{i_subj}), 'Format','auto');
    try
        EXP(i).frame_rate = round(nanmean(cellfun(@str2num, data.avg_frame_time(strcmpi(data.isFF, 'true')))));
    catch
        EXP(i).frame_rate = round(nanmean(data.avg_frame_time(strcmpi(data.isFF, 'true'))));
    end
    DEMOix = strcmp(data.isData, 'true') | strcmp(data.isData, 'TRUE'); 
    DEMO = jsondecode(data.responses{DEMOix});

    CAPS = getCAPS(data);
    SPQ = getSPQ(data);
    FF = getFFdata(data, i_block);

    EXP(i).block = i_block;
    EXP(i).age = str2num(DEMO.age);
    EXP(i).group = max(floor((str2num(DEMO.age)-11)/10),1);
    EXP(i).sex = upper(DEMO.sex(1));
    EXP(i).CAPS = CAPS.total;
    EXP(i).CAPS_sub = CAPS.sub.value';
    EXP(i).SPQ = SPQ.total;
    EXP(i).SPQ_sub = SPQ.sub.value';
    EXP(i).SPQ_comp = SPQ.comp.value';
    EXP(i).p_correct = FF.data(3,:)';

    x = (1:5)*EXP(i).frame_rate;
    nTrial = 80;
    n_correct = FF.data(3,2:end)*nTrial;      
    paramGuess = [35, 0.2 min(n_correct)/nTrial, mean([max(n_correct), n_correct(end)])/nTrial];
    [Betas, EXP(i).GoF, EXP(i).threshold ] = fit_PMF(x', n_correct', nTrial, paramGuess);

    EXP(i).Beta = Betas';
    EXP(i).exclude = EXP(i).GoF<0.90;
    if EXP(i).frame_rate<16 || EXP(i).frame_rate>18 || EXP(i).GoF<.8 || strcmp(DEMO.age, 'TEST')
        EXP(i).exclude = 1;
    else
        EXP(i).exclude = 0;
    end
    i=i+1;
end

labels.SPQ = SPQ.sub.label;
labels.CAPS = CAPS.sub.label;
labels.SPQ_comp = SPQ.comp.label;

save('DATA.mat', 'EXP', 'labels')
clearvars
load DATA.mat
