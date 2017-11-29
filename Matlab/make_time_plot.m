function make_time_plot(x, fs)
% plot a time domain wave form for a given sampling rate
% x = waveform to be plotted
% fs = sampling rate

plot([0:length(x)-1]/fs, x);
l = sprintf('Time (s).\n sample rate of %.2f Hz assumed.', fs);
xlabel(l);
end