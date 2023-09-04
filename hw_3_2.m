clear;
close all;
clc;
dir = "./图像处理所需资源/";
load(strcat(dir, "hall.mat"));
subplot(1, 3, 1);
imshow(hall_color);
imwrite(hall_color, 'hw3_2_hall_color.bmp');

[height, width, ~] = size(hall_color);

% circle
radius_sqrd = (min(height, width)/2)^2;
distance_sqrd = repmat(([1:height]' - height / 2).^2, 1, width) + repmat(([1:width] - width / 2).^2, height, 1);
circle = distance_sqrd <= radius_sqrd & distance_sqrd > 0.96 * radius_sqrd;

% red
hall_red = hall_color(:, :, 1);
hall_red(circle) = uint8(255);

% blue, green
hall_green = hall_color(:, :, 2);
hall_green(circle) = uint8(0);
hall_blue = hall_color(:, :, 3);
hall_blue(circle) = uint8(0);

% draw circle
hall_circle = uint8(ones(height, width, 3));
hall_circle(:, :, 1) = hall_red;
hall_circle(:, :, 2) = hall_green;
hall_circle(:, :, 3) = hall_blue;
subplot(1, 3, 2);
imshow(hall_circle);
imwrite(hall_circle, 'hw3_2_hall_circle.bmp');

% chessboard
length = 36;
height_index = repmat([1:height]', 1, width);
width_index = repmat([1:width], height, 1);
chessboard = xor((mod(height_index, length) < length/2), (mod(width_index, length) < length/2));

% red
hall_red = hall_color(:, :, 1);
hall_red(chessboard) = uint8(0);

% green
hall_green = hall_color(:, :, 2);
hall_green(chessboard) = uint8(0);

% blue
hall_blue = hall_color(:, :, 3);
hall_blue(chessboard) = uint8(0);

% draw circle
hall_chessboard = uint8(ones(height, width, 3));
hall_chessboard(:, :, 1) = hall_red;
hall_chessboard(:, :, 2) = hall_green;
hall_chessboard(:, :, 3) = hall_blue;
subplot(1, 3, 3);
imshow(hall_chessboard);
imwrite(hall_chessboard, 'hw3_2_hall_chessboard.bmp');
