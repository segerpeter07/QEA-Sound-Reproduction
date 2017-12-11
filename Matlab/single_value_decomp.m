%Single Value Decomposition's largest eigenvalues and eigenvectors
function [lambda, v] = single_value_decomp(voices,num)
    [U, S, V] = svd(voices);
    eigenvalues = diag(S); 
    lambda = eigenvalues(1:num);
    v = V(:, 1:num);
end