function speed_list = calculate_speeds_mix(theta_list, ratio)
% 定义初始速度
v1 = 100;

% 初始化速度列表
speed_list = zeros(1, length(theta_list));
speed_list(1) = v1;

% 初始化上一个alpha
prev_alpha = 0;

% 获取所有点的坐标
[x, y] = calculate_xy_mix(theta_list, ratio);

% 计算速度列表
for i = 1:length(theta_list)
    % 计算alpha
    alpha = calculate_alpha(theta_list(i), ratio);
    
    if i > 1
        % 计算两个点之间的斜率k_l
        delta_y = y(i) - y(i-1);
        delta_x = x(i) - x(i-1);
        k_l = delta_y / delta_x;
        
        % 计算beta
        if delta_x > 0
            beta = atan(k_l);
        elseif delta_x < 0
            beta = atan(k_l) + pi;
        else
            if delta_y > 0
                beta = pi/2;
            else
                beta = 3*pi/2;
            end
        end
        
        % 计算速度
        speed_list(i) = speed_list(i-1) * cos(beta - prev_alpha) / cos(alpha - beta);
    end
    
    % 更新上一个alpha
    prev_alpha = alpha;
end
end