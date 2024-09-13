function has_collision = check_collision_for_pitch(d)
% 定义螺线参数
b = d / (2 * pi);

% 计算角度列表
theta_list = calculate_angles_for_pitch(b);

% 坐标转换
x = b * theta_list .* cos(theta_list);
y = b * theta_list .* sin(theta_list);

% 使用 expand_points 函数计算相邻点的矩形
offset_x = 27.5;
offset_y = 15;
num_points = length(x);
rectangles = cell(1, num_points-1);
for i = 1:(num_points-1)
    rectangles{i} = expand_points(x(i), y(i), x(i+1), y(i+1), offset_x, offset_y);
end

% 检查矩形是否重叠
collision_pairs = check_collision(rectangles);

% 如果有重叠，返回 true，否则返回 false
has_collision = ~isempty(collision_pairs);
end