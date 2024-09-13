function collision_time = find_collision_time()
% 初始化时间区间
t_start = 410;
t_end = 432.8779;

% 步长列表
step_sizes = [0.05, 0.01, 0.005, 0.001, 0.0005, 0.0001];

% 逐步缩小时间区间
for step = step_sizes
    t_range = t_start:step:t_end;
    for t = t_range
        % 计算 theta_list
        theta_list = calculate_angles(t);
        
        % 定义螺线参数
        b = 55 / (2 * pi);
        
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
        
        % 如果有重叠，更新时间区间
        if ~isempty(collision_pairs)
            t_start = max(t - step, 410);
            t_end = min(t + step, 432.8779);
            break;
        end
    end
end

% 返回第一次发生碰撞的时间点
collision_time = (t_start + t_end) / 2;
end