function n = get_n(R, G, B, L)
    R = floor(double(R) / power(2, (8 - L)));
    G = floor(double(G) / power(2, (8 - L)));
    B = floor(double(B) / power(2, (8 - L)));
    n = power(2, 2 * L) * R + power(2, L) * G + B;
end