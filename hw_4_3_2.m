clear;
close all;
clc;

dir = "./图像处理所需资源/";
face_dir = strcat(dir, "Faces/");

test = imread(strcat(dir, "awf.jpg"));
% load('train_standard.mat');
% [v, L] = train_standard(face_dir, 5);
[v, L] = train_standard(face_dir, 3);
% 预处理
[rows, cols, ~] = size(test);
block_size = 4;
blocklize = @(x) ceil(x/block_size) * block_size;
test_ext = [test, zeros(rows, blocklize(cols) - cols, 3)];
test_ext = [test_ext; zeros(blocklize(rows) - rows, blocklize(cols), 3)];
% 人脸检测
result = blockproc(test_ext, [block_size, block_size], @(blk) is_face(blk.data, v, L));
% 标出红框
% ths = 0.95;
% min_face_size = 3;
ths = 0.6;
min_face_size = 8;
valid = result < ths;
squares = get_all_squares(test_ext, valid, v, L, ths, min_face_size);
squared_pic_ext = blockproc(test_ext, [block_size, block_size], @(blk) make_red(blk, squares));
squared_pic = squared_pic_ext(1:rows, 1:cols, :);
% 画图
figure;
imshow(squared_pic);
imwrite(squared_pic, 'hw_4_3_2_squared_pic.bmp');





