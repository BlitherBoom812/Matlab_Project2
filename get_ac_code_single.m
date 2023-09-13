% [1, 10, 3, 0, 0, 2, zeros(1, 20), 1, zeros(1, 37)];
function ac_code_single = get_ac_code_single(single_block, ACTAB)
    ZRL = get_ZRL();
    EOB = get_EOB();
    zero_num = 0;
    zrl_num = 0;
    ac_code_single = [];
    for scan_idx = 2:length(single_block)
        if single_block(scan_idx) == 0
            if zero_num == 15
                zrl_num = zrl_num + 1;
                zero_num = 0;
            else
                zero_num = zero_num + 1;
            end
        else 
            if zrl_num > 0
                ac_code_single = [ac_code_single, repmat(ZRL, 1, zrl_num)];
                zrl_num = 0;
            end
            data = single_block(scan_idx);
            amp = my_d2b(data);
            size = length(amp);
            run = zero_num;
            actab_row = ACTAB(run * 10 + size, :);
            actab_looked_up = actab_row(4:actab_row(3)+3);
            ac_code_single = [ac_code_single, actab_looked_up, amp];
            % fprintf("data = %d, amp = %s, size = %s, run = %s, actab_looked = %s\n", data, mat2str(amp), mat2str(size), mat2str(run), mat2str(actab_looked_up));
            zero_num = 0;
        end
    end
    ac_code_single = [ac_code_single, EOB];
end
