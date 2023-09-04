clear;
close all;
clc;
dir = "./图像处理所需资源/";
load(strcat(dir, "hall.mat"));
imshow(hall_color);
imwrite(hall_color, 'hw3_1_3_2_hall.bmp');

