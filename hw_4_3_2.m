clear;
close all;
clc;

dir = "./图像处理所需资源/";
lxb = imread(strcat(dir, "lxb.jpg"));
size(lxb)
load('train_standard.mat');
