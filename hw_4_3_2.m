clear;
close all;
clc;

dir = "./图像处理所需资源/";
face_dir = strcat(dir, "Faces/");
test = imread(strcat(dir, "awf.jpg"));

% 画图
figure;

subplot(3, 1, 1);

[v, L] = train_standard(face_dir, 3);
wrap(test, v, L, 0.6, 8);
% ths = 0.6;
% min_face_size = 8;



subplot(3, 1, 2);

[v, L] = train_standard(face_dir, 4);
wrap(test, v, L, 0.8, 8);
% ths = 0.8;
% min_face_size = 8;


subplot(3, 1, 3);

[v, L] = train_standard(face_dir, 5);
wrap(test, v, L, 0.92, 8);
% ths = 0.92;
% min_face_size = 8;



function wrap(pic, v, L, ths, min_face_size)
    squared_pic = detect_faces(pic, v, L, ths, min_face_size);
    draw(squared_pic, L, ths, min_face_size);
end

function draw(pic, L, ths, min_face_size)
    imshow(pic);
    imwrite(pic, sprintf("hw_4_3_2_squared_pic_L_%s.bmp", mat2str(L)));
    title(sprintf("L = %s, ths = %s, min face size = %s", mat2str(L), mat2str(ths), mat2str(min_face_size)));
end




