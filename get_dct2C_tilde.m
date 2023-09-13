

function dct2C_tilde = get_dct2C_tilde(hall_gray, QTAB)
    dct2P = double(hall_gray) - 128;
    dct2C = blockproc(dct2P, [8, 8], @(blk) dct2(blk.data));
    dct2C_tilde = blockproc(dct2C, [8, 8], @(blk) quantify_block(blk.data, QTAB));
    dct2C_tilde = blockproc(dct2C_tilde, [8, 8], @(blk) zigzagScan(blk.data)');
end