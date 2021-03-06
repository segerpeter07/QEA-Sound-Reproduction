function correct = eigenvoice(dataset, voice_num)
    load(dataset)
    load names.mat
    
%     equalized1 = preprocessing(dataset, 1);
%     equalized2 = preprocessing(dataset, 2);
%     equalized3 = preprocessing(dataset, 3);

    equalized1 = trial_1;
    equalized2 = trial_2;
    equalized3 = trial_3;

    % comment this if you don't want to have fft
    fft_equalized1 = abs(fft(equalized1));
    fft_equalized2 = abs(fft(equalized2));
    fft_equalized3 = abs(fft(equalized3));
    fft_equalized = [fft_equalized1, fft_equalized2, fft_equalized3];

    equalized = [equalized1, equalized2, equalized3];

    Names = [Names; Names; Names];
    % randomly generate a number for testing purpose
%     voice_num = randi(size(fft_equalized,2), 1)
%    voice_num = 3;

    voice_data = fft_equalized(:, voice_num);
    

    % generate reduced train and reduced test voice files
    % In other words, have PCA done
%     [Reduced_Train, Reduced_Test] = voice_reduced(fft_equalized, voice_num);
    fft_eq_test_removed = [fft_equalized(:, 1:voice_num - 1), fft_equalized(:, voice_num + 1: end)];
    test_name = Names(voice_num);
    %Names = [Names(1:voice_num - 1, :); Names(voice_num + 1:end, :)];
    [Reduced_Train, Reduced_Test] = voice_reduced(fft_eq_test_removed, voice_data);

    ans_matrix = eye(min(size(trial_1)));
    
    % returns index of the identified voice file
    [index] = calculate_difference(Reduced_Train, Reduced_Test);
    
    save('voice_guesses.mat', 'Names', 'Reduced_Train');



    
    % plots!
    subplot(2,2,1); 
    plot(equalized(:,voice_num));
    title(strcat('Recognized person is... ', test_name));


    subplot(2,2,2);
    plot(fft_equalized(:,voice_num));
    title('Recognized Voice(FFT)');

    subplot(2,2,3); 
    plot(equalized(:,index));
    name_train = Names(index);
    title(strcat('This person is... ',name_train));

    subplot(2,2,4);
    plot(fft_equalized(:,index));
    title('Test Result(FFT)');
    
%     sound(equalized(:,voice_num), Fs);
%     pause(1);
%     sound(equalized(:, index), Fs);

    correct = strcmp(test_name, name_train);

    % calculating accuracy
    % accuracy = zeros(1,50);
    % for i = 1:90
    %     [Reduced_Train, Reduced_Test] = voice_reduced(equalized, i);
    %     [index] = calculate_difference(Reduced_Train, Reduced_Test);
    %     if index == i
    %         accuracy(i) = 1;
    %     end
    % end
    % 
    % accuracy = sum(accuracy) / 90;
end
