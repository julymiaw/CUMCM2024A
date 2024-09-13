function [x, y] = calculate_xy_mix(theta_list, ratio)
% 根据输入的 theta_list 和 ratio 计算 x 和 y 值

% 调用 calculate_constant 函数
[x_center1, y_center1, radius1, x_center2, y_center2, radius2, ~, ~, ~, ~, ~, ~, ~, ~] = calculate_constant(ratio);

% 常量定义
b = 170 / (2 * pi);

% 提前分配内存
num_points = length(theta_list);
x = zeros(1, num_points);
y = zeros(1, num_points);

for i = 1:num_points
    theta = theta_list(i);
    case_num = get_theta_case(theta, ratio);
    switch case_num
        case 1
            % 第一段正螺旋线
            x(i) = b * theta * cos(theta);
            y(i) = b * theta * sin(theta);
        case 2
            % 第一段圆弧
            x(i) = x_center1 + radius1 * cos(theta);
            y(i) = y_center1 + radius1 * sin(theta);
        case 3
            % 第二段圆弧
            x(i) = x_center2 + radius2 * cos(theta);
            y(i) = y_center2 + radius2 * sin(theta);
        case 4
            % 第二段反螺旋线
            x(i) = b * theta * cos(theta);
            y(i) = - b * theta * sin(theta);
        case 5
            % 未知情况
            error('未知情况: theta = %.4f', theta);
    end
end
end