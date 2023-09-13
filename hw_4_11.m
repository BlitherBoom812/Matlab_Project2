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
% recover image
dct2C_tilde_recovered = get_dct2C_tilde_recovered([dc_decode; ac_decode], jpeg_row * 8, jpeg_col / 8);
hall_gray_recovered = get_hall_gray_recovered(dct2C_tilde_recovered, QTAB);
subplot(2, 1, 1);
imshow(hall_gray);
subplot(2, 1, 2);
imshow(hall_gray_recovered);
imwrite(hall_gray_recovered, "hw_4_11_hall_gray_recoverd.bmp");

MSE = sum((double(hall_gray_recovered) - double(hall_gray)).^2, 'all') / (jpeg_row * jpeg_col);
PSNR = 10* log10(255^2 / MSE);
fprintf("PSNR: %f\n", PSNR);
