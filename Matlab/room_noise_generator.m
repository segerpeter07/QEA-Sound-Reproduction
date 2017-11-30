clear
load('dataset_1.mat');

smallest = 132096;

for i = 1:size(trial_1, 2)
     for j = 1:size(trial_1, 1)
         if(trial_1(j,i) > 0.1)
             if(j < smallest)
                 smallest = j;
             end
         end
     end
end


smallest_2 = 1;

for i = 1:size(trial_1, 2)
    j = size(trial_1,1);
    while trial_1(j,i) < 0.1
        j = j - 1;
    end
    
    if(j > smallest_2)
        smallest_2 = j;
    end
end


room_noise = [];

for i = 1:size(trial_1,2)
    app = trial_1(:,i);
    room_noise = [room_noise app(1:smallest)];
end

room_noise_2 = [];
for i = 1:size(trial_1,2)
    app = trial_1(:,i);
    room_noise_2 = [room_noise_2 app(smallest_2:end)];
end





room_noise_3 = [];

% ----- Find largest for array sizing ------
peg1 = 132096;
peg2 = 1;
largest = 1;
for i = 1:size(trial_1, 2)
    % Get begining sample
     for j = 1:size(trial_1, 1)
         if(trial_1(j,i) > 0.1)
             if(j < peg1)
                 peg1 = j;
             end
         end
     end

    % Get end sample
    j = size(trial_1,1);
    while trial_1(j,i) < 0.1
        j = j - 1;
    end
    if(j > peg2)
        peg2 = j;
    end
    
    % Chose largest value
    if(peg1 > peg2) 
        if(peg1 > largest)
            largest = peg1;
        end
    else
        if(peg2 > largest)
            largest = peg2;
        end
    end
end

% ----- fill array with data and zeros to allow concatination -----
peg1 = 132096;
peg2 = 1;
for i = 1:size(trial_1, 2)
    % Get begining sample
     for j = 1:size(trial_1, 1)
         if(trial_1(j,i) > 0.1)
             if(j < peg1)
                 peg1 = j;
             end
         end
     end

    % Get end sample
    j = size(trial_1,1);
    while trial_1(j,i) < 0.1
        j = j - 1;
    end
    if(j > peg2)
        peg2 = j;
    end
    
    app = trial_1(:,i);
    t1 = app(1:peg1);
    t2 = app(peg2:2);
    
    %Compare size and choose larger sample
    if(size(t1,1) > size(t2,1))
        if(size(t1,1) ~= largest)
            t1 = cat(1,t1,zeros(largest-size(t1,1),1));
        end
        room_noise_3 = [room_noise_3 t1];
    else
        if(size(t2,1) ~= largest)
            t2 = cat(1,t2,zeros(largest-size(t2,1),1));
        end
        room_noise_3 = [room_noise_3 t2];
    end
end

save('room_noise_sample.mat','room_noise_3','Fs');