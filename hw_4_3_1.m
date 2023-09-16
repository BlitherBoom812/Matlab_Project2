clear;
close all;
clc;


dir = "./图像处理所需资源/";
face_dir = strcat(dir, "Faces/");
subplot(3, 1, 1);
v = train_standard(face_dir, 3);
plot(v);
subplot(3, 1, 2);
v = train_standard(face_dir, 4);
plot(v);
subplot(3, 1, 3);
v = train_standard(face_dir, 5);
plot(v);
save("train_standard.mat", "v", '-mat');