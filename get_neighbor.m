

function [map_r, visited_r] = get_neighbor(map, j, k, visited, map_ori)
    [rows, cols] = size(map);
    visited_r = visited;
    visited_r(j, k) = true;
    map_r = map;
    if map_ori(j, k)
        map_r(j, k) = true;
        if j ~= 1 && ~visited_r(j - 1, k)
            [map_r, visited_r] = get_neighbor(map_r, j - 1, k, visited_r, map_ori);
        end
        if j ~= rows && ~visited_r(j + 1, k)
            [map_r, visited_r] = get_neighbor(map_r, j + 1, k, visited_r, map_ori);
        end
        if k ~= 1 && ~visited_r(j, k - 1)
            [map_r, visited_r] = get_neighbor(map_r, j, k - 1, visited_r, map_ori);
        end
        if k ~= cols && ~visited_r(j, k + 1)
            [map_r, visited_r] = get_neighbor(map_r, j, k + 1, visited_r, map_ori);
        end
    end
end