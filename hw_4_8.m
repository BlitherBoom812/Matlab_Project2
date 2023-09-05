clear all;
close all; 
clc;


dir = "./图像处理所需资源/";
load(strcat(dir, "hall.mat"));
load(strcat(dir, "JpegCoeff.mat"));

dct2P = double(hall_gray) - 128;
dct2C = blockproc(dct2P, [8, 8], @(blk) dct2(blk.data));
dct2C_tilde = blockproc(dct2C, [8, 8], @(blk) quantify_block(blk.data, QTAB));
dct2C_tilde = blockproc(dct2C_tilde, [8, 8], @(blk) zigzagScan(blk.data)');


[rows, cols] = size(dct2C_tilde);
dct2C_tilde_final = [];
for i = 1:(rows/64)
    for j = 1:cols
        if i == 1 && j == 1
            dct2C_tilde_final = dct2C_tilde(1:64, 1);
        else
            dct2C_tilde_final = [dct2C_tilde_final, dct2C_tilde((i - 1) * 64 + 1:i * 64, j)];
        end
    end
end

function Q = quantify_block(block, quantify)
    Q = round(block ./ quantify);
end