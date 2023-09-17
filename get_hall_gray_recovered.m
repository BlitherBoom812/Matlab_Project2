
function hall_gray_recovered = get_hall_gray_recovered(dct2C_tilde, QTAB)
    dct2C_tilde = blockproc(dct2C_tilde, [64, 1], @(blk) zigzagScanInv(blk.data, 8, 8));
    dct2C = blockproc(dct2C_tilde, [8, 8], @(blk) quantify_block_inv(blk.data, QTAB));
    dct2P =  blockproc(dct2C, [8, 8], @(blk) idct2(blk.data));
    hall_gray_recovered = uint8(dct2P + 128);
end