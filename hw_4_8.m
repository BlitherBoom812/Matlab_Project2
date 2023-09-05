clear all;
close all; 
clc;


dir = "./图像处理所需资源/";
load(strcat(dir, "hall.mat"));

dct2P = double(hall_gray) - 128;
dct2C = blockproc(dct2P, [8, 8], @dct2);

function Q = quantify_block(block)

end