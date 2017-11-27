function filtered = filter_speech_freq(y, fs)
    %   Takes data in frequency domain and applies band pass filter

    %   Determine the length of audio sample, in seconds
    s_len = length(y)/fs;
    
    %   Parameters for band pass filter
    high_freq = 12000;
    low_freq = 500;
    noise_weight = 0.05;    %   Factor of noise reduction; 0 is total
    
    %   Perform ideal band pass filter
    freq(high_freq:s_len*fs-high_freq) = freq(high_freq:s_len*fs-high_freq)*noise_weight;
    freq(1:low_freq) = freq(1:low_freq)*noise_weight;
    freq(end - low_freq:end) = freq(end - low_freq:end)*noise_weight;
    
    %   Return filtered audio data
    filtered = freq;
    
end
