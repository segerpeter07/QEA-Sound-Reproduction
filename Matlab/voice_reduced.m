function [Reduced_Train, Reduced_Test] = voice_reduced(dataset, voice_test)

dataset = downsample(dataset, 10);
dataset = dataset(1:300, :);
voice_test = downsample(voice_test, 10);
voice_test = voice_test(1:300);

voice_train = dataset;
%voice_test = dataset(:,voice_num);

% change into value from paper
num_train = 20;

% create a covariance matrix
[data_mean, mean_centered_data_train] = mean_centered(voice_train);
mean_values = mean(mean_centered_data_train);

voice_test = voice_test - data_mean;

% for i = 1:length(mean_centered_data_train)
%     mean_centered_data_train(i, :) = mean_centered_data_train(i, :)./mean_values;
% end


%covariance_mat = mean_centered_data_train;
covariance_mat = corrcoef(mean_centered_data_train');

% SVD
[~, largest_eigenvectors_train] = single_value_decomp(covariance_mat, num_train);
size(largest_eigenvectors_train)
size(voice_test)
% Weights of Voices

Reduced_Test = largest_eigenvectors_train'*voice_test;
Reduced_Train = largest_eigenvectors_train'*voice_train;
end