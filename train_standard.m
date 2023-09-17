function [v, L] = train_standard(dir, L)
    image_list = read_bmp(dir);
    u = zeros(1, power(2, 3 * L));
    for k=1:length(image_list)
        u = u + get_characteristic(image_list{k}, L);
    end
    v = u / length(image_list);
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