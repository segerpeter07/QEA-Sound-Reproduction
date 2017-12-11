% Creating mean centered data function 
function [mean_entire_data, mean_centered_data] = mean_centered(voice)
    mean_entire_data = mean(voice')';
    sv = size(voice);
    mean_centered_data = zeros(size(voice));
    for i = 1:sv(2)
        mean_centered_data(:, i) = voice(:, i) - mean_entire_data;
    end


%     mean_entire_data = ones(1,length(voice));
%     mean_difference = ones(size(voice,1),size(voice,2));
%     for i = 1:length(voice)
%         mean_entire_data(1,i) = mean(voice(i),2);
%         for j = 1:size(voice,2)
%         mean_difference(i,j) = mean(voice(i,j)) - mean_entire_data(1,i);
%         end
%     end
% %     o = ones(1,size(voice,2));
% %     mean_difference = mean(voice,2)*o;
%     mean_centered_data = voice-mean_difference;
end