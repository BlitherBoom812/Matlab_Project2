clear;
close all;
clc;

dir = "./图像处理所需资源/";
load(strcat(dir, "hall.mat"));
load(strcat(dir, "JpegCoeff.mat"));

pic = hall_gray;
value_hide = randi([0, 1], 100);
disp(['原数据：', mat2str(value_hide(1:length(value_hide)))]);

[jpeg_row, jpeg_col, dc_code, ac_code] = my_encode(pic, QTAB, DCTAB, ACTAB);
jpeg_decode_ori = my_decode(jpeg_row, jpeg_col, dc_code, ac_code, QTAB, DCTAB, ACTAB);

jpeg_decode_hide1 = run_hide(value_hide, pic, QTAB, DCTAB, ACTAB, 'hide1', @dct_hide1, @dct_show1);

jpeg_decode_hide2 = run_hide(value_hide, pic, QTAB, DCTAB, ACTAB, 'hide2', @dct_hide2, @dct_show2);

jpeg_decode_hide3 = run_hide(value_hide, pic, QTAB, DCTAB, ACTAB, 'hide3', @dct_hide3, @dct_show3);


subplot(2, 2, 1);
imshow(jpeg_decode_ori);
title("original compressed picture");
imwrite(pic, "hw_3_4_2_pic_compress.bmp");
subplot(2, 2, 2);
imshow(jpeg_decode_hide1);
title("hide1 compressed picture");
imwrite(jpeg_decode_hide1, "hw_3_4_2_pic_hide1_compress.bmp");
subplot(2, 2, 3);
imshow(jpeg_decode_hide2);
title("hide2 compressed picture");
imwrite(jpeg_decode_hide2, "hw_3_4_2_pic_hide2_compress.bmp");
subplot(2, 2, 4);
imshow(jpeg_decode_hide3);
title("hide3 compressed picture");
imwrite(jpeg_decode_hide3, "hw_3_4_2_pic_hide3_compress.bmp");

function [jpeg_row, jpeg_col, dc_code, ac_code] = dct_hide1(value_hide, pic, QTAB, DCTAB, ACTAB)
    % prepare
    dct2C_tilde = get_dct2C_tilde(pic, QTAB);
    dct2C_tilde_final = get_dct2C_tilde_final(dct2C_tilde);
    % hide value
    [value_rows, value_cols] = size(value_hide);
    value_hide = reshape(value_hide, 1, value_rows * value_cols);
    [rows, cols] = size(dct2C_tilde_final);
    value_hide = [value_hide, zeros(1, rows * cols - length(value_hide))];
    pic_hide_dct = dct2C_tilde_final;
    for k=1:rows
        for j=1:cols
            pic_hide_dct(k, j) = floor(dct2C_tilde_final(k, j)/2) * 2 + value_hide((k-1) * cols + j);
        end
    end
    % encode dc
    dc_code = get_dc_code(pic_hide_dct, DCTAB);
    % encode ac
    ac_code = [];
    for i = 1:length(pic_hide_dct)
        single_block = pic_hide_dct(:, i);
        ac_code_single = get_ac_code_single(single_block, ACTAB);
        ac_code = [ac_code, ac_code_single];
    end

    [jpeg_row, jpeg_col] = size(pic);

end

function value = dct_show1(jpeg_row, jpeg_col, dc_code, ac_code, QTAB, DCTAB, ACTAB)
    % decode dc
    dc_decode = get_dc_decode(dc_code, DCTAB);
    % decode ac
    ac_decode = get_ac_decode(ac_code, ACTAB);
    % recover image
    dct2C_tilde = [dc_decode; ac_decode];
    [rows, cols] = size(dct2C_tilde);
    value = zeros(1, rows * cols);
    for k=1:rows
        for j=1:cols
            value((k - 1) * cols + j) = mod(dct2C_tilde(k, j), 2);
        end
    end
end

function [jpeg_row, jpeg_col, dc_code, ac_code] = dct_hide2(value_hide, pic, QTAB, DCTAB, ACTAB)
    % prepare
    dct2C_tilde = get_dct2C_tilde(pic, QTAB);
    dct2C_tilde_final = get_dct2C_tilde_final(dct2C_tilde);
    % hide value
    [value_rows, value_cols] = size(value_hide);
    value_hide = reshape(value_hide, 1, value_rows * value_cols);
    [rows, cols] = size(dct2C_tilde_final);
    value_hide = [value_hide, zeros(1, cols - length(value_hide))];
    pic_hide_dct = dct2C_tilde_final;
    [mini, min_idx] = min(zigzagScan(QTAB));
    for j=1:cols
        pic_hide_dct(1, j) = floor(dct2C_tilde_final(1, j)/2) * 2 + value_hide(j);
        % disp(['j: ', mat2str(j), ', pic_hide_dct(1, j): ', mat2str(pic_hide_dct(1, j)), ', dct2C_tilde_final(1, j): ', mat2str(dct2C_tilde_final(1, j))]);
    end
    % encode dc
    dc_code = get_dc_code(pic_hide_dct, DCTAB);
    % encode ac
    ac_code = [];
    for i = 1:length(pic_hide_dct)
        single_block = pic_hide_dct(:, i);
        ac_code_single = get_ac_code_single(single_block, ACTAB);
        ac_code = [ac_code, ac_code_single];
    end

    [jpeg_row, jpeg_col] = size(pic);

