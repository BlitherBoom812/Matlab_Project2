function y = my_d2b(x)
    if x < 0
        y = 1 - (dec2bin(-x) - '0');
    elseif x > 0
        y = (dec2bin(x) - '0');
    else 
        y = [];
    end
end