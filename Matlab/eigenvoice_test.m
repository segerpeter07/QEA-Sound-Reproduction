function correct = eigenvoice_test(dataset, test_num, lambda)
    
    %   Load voice data and matrix of names
    load names.mat;
    load(dataset);
    
    Names = [Names; Names; Names];
    data = [trial_1, trial_2, trial_3];
    sd = size(data);
    
    %   Matrix mapping names to correct guesses
    names_to_data = [eye(sd(2)/3); eye(sd(2)/3); eye(sd(2)/3)];
    
    %   Take the Fourier transform of data
    dataset_fft = abs(fft(data));
    
    %   Find the 'average' voice, and mean-center data matrix
    mean_fft = mean(dataset_fft')';
    sdfft = size(dataset_fft);
    for i = 1:sdfft(2)
        dataset_fft(:, i) = dataset_fft(:, i) - mean_fft;
    end
    
    %   Downsample data so that MATLAB can compute it
    dataset_fft = downsample(dataset_fft, 10);
    dataset_fft = dataset_fft(1:300, :);    %   Most data is in this range
    
    %   Remove test point from training
    if (1<=test_num) && (test_num<=30)
        trial_range = 1:30;
    elseif (31 <= test_num) && (test_num <= 60)
        trial_range = 31:60;
    elseif (61 <= test_num) && (test_num <= 90)
        trial_range = 61:90;
    end
    
    dataset_fft_test_removed = dataset_fft;
    dataset_fft_test = dataset_fft(:, test_num);
    dataset_fft_test_removed(:, trial_range) = [];
    Names_test_removed = Names;
    Names_test_removed(trial_range, :) = [];
    names_to_data_test_removed = names_to_data;
    names_to_data_test_removed(trial_range, :) = [];
    
    %   Find eigenvectors of correlation matrix, and project data
    correlation_matrix = corrcoef(dataset_fft_test_removed');
    [v, d] = eig(correlation_matrix);
    v = v(:, end-19:end)';
    d = sum(d(:, end-19:end));
    proj = v*dataset_fft_test_removed;
    test_proj = v*dataset_fft(:, test_num);
    
    %   Perform liner regression on voice data
    A = dataset_fft_test_removed'\names_to_data_test_removed;
    w = inv(lambda*eye(length(dataset_fft_test)) + dataset_fft_test_removed * ...
        dataset_fft_test_removed') * dataset_fft_test_removed * names_to_data_test_removed;
    weights = w'*dataset_fft_test
    
    correct = 0;
    [maximum, index] = max(weights);
    if strcmp(Names(index, :), Names(test_num, :))
        res = [index; Names_test_removed(index, :); test_num; Names(test_num, :)]
        correct = 1;
    else
        guess = [index; Names_test_removed(index, :)]
        actual = [test_num; Names(test_num, :)]
    end
    
%     %   Calculate distance from each voice to test voice
%     sp = size(proj);
%     for i=1:sp(2)
%         proj(:, i) = (proj(:, i) - test_proj).^2;
%     end
%     values = sum(proj);
%     %values(values==0) = max(values) + 1;    %   Ignore test data
%     
%     %   Determine voice with minimum distance.
%     [minimum, index] = min(values);
%     
%     %   Determine if voice guess was correct
%     if strcmp(Names_test_removed(index, :), Names(test_num, :))
%         correct = 1;
%     else
%         correct = 0;
%     end
%     
end