end

function value = dct_show2(jpeg_row, jpeg_col, dc_code, ac_code, QTAB, DCTAB, ACTAB)
    % decode dc
    dc_decode = get_dc_decode(dc_code, DCTAB);
    % decode ac
    ac_decode = get_ac_decode(ac_code, ACTAB);
    % recover image
    dct2C_tilde_final = [dc_decode; ac_decode];
    [rows, cols] = size(dct2C_tilde_final);
    value = zeros(1, cols);
    for j=1:cols
        value(j) = mod(dct2C_tilde_final(1, j), 2);
    end
end


function [jpeg_row, jpeg_col, dc_code, ac_code] = dct_hide3(value_hide, pic, QTAB, DCTAB, ACTAB)
    % prepare
    dct2C_tilde = get_dct2C_tilde(pic, QTAB);
    dct2C_tilde_final = get_dct2C_tilde_final(dct2C_tilde);
    % hide value
    [value_rows, value_cols] = size(value_hide);
    value_hide = reshape(value_hide, 1, value_rows * value_cols);
    [rows, cols] = size(dct2C_tilde_final);
    value_hide = [value_hide, zeros(1, rows * cols - length(value_hide))];
    value_hide = (value_hide - 0.5) * 2;
    pic_hide_dct = dct2C_tilde_final;
    for j=1:cols
        if dct2C_tilde_final(end, j) ~= 0
            pic_hide_dct(end, j) = value_hide(j);
        else
            nz_row = 1;
            for m=rows:-1:1
                if dct2C_tilde_final(m, j) ~= 0
                    nz_row = m;
                    break;
                end
            end
            pic_hide_dct(nz_row + 1, j) = value_hide(j);
        end
    end
    % encode dc
    dc_code = get_dc_code(pic_hide_dct, DCTAB);
    % encode ac
    ac_code = [];
    for i = 1:length(pic_hide_dct)
        single_block = pic_hide_dct(:, i);
        ac_code_single = get_ac_code_single(single_block, ACTAB);
        ac_code = [ac_code, ac_code_single];
    end

    [jpeg_row, jpeg_col] = size(pic);

end

function value = dct_show3(jpeg_row, jpeg_col, dc_code, ac_code, QTAB, DCTAB, ACTAB)
    % decode dc
    dc_decode = get_dc_decode(dc_code, DCTAB);
    % decode ac
    ac_decode = get_ac_decode(ac_code, ACTAB);
    % recover image
    dct2C_tilde_final = [dc_decode; ac_decode];
    [rows, cols] = size(dct2C_tilde_final);
    value = zeros(1, cols);
    for j=1:cols
        nz_row = 1;
        for m=rows:-1:1
            if dct2C_tilde_final(m, j) ~= 0
                nz_row = m;
                break;
            end
        end
        value(j) = (dct2C_tilde_final(nz_row, j) + 1) / 2;
    end
end

function pic_recovered = run_hide(value_hide, pic, QTAB, DCTAB, ACTAB, hide_name, dct_hide, dct_show)
    [jpeg_row, jpeg_col, dc_code, ac_code] = dct_hide(value_hide, pic, QTAB, DCTAB, ACTAB);
    pic_recovered = my_decode(jpeg_row, jpeg_col, dc_code, ac_code, QTAB, DCTAB, ACTAB);
    value_show_jpeg = dct_show(jpeg_row, jpeg_col, dc_code, ac_code, QTAB, DCTAB, ACTAB);
    disp([hide_name, ' 压缩后解码：', mat2str(value_show_jpeg(1:length(value_hide)))]);

    correct = 0;
    for k=1:length(value_hide)
        if value_hide(k) == value_show_jpeg(k)
            correct = correct + 1;
        end
    end
    
    disp(['正确率：', mat2str(correct / length(value_hide))]);

    disp(['PSNR: ', mat2str(my_psnr(pic_recovered, pic))]);

    ac_size = length(ac_code);
    dc_size = length(dc_code);

    before_size = jpeg_row * jpeg_col;
    after_size = (ac_size + dc_size) / 8;
    
    fprintf("压缩比：%f\n", before_size / after_size);
end