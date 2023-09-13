function [jpeg_row, jpeg_col, dc_code, ac_code] = my_encode(hall_gray, QTAB, DCTAB, ACTAB)
    dct2C_tilde = get_dct2C_tilde(hall_gray, QTAB);
    dct2C_tilde_final = get_dct2C_tilde_final(dct2C_tilde);
    dc_code = get_dc_code(dct2C_tilde_final, DCTAB);
        
    ac_code = [];
    for i = 1:length(dct2C_tilde_final)
        single_block = dct2C_tilde_final(:, i);
        ac_code_single = get_ac_code_single(single_block, ACTAB);
        ac_code = [ac_code, ac_code_single];
    end
    
    [jpeg_row, jpeg_col] = size(hall_gray);
end