clear;
close all;
clc;

load("jpegcode.mat");

dir = "./图像处理所需资源/";
load(strcat(dir, "hall.mat"));
load(strcat(dir, "JpegCoeff.mat"));

hall_gray_recovered = my_decode(jpeg_row, jpeg_col, dc_code, ac_code, QTAB, DCTAB, ACTAB);

subplot(2, 1, 1);
imshow(hall_gray);
title('original')
subplot(2, 1, 2);
imshow(hall_gray_recovered);
imwrite(hall_gray_recovered, "hw_2_4_11_hall_gray_recovered.bmp");
title('decoded');

MSE = sum((double(hall_gray_recovered) - double(hall_gray)).^2, 'all') / (jpeg_row * jpeg_col);
PSNR = 10* log10(255^2 / MSE);
fprintf("PSNR: %f\n", PSNR);
