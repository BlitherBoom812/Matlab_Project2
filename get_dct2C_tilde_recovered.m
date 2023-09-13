function dct2C_tilde = get_dct2C_tilde_recovered(dct2C_tilde_final, row, col)
    dct2C_tilde = zeros(row, col);
    idx = 1;
    for i = 1:(row/64)
        for j = 1:col
            if i == 1 && j == 1
                dct2C_tilde(1:64, 1) = dct2C_tilde_final(:, 1);
            else
                dct2C_tilde((i - 1) * 64 + 1:i * 64, j) = dct2C_tilde_final(:, idx);
            end
            idx = idx + 1;
        end
    end
end