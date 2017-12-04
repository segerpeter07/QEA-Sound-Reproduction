function processed = spectral_subtraction(unprocessed, room_audio, Fs)
    %   Applies spectral subtraction to the input sample.
    %
    %   Inputs: unprocessed audio signal (column vector),
    %           noise-only audio signal (column vector),
    %           sample rate (scalar, samples per second)
    %
    %   Output: processed audio signal (column vector)
    

    ups = size(unprocessed);
    ras = size(room_audio);
    min_length = min(ups(1), ras(1));
    a = unprocessed;
    equalized = [a(1:min_length), room_audio(1:min_length)];

    %   Set parameters here
    overlap = 2;
    sample_length = min_length/Fs;     %   Length of each sound sample in s
    slice_length = 0.1;     %   Length of each slice in s
    num_slices = floor(overlap*sample_length/slice_length - 1);
    noise_sample = 2;
    n2sr = 0.7;             %   Noise to sound ratio
    test_num = 1;           %   Sample to test

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
            start_time = floor(1 + (i-1)/overlap*slice_length*Fs);
            end_time = start_time + slice_length*Fs - 1;
            slice = sample(start_time:end_time);

            %   Add Fourier transform of slice to data matrix
            sample_freq = fft(slice);
            sliced_data(:, i, s) = sample_freq;

        end
    end

    sn = size(noise);
    for s = 1:num_samples
        sliced_noise = sliced_data(:, :, noise_sample);
        noise_vector = mean(sliced_noise')';
        noise_vector = noise_vector*sum(sum(sliced_noise))/sum(noise_vector);
        for n = 1:sn(2)
            noise(:, n, s) = noise_vector;
        end
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
            offset = round((i-1)/overlap*slice_length*Fs + 1);
            td_size = size(time_domain);
            end_time = offset + td_size(1) - 1;
            size(time_domain);
            size(cleaned_time(offset:end_time, s));
            cleaned_time(offset:end_time, s) = cleaned_time(offset:end_time, s)+time_domain;
        end
    end

    cleaned_time = cleaned_time/overlap;


    unprocessed = data(:, test_num);
    processed = real(cleaned_time(:, test_num));
    subplot(2, 2, 1);
    plot(unprocessed);
    subplot(2, 2, 2);
    plot(processed);
    subplot(2, 2, 3);
    plot(room_audio);
    %subplot(2, 2, 4);
    %plot(fftshift(abs(fft(processed))));
    sound(unprocessed/max(unprocessed), Fs);
    pause(4)
    sound(processed/max(processed), Fs);
end
