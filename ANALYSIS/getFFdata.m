function FF = getFFdata(data, block)

FFix = strcmpi(data.isFF, 'true');
FFix2 = find(FFix)-2;
FFix = find(FFix)-1;

for i_trial = 1:length(FFix)
    try
        FF.iti(i_trial) = str2num(data.time_elapsed{FFix(i_trial)})-str2num(data.time_elapsed{FFix2(i_trial)});
    catch
        FF.iti(i_trial) = data.time_elapsed(FFix(i_trial))-data.time_elapsed(FFix2(i_trial));
    end
end
FF.iti = FF.iti';

FFix = strcmpi(data.isFF, 'true');
FFix2 = find(FFix)+1;

try
    FF.isi = cellfun(@str2num, data.ISInt(FFix));
    FF.side = cellfun(@(y) strcmp(y, '1'), data.stimSide(FFix));
catch
    FF.isi = data.ISInt(FFix);
    FF.side = data.stimSide(FFix) == 1;
end

FF.ans = cellfun(@(y) strcmp(y, '77'), data.key_press(FFix2)); % 
if block == 1
    FF.cond = [zeros(240,1) ; ones(240,1)];
else
    FF.cond = [ones(240,1) ; zeros(240,1)];
end
FF.nTrial = 40; % trials x cond

unique_isi = unique(FF.isi);
for i= 1:length(unique_isi)
    p_correct(1,i)= mean(FF.ans(FF.cond == 0 & FF.isi == unique_isi(i)));
    p_correct(2,i)= mean(FF.ans(FF.cond == 1 & FF.isi == unique_isi(i)));
    p_correct(3,i)= mean(FF.ans(FF.isi == unique_isi(i)));
end

FF.data = p_correct;
FF.ISI = 0:5;
