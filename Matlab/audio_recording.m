recorder1 = audiorecorder(44100,16,1,-1); 
record(recorder1);
disp('Start speaking.')
pause(3);
disp('End of Recording.');
stop(recorder1);
pause(2);
play(recorder1);
y = getaudiodata(recorder1);
x = fft(y);
plot(y);
