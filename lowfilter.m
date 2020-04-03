clc ;
close all;
clear all;
%% plot ECGsignal
load('100m.mat');
ECGsignal = (val)/200;
Fn = 100;
Fs =360;
figure,plot(ECGsignal)
%% plotting frequency spectrum
x_fft = fft(ECGsignal);
L = length(ECGsignal);
P2 = abs(x_fft/L);
P1 = P2(1:L/2+1);
P1(2:end-1) = 2*P1(2:end-1);
f = Fs*(0:(L/2))/L;
figure,plot(f,P1,"r")
%% plotting DTFT plot
N = length(ECGsignal);
k = 0:N-1;
w = 2*pi*k/N;
figure, plot (w/pi,abs(ECGsignal))
%% Low-Pass filter
[b1 a1] = cheby2(2,50,50/Fn); % cutoff freq. 50Hz
low_filter_tf = tf(b1,a1,1/Fs);
figure,freqz(b1,a1)
title 'Low pass filter frequency response'
figure,zplane(b1,a1)
title 'Low pass filter pole-zero map'

x = filtfilt(b1,a1,ECGsignal);
figure,plot(x)
title 'Filtered Signal- LowPass Filter'
xlabel 'Samples'
ylabel 'Amplitude'

%% High Pass Filter
[b2 a2] = butter(2,5/Fn,'high'); %cutoff freq 5
high_filter_tf = tf(b2,a2,1/Fs);
figure,freqz(b2,a2)
title 'High pass filter frequency response'
figure,zplane(b2,a2)
title 'High pass filter pole-zero map'
y = filtfilt(b2,a2,x);
figure,plot(y)
title 'Filtered Signal- HighPass Filter'
xlabel 'Samples'
ylabel 'Amplitude'
%% plotting Final frequency spectrum
y_fft = fft(y);
L1 = length(y);
P22 = abs(y_fft/L1);
P11 = P22(1:L1/2+1);
P11(2:end-1) = 2*P11(2:end-1);
f1 = Fs*(0:(L1/2))/L1;
figure,plot(f1,P11,"r")
