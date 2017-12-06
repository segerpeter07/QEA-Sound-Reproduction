function [index] = calculate_difference(Reduced_Train, Reduced_Test)

% Calculate the difference between weights of training / test
w_test = repmat(Reduced_Test,1,size(Reduced_Train,2));
difference = w_test - Reduced_Train;
distances = (sum(difference.^2)).^0.5;

% find the minimum distance
minDis = min(distances);

% find the index of the minimum distance value
index = find(distances==minDis,1); 


end
