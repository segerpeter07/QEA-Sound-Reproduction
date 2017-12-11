function correct = eigenvoice_test(dataset, test_num)
    
    %   Load voice data and matrix of names
    load names.mat;
    load(dataset);
    
    Names = [Names; Names; Names];
    data = [trial_1, trial_2, trial_3];
    
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
    
    %   Find eigenvectors of correlation matrix, and project data
    correlation_matrix = corrcoef(dataset_fft');
    [v, d] = eig(correlation_matrix);
    v = v(:, end-19:end)';
    d = sum(d(:, end-19:end));
    proj = v*dataset_fft;    
    test_proj = proj(:, test_num);
    
    %   Calculate distance from each voice to test voice
    sp = size(proj);
    for i=1:sp(2)
        proj(:, i) = (proj(:, i) - test_proj).^2;
    end
    values = sum(proj);
    values(values==0) = max(values) + 1;    %   Ignore test data
    
    %   Determine voice with minimum distance.
    [minimum, index] = min(values);
    
    %   Determine if voice guess was correct
    if strcmp(Names(index, :), Names(test_num, :))
        correct = 1;
    else
        correct = 0;
    end
    
end