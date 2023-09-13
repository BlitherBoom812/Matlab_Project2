clear;
close all;
clc;


dir = "./图像处理所需资源/";
load(strcat(dir, "hall.mat"));
load(strcat(dir, "JpegCoeff.mat"));

[jpeg_row, jpeg_col, dc_code, ac_code] = my_encode(hall_gray, QTAB, DCTAB, ACTAB);

save('jpegcode.mat', "jpeg_col", "jpeg_row", "ac_code", "dc_code")