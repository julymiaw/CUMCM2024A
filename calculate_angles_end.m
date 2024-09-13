function theta_list = calculate_angles_end()
% 定义螺线参数
b = 55 / (2 * pi);
l0 = 341 - 27.5 * 2;
l1 = 220 - 27.5 * 2;
theta_max = 32*pi;
max_points = 224;

% 计算初始角度 theta1
theta1 = (l0 / b - pi)/2;

% 初始化 theta_list
theta_list = zeros(1, max_points);
theta_list(1) = theta1;
theta_list(2) = theta1 + pi;
point_count = 2;

% 计算后续角度
while point_count < max_points
    theta2 = calculate_next_dragon_spiral_spiral(b, theta_list(point_count), l1);
    
    % 只计算螺线圈范围内的节点
    if theta2 <= theta_max
        theta_list(point_count + 1) = theta2;
        point_count = point_count + 1;
    else
        break;  % 超出范围，退出循环
    end
end

% 截取有效数据
theta_list = theta_list(1:point_count);
end