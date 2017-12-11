function accuracy_tester_tester(lambdas)

    accuracies = zeros(1, length(lambdas));
    for i = 1:length(lambdas)
        accuracies(i) = accuracy_tester(lambdas(i));
    end
    
    figure;
    semilogx(lambdas, accuracies);
    

end