
function squares = get_all_squares(pic, valid, v, L, ths, min_face_size)
    [row, col] = size(valid);
    
    visited = false(size(valid));
    squares = false(size(valid));
    
    for k=1:row
        for j=1:col
            if valid(k, j) & ~visited(k, j)
                area = false(size(valid));
                [area, visited] = get_neighbor(area, k, j, visited, valid);
                [top, bottom, left, right] = get_square(area, min_face_size);
                square = false(size(area));
                if right - left > min_face_size & bottom - top > min_face_size
                    for l = left:right
                        square(top, l) = true;
                        square(bottom, l) = true;
                    end
                    
                    for l = top:bottom
                        square(l, left) = true;
                        square(l, right) = true;
                    end
                end
                squares = squares | square;
            end
        end
    end
end