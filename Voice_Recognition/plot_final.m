load example_cleaned_dataset.mat
load names.mat
% randomly generate a number for testing purpose
voice_num = randi(size(equalized,2), 1);

% generate reduced train and reduced test voice files
% In other words, have PCA done
[Reduced_Train, Reduced_Test] = voice_reduced(equalized, voice_num);

% returns index of the identified voice file
[index] = calculate_difference(Reduced_Train, Reduced_Test);



% plots!
subplot(2,1,1); 
plot(equalized(:,voice_num));
title('Recognized Voice');
sound(equalized(:,voice_num), Fs)

pause(2)

subplot(2,1,2); 
plot(equalized(:,index));
name_train = Names(index);
title(strcat('This person is... ',name_train));
sound(equalized(:,voice_num), Fs)

% calculating accuracy
accuracy = 0;
for i = 1:size(equalized,2)
    [Reduced_Train, Reduced_Test] = voice_reduced(equalized, i);
    [index] = calculate_difference(Reduced_Train, Reduced_Test);
    if index == i
        accuracy = accuracy + 1;
    end
end

accuracy = accuracy / size(equalized,2);
