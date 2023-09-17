function red_pic = make_red(block, squared_area)
   row = block.location(1);
   col = block.location(2);
   size = block.blockSize(1);
   row = floor((row - 1) / size) + 1;
   col = floor((col - 1) / size) + 1;
   red_pic = block.data;
   if squared_area(row, col)
       red_pic(:, :, 1) = 255;
   end
end