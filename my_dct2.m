function dct2C = my_dct2(matrix)
    [rows, cols] = size(matrix);
    % 初始化结果矩阵
    dct2C = my_dct_operator(rows) * double(matrix) * my_dct_operator(cols)';
end