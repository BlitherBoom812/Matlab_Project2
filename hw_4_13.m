clear;
close all;
clc;

dir = "./图像处理所需资源/";
load(strcat(dir, "snow.mat"));
load(strcat(dir, "JpegCoeff.mat"));

% encode & decode
[jpeg_row, jpeg_col, dc_code, ac_code] = my_encode(snow, QTAB, DCTAB, ACTAB);
snow_recovered = my_decode(jpeg_row, jpeg_col, dc_code, ac_code, QTAB, DCTAB, ACTAB);
% plot
subplot(2, 1, 1);
imshow(snow);
imwrite(snow, "hw_4_13_snow.bmp");
title('original')
subplot(2, 1, 2);
imshow(snow_recovered);
imwrite(snow_recovered, "hw_4_13_snow_recovered.bmp");
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
MSE = sum((double(snow_recovered) - double(snow)).^2, 'all') / (jpeg_row * jpeg_col);
PSNR = 10* log10(255^2 / MSE);
fprintf("PSNR: %f\n", PSNR);