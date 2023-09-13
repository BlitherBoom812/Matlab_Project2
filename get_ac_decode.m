function ac_decode = get_ac_decode(ac_code, ACTAB)
    ac_decode = [];
    ZRL = get_ZRL();
    EOB = get_EOB();
    ac_code = reshape(ac_code, 1, length(ac_code));
    start_idx = 1;
    idx = 1;
    ac_decode_single = [];
    while idx <= length(ac_code)
        huffman_code = ac_code(start_idx:idx);
        [row, ~] = size(ACTAB);
        if length(huffman_code) == length(ZRL) && all(ZRL == huffman_code)
            ac_decode_single = [ac_decode_single, zeros(1, 16)];
            % fprintf("insert 16 zeros\n");
            start_idx = idx + 1;
            idx = idx + 1;
        elseif length(huffman_code) == length(EOB) && all(EOB == huffman_code)
            % fprintf("insert %d zeros\n", 63 - length(ac_decode_single));
            ac_decode_single = [ac_decode_single, zeros(1, 63 - length(ac_decode_single))];
            ac_decode = [ac_decode, ac_decode_single'];
            ac_decode_single = [];
            start_idx = idx + 1;
            idx = idx + 1;
        else
            ac_run = -1;
            ac_size = -1;
            look_up_row = -1;
            for j = 1:row
                actab_len = ACTAB(j, 3);
                if length(huffman_code) == actab_len
                    if all(ACTAB(j, 4:3+actab_len) == huffman_code)
                        ac_run = ACTAB(j, 1);
                        ac_size = ACTAB(j, 2);
                        look_up_row = j;
                        break;
                    end
                end
            end
            if and(ac_run ~= -1, ac_size ~= -1)
                amp = ac_code(idx+1:idx+ac_size);
                data = my_b2d(amp);
                ac_decode_single = [ac_decode_single, zeros(1, ac_run), data];
                % fprintf("data = %d, amp = %s, size = %s, run = %s, actab_looked = %s, now_size = %d\n", ...
                %     data, ...
                %     mat2str(amp), ...
                %     mat2str(ac_size), ...
                %     mat2str(ac_run), ...
                %     mat2str(ACTAB(look_up_row, 4:length(amp)+3)), ...
                %     size(ac_decode_single) ...
                % );
                start_idx = idx + ac_size + 1;
                idx = idx + ac_size + 1;
            else
                idx = idx + 1;
            end
        end
    end
end