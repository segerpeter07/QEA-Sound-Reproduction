function [Reduced_Train, Reduced_Test] = voice_reduced(dataset, voice_num)

voice_train = dataset;
voice_test = dataset(:,voice_num);


% change into value from paper
num_train = 20;

% create a covariance matrix
mean_centered_data_train = mean_centered(voice_train);


% SVD
[~, largest_eigenvectors_train] = single_value_decomp(mean_centered_data_train, num_train);

% Weights of Voices
Reduced_Train = largest_eigenvectors_train'*voice_train;
Reduced_Test = largest_eigenvectors_train'*voice_test;
end