function res = room_noise_generator(dataset, trial)
    % This function takes in a dataset, loads it, then finds the longest
    % possible amount of room noise in each clip and returns a dataset of
    % room noise. 
    %
    % Args: dataset, trial choice
    % Returns: a dataset of room noise


    load(dataset);  % Load in dataset
    if(trial == 1)
        set = trial_1;
    elseif(trial == 2)
        set = trial_2;
    elseif(trial == 3)
        set = trial_3;
    end

    smallest = 132096;

    room_noise = [];

    % ----- Find largest for array sizing ------
    peg1 = 132096;
    peg2 = 1;
    largest = 1;
    for i = 1:size(set, 2)
        % Get begining sample
         for j = 1:size(set, 1)
             if(set(j,i) > 0.1)
                 if(j < peg1)
                     peg1 = j;
                 end
             end
         end

        % Get end sample
        j = size(set,1);
        while set(j,i) < 0.1
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
    for i = 1:size(set, 2)
        % Get begining sample
         for j = 1:size(set, 1)
             if(set(j,i) > 0.1)
                 if(j < peg1)
                     peg1 = j;
                 end
             end
         end

        % Get end sample
        j = size(set,1);
        while set(j,i) < 0.1
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
            room_noise = [room_noise t1];
        else
            if(size(t2,1) ~= largest)
                t2 = cat(1,t2,zeros(largest-size(t2,1),1));
            end
            room_noise = [room_noise t2];
        end
    end
    res = room_noise;
end