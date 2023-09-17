clear;
close all; 
clc;


dir = "./图像处理所需资源/";
load(strcat(dir, "hall.mat"));
load(strcat(dir, "JpegCoeff.mat"));

dct2C_tilde = get_dct2C_tilde(hall_gray, QTAB);
dct2C_tilde_final = get_dct2C_tilde_final(dct2C_tilde);
