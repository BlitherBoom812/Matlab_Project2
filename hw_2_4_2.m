clear all;
close all;
clc;

dir = "./图像处理所需资源/";
load(strcat(dir, "hall.mat"));

example = double(hall_gray(1:8, 1:8)) - 128;
dct2C = dct2(example);
my_dct2C = my_dct2(example);
disp(max((dct2C - my_dct2C).^2, [], 'all'));