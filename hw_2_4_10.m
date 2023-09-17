clear;
close all;
clc;

load("jpegcode.mat");

ac_size = length(ac_code);
dc_size = length(dc_code);
fprintf("row = %d, col = %d, ac_size = %d, dc_size = %d\n", jpeg_row, jpeg_col, ac_size, dc_size);

before_size = jpeg_row * jpeg_col;
after_size = (ac_size + dc_size) / 8;

fprintf("压缩前：%d Bytes\n", before_size);
fprintf("压缩后：%f Bytes\n", after_size);
fprintf("压缩比：%f\n", before_size / after_size);