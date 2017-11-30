% Creating mean centered data function 
function mean_centered_data = mean_centered(voice)
    o = ones(1,size(voice,2));
    m = mean(voice,2)*o;
    mean_centered_data = voice-m;
end