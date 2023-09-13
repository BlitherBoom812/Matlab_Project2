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

