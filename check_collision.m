function collision_pairs = check_collision(rectangles)
% rectangles: 包含所有矩形顶点坐标的单元数组

num_rectangles = length(rectangles);
collision_pairs = [];

for i = 1:num_rectangles
    for j = i+2:num_rectangles  % 跳过相邻的矩形
        if is_overlap(rectangles{i}, rectangles{j})
            collision_pairs = [collision_pairs; i, j];
        end
    end
end
end