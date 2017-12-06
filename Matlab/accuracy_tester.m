total = 0;
test_num = 90;

for i = 1:test_num
    c = eigenvoice('dataset_8.mat', i);
    total = total + c;
    percent_done = i/test_num*100
end

accuracy = total/test_num