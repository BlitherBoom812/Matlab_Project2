clear;
close all;
clc;


dir = "./图像处理所需资源/Faces/";
subplot(3, 1, 1);
v = train_standard(dir, 3);
plot(v);
subplot(3, 1, 2);
v = train_standard(dir, 4);
plot(v);
subplot(3, 1, 3);
v = train_standard(dir, 5);
plot(v);