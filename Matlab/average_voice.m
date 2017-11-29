function average = average_voice(dataset)
    % This function takes standardized data and returns the average of the
    % dataset. Before running this script, the following needs to be done
    % - Filter data
    % - Equalize Length
    
    data_1 = [];
    
    % Convert sound to frequency domain
    for i = 1:size(dataset, 2)
        data_1 = [data_1 fft(dataset(:,i))];
    end
    
    % Calculate mean voice of each dataset
    average = mean(data_1,2);

    % Convert back to time domain
    average = ifft(average);
    
end