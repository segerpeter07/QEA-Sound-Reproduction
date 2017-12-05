function res = preprocessing(dataset, trial)
    load(dataset);

    room_noise = room_noise_generator(dataset, trial);
    % INSERT SPECTRUM SUBTRACTION METHOD HERE
    filtered = band_pass_filter(dataset, trial);
    equalized = equalize_length(filtered, Fs);
    
    res = equalized; 
end