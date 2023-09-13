function decoded = my_decode(jpeg_row, jpeg_col, dc_code, ac_code, QTAB, DCTAB, ACTAB)
    % decode dc
    dc_decode = get_dc_decode(dc_code, DCTAB);
    % decode ac
    ac_decode = get_ac_decode(ac_code, ACTAB);
    % recover image
    dct2C_tilde_recovered = get_dct2C_tilde_recovered([dc_decode; ac_decode], jpeg_row * 8, jpeg_col / 8);
    decoded = get_hall_gray_recovered(dct2C_tilde_recovered, QTAB);
end