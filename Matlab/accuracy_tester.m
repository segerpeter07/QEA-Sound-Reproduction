clear;

dataset = 'dataset_3.mat';
total = 0;
test_num = 90;
prep_done = 0;
percent_done = 0;
subplot(3, 1, 2);
plot_percentage_bar(percent_done, 'Accuracy testing', 'r');
subplot(3, 1, 1);
plot_percentage_bar(prep_done, 'Preprocessing', 'b');
subplot(3, 1, 3);
plot_percentage_bar(0, 'Cumulative accuracy', 'g');
drawnow;

subplot(3, 1, 1);
trial_1 = preprocessing(dataset, 1);
prep_done = 33.3;
plot_percentage_bar(prep_done, 'Preprocessing','b');
drawnow;
trial_2 = preprocessing(dataset, 2);
prep_done = 66.6;
plot_percentage_bar(prep_done, 'Preprocessing','b');
drawnow;
trial_3 = preprocessing(dataset, 3);
prep_done = 100;
plot_percentage_bar(prep_done, 'Preprocessing','b');
drawnow;

save(['filtered_' dataset], 'trial_1', 'trial_2', 'trial_3');

for i = 1:test_num
    c = eigenvoice_test(['filtered_' dataset], i);
    total = total + c;
    percent_done = i/test_num*100;
    subplot(3, 1, 1);
    plot_percentage_bar(prep_done, 'Preprocessing','b');
    subplot(3, 1, 2);
    plot_percentage_bar(percent_done, 'Accuracy testing', 'r');
    subplot(3, 1, 3);
    plot_percentage_bar(total/i*100, 'Cumulative accuracy', 'g');
    drawnow;
end

accuracy = total/test_num