function scores = getSPQ(data)

SPQ_ix = strcmpi(data.isSPQ, 'true');
SPQ_data_raw = data.responses(SPQ_ix);
SPQ_data = [];
i = 1;
for i_page = 1:length(SPQ_data_raw)
    page = jsondecode(SPQ_data_raw{i_page});
    for i_q = 1:length(fieldnames(page))
        switch eval(['page.Q' num2str(i_q-1)])
            case 'No'
                SPQ_data(i) = 0;
            case 'Yes'
                SPQ_data(i) = 1;
        end
        i=i+1;
    end     
end

scores.total = sum(SPQ_data);

%% subscales

subscale_ix{1} = [1 10 19 28 37 45 53 60 63]; % Ideas od Reference
subscale_ix{2} = [2 11 20 29 38 46 54 71]; % Excessive Social Anxiety
subscale_ix{3} = [3 12 21 30 39 47 55]; % Odd Beliefs or Magical Thinking
subscale_ix{4} = [4 13 22 31 40 48 56 61 64]; % Unusual Perceptual Experiences
subscale_ix{5} = [5 14 23 32 67 70 74]; % Odd or Eccentric Behavior
subscale_ix{6} = [6 15 24 33 41 49 57 62 66]; % No Close Friends
subscale_ix{7} = [7 16 25 34 42 50 58 69 72]; % Odd Speech
subscale_ix{8} = [8 17 26 35 43 51 66 73]; % Constricted Affect
subscale_ix{9} = [9 18 27 36 44 52 59 65]; % Suspiciousness
subscale.ix = subscale_ix;

subscale.label{1} = 'Ideas od Reference';
subscale.label{2} = 'Excessive Social Anxiety';
subscale.label{3} = 'Odd Beliefs or Magical Thinking';
subscale.label{4} = 'Unusual Perceptual Experiences';
subscale.label{5} = 'Odd or Eccentric Behavior';
subscale.label{6} = 'No Close Friends';
subscale.label{7} = 'Odd Speech';
subscale.label{8} = 'Constricted Affect';
subscale.label{9} = 'Suspiciousness';

for i_sub = 1:length(subscale_ix)
    subscale.value(i_sub) = sum(SPQ_data(subscale_ix{i_sub}));
end

scores.sub = subscale;

%% components

component_ix{1} = [1, 3, 4, 9];
component_ix{2} = [7, 5];
component_ix{3} = [2, 6, 8, 9];
component.ix = component_ix;

component.label{1} = 'Cognitive-Perceptual';
component.label{2} = 'Disorganization';
component.label{3} = 'Interpersonal';

for i_comp = 1:length(component_ix)
    component.value(i_comp) = sum(subscale.value(component_ix{i_comp}));
end

scores.comp = component;
