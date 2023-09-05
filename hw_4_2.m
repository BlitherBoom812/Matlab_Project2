clear all;
close all;
clc;

function dctD = my_dct_operator(N)
    col_coe = [1:N-1];
    row_coe = [1:2:2*N - 1];
    dctD = cos(col_coe' * row_coe * pi / (2 * N));
    dctD = sqrt(2/N) * [ones(1, N)/sqrt(2);dctD];
end

function dct2C = my_dct2(matrix)
    [rows, cols] = size(matrix);
    % 初始化结果矩阵
    dct2C = my_dct_operator(rows) * double(matrix) * my_dct_operator(cols);
end