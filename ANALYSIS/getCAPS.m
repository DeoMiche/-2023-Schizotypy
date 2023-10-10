function scores = getCAPS(data)

CAPS_ix = strcmpi(data.isCAPS, 'true');
CAPS_data_raw = data.responses(CAPS_ix);
CAPS_data = [];
i = 1;
for i_page = 1:length(CAPS_data_raw)
    page = jsondecode(CAPS_data_raw{i_page});
    for i_q = 1:length(fieldnames(page))
        switch eval(['page.Q' num2str(i_q-1)])
            case 'No'
                CAPS_data(i) = 0;
            case 'Yes'
                CAPS_data(i) = 1;
        end
        i=i+1;
    end     
end

scores.total = sum(CAPS_data);

%% subscales

subscale_ix{1} = [26, 4, 32, 10, 12, 24, 2, 1, 16, 27, 6]; % temporal lobe experience
subscale_ix{2} = [30, 18, 29, 21, 14, 25, 20, 8]; % chemosensation
subscale_ix{3} = [7, 11, 3, 31]; % clinical psychosis

subscale.label{1} = 'temporal lobe experience';
subscale.label{2} = 'chemosensation';
subscale.label{3} = 'clinical psychosis';

for i_sub = 1:length(subscale_ix)
    subscale.value(i_sub) = sum(CAPS_data(subscale_ix{i_sub}));
end

scores.sub = subscale;