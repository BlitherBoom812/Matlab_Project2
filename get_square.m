function [top, bottom, left, right] = get_square(area, min_face_size)
    [row, col] = size(area);
    top = row + 1;
    bottom = 0;
    left = col + 1;
    right = 0;
    for l = 1:row
        for m = 1:col
            if area(l, m)
                if l < top
                    top = l;
                end
                if l > bottom
                    bottom = l;
                end
                if m > right
                    right = m;
                end
                if m < left
                    left = m;
                end
            end
        end
    end
end