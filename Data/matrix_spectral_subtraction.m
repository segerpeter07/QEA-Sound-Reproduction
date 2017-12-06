function processed = matrix_spectral_subtraction(data, room_noise, Fs)
    %   Data: columns are voice samples
    %   Room_noise: columns are noise samples corresponding to the data
    %       samples
    %   Fs: Sampling rate, Hz
    
    sd = size(data);
    srn = size(room_noise);
    min_length = min(sd(1), srn(1));
    min_width = min(sd(2), srn(2));
    
    %   Applies spectral subtraction and constructs matrix
    processed = zeros(min_length, min_width);
    for i = 1:min_width
        processed(:, i) = spectral_subtraction(data(:, i), room_noise(:, i), Fs);
    end
end