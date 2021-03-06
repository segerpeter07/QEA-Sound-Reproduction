clear;
[a, Fs] = audioread('NASA_noisy.wav');
equalized = [a(1:end/2), a(end/2+1:end)];

%   Set parameters here
sample_length = 4.5;     %   Length of each sound sample in s
slice_length = 0.1;     %   Length of each slice in s
num_slices = round(2*sample_length/slice_length - 1);
noise_sample = 1;
n2sr = 0.7;             %   Noise to sound ratio
test_num = 2;           %   Sample to test

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
    size(sliced_data)
    s
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
subplot(2, 2, 1);
plot(unprocessed);
subplot(2, 2, 2);
plot(processed);
subplot(2, 2, 3);
plot(fftshift(abs(fft(unprocessed))));
subplot(2, 2, 4);
plot(fftshift(abs(fft(processed))));
sound(unprocessed/max(unprocessed), Fs);
pause(5)
sound(processed/max(processed), Fs);
