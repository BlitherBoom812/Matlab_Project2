function dc_decode = get_dc_decode(dc_code, DCTAB)
    % decode dc
    dc_code = reshape(dc_code, 1, length(dc_code));
    dc_decode_diff = [];
    start_idx = 1;
    idx = 1;
    while idx <= length(dc_code) 
        huffman_code = dc_code(start_idx:idx);
        [row, col] = size(DCTAB);
        cat = -1;
        for j = 1:row
            if all(DCTAB(j, 1) == length(huffman_code))
                if all(DCTAB(j, 2:1+length(huffman_code)) == huffman_code)
                    cat = j - 1;
                    break
                end
            end
        end
        if cat ~= -1
            data = dc_code(idx+1:idx+cat);
            data_dec = my_b2d(data);
            dc_decode_diff = [dc_decode_diff, data_dec];
            start_idx = idx + cat + 1;
            idx = idx + cat + 1;
        else
            idx = idx + 1;
        end
    end
    dc_decode = cumsum([dc_decode_diff(1), -dc_decode_diff(2:end)]);

end