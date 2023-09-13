
function dct2C_tilde_final = get_dct2C_tilde_final(dct2C_tilde)
    [rows, cols] = size(dct2C_tilde);
    dct2C_tilde_final = [];
    for i = 1:(rows/64)
        for j = 1:cols
            if i == 1 && j == 1
                dct2C_tilde_final = dct2C_tilde(1:64, 1);
            else
                dct2C_tilde_final = [dct2C_tilde_final, dct2C_tilde((i - 1) * 64 + 1:i * 64, j)];
            end
        end
    end
end