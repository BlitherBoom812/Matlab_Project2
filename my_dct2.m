function dct2C = my_dct2(dct2P)
    [rows, cols] = size(dct2P);
    % 初始化结果矩阵
    dct2C = my_dct_operator(rows) * double(dct2P) * my_dct_operator(cols)';
end