clear all;
close all; 
clc;
% y(n) = -x(n) + x(n - 1)
a = [1];
b = [-1, 1];
figure;
zplane(b, a);
figure;
freqz(b, a);