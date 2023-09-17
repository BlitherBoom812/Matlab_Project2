
function u = get_characteristic(pic, L)
    [row, col, ~] = size(pic);
    u = zeros(1, power(2, 3 * L));
    for k=1:row
        for j=1:col
            n = get_n(pic(k, j, 1), pic(k, j, 2), pic(k, j, 3), L);
            u(n + 1) = u(n + 1) + 1;
        end
    end
    u = u / (row * col);
end

