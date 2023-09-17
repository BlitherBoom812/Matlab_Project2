
function result = detect_faces(test, v, L, ths, min_face_size)
    % 预处理
    [rows, cols, ~] = size(test);
    block_size = 4;
    blocklize = @(x) ceil(x/block_size) * block_size;
    test_ext = [test, zeros(rows, blocklize(cols) - cols, 3)];
    test_ext = [test_ext; zeros(blocklize(rows) - rows, blocklize(cols), 3)];
    % 人脸检测
    result = blockproc(test_ext, [block_size, block_size], @(blk) is_face(blk.data, v, L));
    % 标出红框
    valid = result < ths;
    squares = get_all_squares(test_ext, valid, v, L, ths, min_face_size);
    squared_pic_ext = blockproc(test_ext, [block_size, block_size], @(blk) make_red(blk, squares));
    result = squared_pic_ext(1:rows, 1:cols, :);
end