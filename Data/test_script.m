clear;

%   Set parameters here
sample_length = 9;     %   Length of each sound sample in s
slice_length = 0.1;     %   Length of each slice in s
num_slices = 2*sample_length/slice_length - 1;
n2sr = 0.5;             %   Noise to sound ratio

[data, Fs] = audioread('NASA_noisy.wav');

%   Slice the data into little bits
fft_length = length(fft(data(1:slice_length*Fs)));
sliced_data = zeros(fft_length, num_slices);
noise = sliced_data;

for i = 1:num_slices
    %   Slice it up
    start_time = round(1 + (i-1)/2*slice_length*Fs);
    end_time = start_time + slice_length*Fs - 1;
    slice = data(start_time:end_time);

    %   Add Fourier transform of slice to data matrix
    sample_freq = fft(slice);
    sliced_data(:, i) = sample_freq;
end

%   TODO actually calculate this
plot(abs(sliced_data(:, 1)));
hold on;
plot(abs(sliced_data(:, 20)));
plot(abs(sliced_data(:, 50)));
noise_vector = mean(sliced_data(:, 1:num_slices/2)');
plot(abs(noise_vector));
size(noise_vector)

%   Calculate magnitude and phase for each vector
M = abs(sliced_data);
N = abs(noise_vector)';
T = angle(sliced_data);

%   Determine expected noise spectra, and subtract from mag
%   TODO
s = size(M)
M_clean = zeros(s(1), s(2));
for iter = 1:s(2)
    M_clean(:, iter) = (1-n2sr)*M(:, iter) - n2sr*N;
end
M_clean(M_clean < 0) = 0;

%   Prepare to transfer back into time domain
cleaned_freq = M_clean.*exp(1j*T);
cleaned_time = zeros(sample_length*Fs, 1);
for i = 1:num_slices
    %   Inverse Fourier transform
    time_domain = ifft(cleaned_freq, i);

    %   Stitch slices together
    offset = round((i-1)/2*slice_length*Fs + 1);
    td_size = size(time_domain);
    end_time = offset + td_size(1) - 1;
    size(time_domain);
    size(cleaned_time(offset:end_time));
    cleaned_time(offset:end_time, i) = cleaned_time(offset:end_time, i)+time_domain;
end

cleaned_time = cleaned_time/2;

unprocessed = data;
processed = abs(cleaned_time);
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



