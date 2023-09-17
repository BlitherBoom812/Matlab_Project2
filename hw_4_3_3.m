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
test_rot90 = rot90(test);
wrap(test_rot90, v, L, 0.6, 4, 'rot90');


subplot(3, 1, 2);
[v, L] = train_standard(face_dir, 3);
test_scaledw2 = imresize(test, [size(test, 1), size(test, 2)*2]);
wrap(test_scaledw2, v, L, 0.6, 4, 'scaledw2');


subplot(3, 1, 3);
[v, L] = train_standard(face_dir, 3);
test_light = imadjust(test, [0.2 0.8]);
wrap(test_light, v, L, 0.6, 4, 'light');



function wrap(pic, v, L, ths, min_face_size, suffix)
    squared_pic = detect_faces(pic, v, L, ths, min_face_size);
    draw(squared_pic, L, ths, min_face_size, suffix);
end

function draw(pic, L, ths, min_face_size, suffix)
    imshow(pic);
    imwrite(pic, sprintf("hw_4_3_3_squared_pic_L_%s_%s.bmp", mat2str(L), suffix));
    title(sprintf("L = %s, ths = %s, min face size = %s", mat2str(L), mat2str(ths), mat2str(min_face_size)));
end
