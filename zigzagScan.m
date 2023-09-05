
function zigzag = zigzagScan(matrix)
    [rows, cols] = size(matrix);
    zigzag = zeros(1, rows * cols);
    
    row = 1;
    col = 1;
    index = 1;
    direction = 'up';  % 初始方向向上
    
    while index <= rows * cols
        zigzag(index) = matrix(row, col);
        
        if strcmp(direction, 'up')
            if col == cols
                row = row + 1;
                direction = 'down';
            elseif row == 1
                col = col + 1;
                direction = 'down';
            else
                row = row - 1;
                col = col + 1;
            end
        else  % direction == 'down'
            if row == rows
                col = col + 1;
                direction = 'up';
            elseif col == 1
                row = row + 1;
                direction = 'up';
            else
                row = row + 1;
                col = col - 1;
            end
        end
        
        index = index + 1;
    end
end
