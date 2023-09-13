clear;
close all;
clc;

load("jpegcode.mat");

dir = "./图像处理所需资源/";
load(strcat(dir, "hall.mat"));
load(strcat(dir, "JpegCoeff.mat"));

% decode dc
dc_decode = get_dc_decode(dc_code, DCTAB);

% decode ac
% [1, 10, 3, 0, 0, 2, zeros(1, 20), 1, zeros(1, 37)]
% test_ac_code = [1 0 1 1 1 0 1 0 0 1 1 1 1 1 1 1 1 0 0 0 1 0 1 1 1 1 1 1 1 1 0 0 1 1 1 1 0 1 1 1 1 0 1 0];
ac_decode = get_ac_decode(ac_code, ACTAB);
