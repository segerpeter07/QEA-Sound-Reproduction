clear all
load cleaned_dataset_1.mat
load names.mat

% comment this if you don't want to have fft
fft_equalized1 = abs(fft(equalized1));
fft_equalized2 = abs(fft(equalized2));
fft_equalized3 = abs(fft(equalized3));
fft_equalized = [fft_equalized1, fft_equalized2, fft_equalized3];

equalized = [equalized1, equalized2, equalized3];

Names = [Names, Names, Names];
% randomly generate a number for testing purpose
voice_num = randi(size(fft_equalized,2), 1);

% generate reduced train and reduced test voice files
% In other words, have PCA done
[Reduced_Train, Reduced_Test] = voice_reduced(fft_equalized, voice_num);

% returns index of the identified voice file
[index] = calculate_difference(Reduced_Train, Reduced_Test);


% plots!
subplot(2,2,1); 
plot(equalized(:,voice_num));
title(strcat('Recognized person is... ', Names(voice_num)));
sound(equalized(:,voice_num), Fs)

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
