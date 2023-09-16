clear;
close all;
clc;

dir = "./图像处理所需资源/";
load(strcat(dir, "hall.mat"));
load(strcat(dir, "JpegCoeff.mat"));

value_hide = [1, 0, 1, 0, 1, 1, 0, 1, 1]; 
disp(['原数据：', mat2str(value_hide(1:length(value_hide)))]);

pic = hall_gray;
pic_hide = space_hide(value_hide, pic);
value_show = space_show(pic_hide);
disp(['解码结果：', mat2str(value_show(1:length(value_hide)))]);

[jpeg_row, jpeg_col, dc_code, ac_code] = my_encode(pic_hide, QTAB, DCTAB, ACTAB);
jpeg_decode = my_decode(jpeg_row, jpeg_col, dc_code, ac_code, QTAB, DCTAB, ACTAB);
value_show_jpeg = space_show(jpeg_decode);
disp(['压缩后解码：', mat2str(value_show_jpeg(1:length(value_hide)))]);

correct = 0;
for k=1:length(value_hide)
    if value_hide(k) == value_show_jpeg(k)
        correct = correct + 1;
    end
end

disp(['正确率：', mat2str(correct / length(value_hide))]);

subplot(3, 1, 1);
imshow(pic);
title("original picture");
imwrite(pic, "hw_3_4_1_pic.bmp");
subplot(3, 1, 2);
imshow(pic_hide);
title("hide picture");
imwrite(pic_hide, "hw_3_4_1_pic_hide.bmp");
subplot(3, 1, 3);
imshow(jpeg_decode);
title("jpeg compressed picture");
imwrite(jpeg_decode, "hw_3_4_1_pic_compress.bmp");

function pic_hide = space_hide(value_hide, pic)
    [rows, cols] = size(pic);
    pic_hide = 0 * pic;
    value_hide = reshape(value_hide, 1, length(value_hide));
    value_hide = [value_hide, zeros(1, rows * cols - length(value_hide))];
    for k=1:rows
        for j=1:cols
            pic_hide(k, j) = floor(pic(k, j)/2) * 2 + value_hide((k-1) * cols + j);
        end
    end
end

function value = space_show(pic_hide)
    [rows, cols] = size(pic_hide);
    value = zeros(1, rows * cols);
    for k=1:rows
        for j=1:cols
            value((k - 1) * cols + j) = mod(pic_hide(k, j), 2);
        end
    end
end