function v = train_standard(dir, L)
    image_list = read_bmp(dir);
    u = zeros(1, power(2, 3 * L));
    for k=1:length(image_list)
        u = u + get_characteristic(image_list{k}, L);
    end
    v = u / length(image_list);
end

function u = get_characteristic(pic, L)
    [row, col, ~] = size(pic);
    u = zeros(1, power(2, 3 * L));
    for k=1:row
        for j=1:col
            n = get_n(pic(k, j, 1), pic(k, j, 2), pic(k, j, 3), L);
            u(n + 1) = u(n + 1) + 1;
        end
    end
    u = u / (row * col);
end

function n = get_n(R, G, B, L)
    R = floor(double(R) / power(2, (8 - L)));
    G = floor(double(G) / power(2, (8 - L)));
    B = floor(double(B) / power(2, (8 - L)));
    n = power(2, 2 * L) * R + power(2, L) * G + B;
end

function [R, G, B] = get_RGB(n, L)
    R = uint8(floor(n / power(2, 2 * L)));
    G = uint8(floor((n - R) / power(2, L)));
    B = uint8(floor((n - R - G)));
end

function image_list = read_bmp(folder)
    filePattern = fullfile(folder, '*.bmp');
    bmpFiles = dir(filePattern);
    image_list = {};

    for i = 1:length(bmpFiles)
        baseFileName = bmpFiles(i).name;
        fullFileName = fullfile(folder, baseFileName);
        image = imread(fullFileName);
        image_list(end + 1) = {image};
    end
end