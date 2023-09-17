clear all;
close all; 
clc;

dir = "./图像处理所需资源/";
load(strcat(dir, "hall.mat"));

subplot(1, 4, 1);
imshow(hall_gray);
imwrite(hall_gray, "hw_2_4_4_normal.bmp");

dct2P = double(hall_gray);

idct2C_hall_transpos = my_dct_domain_process(dct2P, @my_dct2_transposition);

subplot(1, 4, 2);
imshow(idct2C_hall_transpos);
imwrite(idct2C_hall_transpos, "hw_2_4_4_hall_transpos.bmp");

idct2C_hall_rotate90 = my_dct_domain_process(dct2P, @my_dct2_rotate90);

subplot(1, 4, 3);
imshow(idct2C_hall_rotate90);
imwrite(idct2C_hall_rotate90, "hw_2_4_4_hall_rotate90.bmp");

idct2C_hall_rotate180 = my_dct_domain_process(dct2P, @my_dct2_rotate180);

subplot(1, 4, 4);
imshow(idct2C_hall_rotate180);
imwrite(idct2C_hall_rotate180, "hw_2_4_4_hall_rotate180.bmp");

function idct2C = my_dct_domain_process(dct2P, dct2_process)
    dct2C = blockproc(dct2P, [8, 8], @(blk) dct2_process(blk.data - 128));
    idct2C = uint8(blockproc(dct2C, [8, 8], @(blk) idct2(blk.data) + 128));
end


function dct2C = my_dct2_transposition(dct2P)
    dct2C = dct2(dct2P');
end


function dct2C = my_dct2_rotate90(dct2P)
    dct2C = rot90(dct2(dct2P));
end


function dct2C = my_dct2_rotate180(dct2P)
    dct2C = rot90(dct2(dct2P), 2);
end

