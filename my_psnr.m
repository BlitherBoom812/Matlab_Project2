function PSNR = my_psnr(pic_recovered, pic)
    [jpeg_row, jpeg_col] = size(pic);
    MSE = sum((double(pic_recovered) - double(pic)).^2, 'all') / (jpeg_row * jpeg_col);
    PSNR = 10* log10(255^2 / MSE);
end