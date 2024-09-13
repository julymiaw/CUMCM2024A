function theta_list = calculate_angles(t)
% 定义螺线参数
b = 55 / (2 * pi);
v = 100;
l0 = 341 - 27.5 * 2;
l1 = 220 - 27.5 * 2;
max_points = 224;
theta_max = 32 * pi;

% 计算theta值
S = v * t;
theta1 = calculate_dragon_head_angle(b, S, theta_max);
theta_list = zeros(1, max_points);
theta_list(1) = theta1;
point_count = 1;
first_point = true;

while point_count < max_points
    if first_point
        theta2 = calculate_next_dragon_spiral_spiral(b, theta1, l0);
        first_point = false;
    else
        theta2 = calculate_next_dragon_spiral_spiral(b, theta1, l1);
    end
    
    theta_list(point_count + 1) = theta2;
    theta1 = theta2;
    point_count = point_count + 1;
end
end