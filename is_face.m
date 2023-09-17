% 分块检测
function d = is_face(single_block, v, L)
    u = get_characteristic(single_block, L);
    d = 1 - sqrt(u) * sqrt(v');
end
