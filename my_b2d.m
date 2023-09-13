
function y = my_b2d(bin)
    bin = reshape(bin, 1, length(bin));
    if length(bin) == 0
        y = 0;
    elseif bin(1) == 0
        y = 1 - bin;
        y = mat2str(y);
        y = regexprep(y, "[\[\]]", "");
        y = bin2dec(y);
        y = -y;
    else
        y = mat2str(bin);
        y = regexprep(y, "[\[\]]", "");
        y = bin2dec(y);
    end
end