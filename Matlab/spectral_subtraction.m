clear;
load example_cleaned_dataset.mat;

%   Set parameters here
sample_length = 0.5;     %   Length of each sound sample in s
slice_length = 0.01;     %   Length of each slice in s
num_slices = 2*sample_length/slice_length - 1;
noise_sample = 4;
n2sr = 0.5;             %   Noise to sound ratio
test_num = 7;           %   Sample to test

%   Process data
eq_size = size(equalized);
num_samples = eq_size(2);
data = equalized(1:sample_length*Fs, :);    %   Cut to sample length

%   Slice the data into little bits
fft_length = length(fft(data(1:slice_length*Fs, 1)));
sliced_data = zeros(fft_length, num_slices, num_samples);
noise = sliced_data;

for s = 1:num_samples
    %   Cycle through samples
    sample = data(:, s);
    
    for i = 1:num_slices
        %   Slice it up
        start_time = round(1 + (i-1)/2*slice_length*Fs);
        end_time = start_time + slice_length*Fs - 1;
        slice = sample(start_time:end_time);
        
        %   Add Fourier transform of slice to data matrix
        sample_freq = fft(slice);
        sliced_data(:, i, s) = sample_freq;
        
    end
end

for s = 1:num_samples
    %   TODO actually calculate this
    noise_vector = mean(sliced_data(:, :, noise_sample));
    noise(:, :, s) = sliced_data(:, :, noise_sample);
    size(noise_vector)
end

%   Calculate magnitude and phase for each vector
M = abs(sliced_data);
T = angle(sliced_data);

%   Determine expected noise spectra, and subtract from mag
%   TODO
M_clean = (1-n2sr)*M - n2sr*abs(noise);
M_clean(M_clean < 0) = 0;

%   Prepare to transfer back into time domain
cleaned_freq = M_clean.*exp(1j*T);
cleaned_time = zeros(sample_length*Fs, num_samples);

for s = 1:num_samples
    %   Cycle through samples
    sample = cleaned_freq(:, :, s);
    
    for i = 1:num_slices
        %   Inverse Fourier transform
        time_domain = ifft(sample(:, i));
        
        %   Stitch slices together
        offset = round((i-1)/2*slice_length*Fs + 1);
        td_size = size(time_domain);
        end_time = offset + td_size(1) - 1;
        size(time_domain);
        size(cleaned_time(offset:end_time, s));
        cleaned_time(offset:end_time, s) = cleaned_time(offset:end_time, s)+time_domain;
    end
end

cleaned_time = cleaned_time/2;

unprocessed = data(:, test_num);
processed = real(cleaned_time(:, test_num));
sound(unprocessed/max(unprocessed)*0.75, Fs);
pause(0.75)
sound(processed/max(processed)*0.75, Fs);

%   Visualize audio samples
size(sliced_data(:, :, 1))
for i = 1:5
    subplot(2, 5, i);
    imagesc(M(1:round(fft_length/2), :, i))
    ylim([0, 60])
end

for i = 6:10
    subplot(2, 5, i);
    M_clean(:, :, 1);
    imagesc(M_clean(1:round(fft_length/2), :, i-5))
    ylim([0, 60])
end

xlabel('Time (slices of 5ms)')
ylabel('Frequency (units screwy)')



