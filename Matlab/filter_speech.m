function filtered = filter_speech(y, fs)
    %   Takes audio data in time domain and applies band pass filter

    %   Average audio channels
    %    y = mean(y')';
    
    %   Transfer data to frequency domain
    freq = (fft(y));

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

    %   Normalize amplitude of audio
    y2 = ifft(freq);
    y2 = y2*0.5/max(abs(y2));
    
    %   Return filtered audio data
    filtered = real(y2);
    
end
