%Single Value Decomposition's largest eigenvalues and eigenvectors
function [lambda, v] = single_value_decomp(voices,num)
    [U, S, ~] = svd(voices, 'econ');
    eigenvalues = diag(S); 
    lambda = eigenvalues(3:num);
    v = U(:,3:num);
end