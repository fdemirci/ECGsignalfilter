clc ;
close all;
clear all;
%% plot ECGsignal
load('100m.mat');
ECGsignal = (val)/200;
Fs =360;
figure,plot(ECGsignal)
%% magnitude spectrum of the signal
X_mag = abs(fft(ECGsignal));
figure,plot(X_mag);
xlabel ('DFT Bins')
ylabel ( 'Magnitude ')
%% plot first half of DFT (normalized frequency)
num_bins = length(X_mag);
figure,plot ([0:1/(num_bins/2-1):1],X_mag(1:num_bins/2))
xlabel ('normalized frequency')
ylabel ( 'Magnitude ')
%% butterworth design
[b a] = butter(2, 0.3 , 'low');
%% plot the frequency responce (normalized frequency)
H = freqz(b,a,floor(num_bins/2));
figure,plot([0:1/(num_bins/2-1):1],abs(H),'r')
%% filter the signal using the b and a coeffiecients obtained from 
% the butter filter design function
x_filtered = filter(b,a,ECGsignal);
figure,plot(x_filtered)
title ('Filtered Signal - Using Second order Butterworth')
xlabel('Samples')
ylabel('Amplitude')




