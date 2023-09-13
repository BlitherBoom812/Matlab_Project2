clear;
close all;
clc;

dir = "./图像处理所需资源/";
load(strcat(dir, "hall.mat"));
load(strcat(dir, "JpegCoeff.mat"));

QTAB = QTAB / 2;
% encode & decode
[jpeg_row, jpeg_col, dc_code, ac_code] = my_encode(hall_gray, QTAB, DCTAB, ACTAB);
hall_gray_recovered = my_decode(jpeg_row, jpeg_col, dc_code, ac_code, QTAB, DCTAB, ACTAB);
% plot
subplot(2, 1, 1);
imshow(hall_gray);
title('original')
subplot(2, 1, 2);
imshow(hall_gray_recovered);
imwrite(hall_gray_recovered, "hw_4_11_hall_gray_recoverd.bmp");
title('decoded');
% 压缩比
ac_size = length(ac_code);
dc_size = length(dc_code);
fprintf("row = %d, col = %d, ac_size = %d, dc_size = %d\n", jpeg_row, jpeg_col, ac_size, dc_size);

before_size = jpeg_row * jpeg_col;
after_size = (ac_size + dc_size) / 8;

fprintf("压缩前：%d Bytes\n", before_size);
fprintf("压缩后：%f Bytes\n", after_size);
fprintf("压缩比：%f\n", before_size / after_size);
% PSNR
MSE = sum((double(hall_gray_recovered) - double(hall_gray)).^2, 'all') / (jpeg_row * jpeg_col);
PSNR = 10* log10(255^2 / MSE);
fprintf("PSNR: %f\n", PSNR);