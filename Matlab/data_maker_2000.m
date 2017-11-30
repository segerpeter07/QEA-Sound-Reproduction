clear
load('dataset_1.mat');
filtered = [];
for i = 1:size(trial_1,2)
    filtered = [filtered filter_speech(trial_1, Fs)];
end

equalized = equalize_length(filtered, Fs);
save('example_cleaned_dataset.mat', 'filtered', 'Fs');