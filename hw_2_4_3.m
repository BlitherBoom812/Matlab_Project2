clear;
close all;
clc;

dir = "./图像处理所需资源/";
load(strcat(dir, "hall.mat"));

subplot(1, 3, 1);
imshow(hall_gray);
imwrite(hall_gray, "hw_2_4_3_normal.bmp");

dct2P = double(hall_gray);

dct2C = blockproc(dct2P, [8, 8], @(blk) dct2C_cut_right(blk.data - 128));
idct2P_cut_right = uint8(blockproc(dct2C, [8, 8], @(blk) idct2(blk.data) + 128));

subplot(1, 3, 2);
imshow(idct2P_cut_right);
imwrite(idct2P_cut_right, "hw_2_4_3_right_cut_off.bmp");

dct2C = blockproc(dct2P, [8, 8], @(blk) dct2C_cut_left(blk.data - 128));
idct2P_cut_left = uint8(blockproc(dct2C, [8, 8], @(blk) idct2(blk.data) + 128));

subplot(1, 3, 3);
imshow(idct2P_cut_left);
imwrite(idct2P_cut_left, "hw_2_4_3_left_cut_off.bmp");


function dct2C = dct2C_cut_right(dct2P)
    dct2C = dct2(dct2P);
    dct2C(:, 5:8) = 0;
end

function dct2C = dct2C_cut_left(dct2P)
    dct2C = dct2(dct2P);
    dct2C(:, 1:4) = 0;
end