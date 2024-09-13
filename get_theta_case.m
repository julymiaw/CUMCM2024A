function case_num = get_theta_case(theta, ratio)
% 根据输入的 theta 和 ratio 返回对应的情况编号

% 调用 calculate_constant 函数
[~, ~, ~, ~, ~, ~, ~, ~, phi_start1, phi_end1, phi_start2, phi_end2, ~, ~] = calculate_constant(ratio);

% 常量定义
d = 170;
b = d / (2 * pi);
theta_intersect1 = 450 / b;
theta_intersect2 = - 450 / b;

% 检查 theta 是否为实数
if ~isreal(theta)
    case_num = 5;  % 未知情况
else
    % 将 theta 截断到 4 位小数
    theta = round(theta, 4);
    if theta >= theta_intersect1
        case_num = 1;  % 第一段正螺旋线
    elseif theta >= phi_end1 && theta <= phi_start1
        case_num = 2;  % 第一段圆弧
    elseif theta >= phi_start2 && theta <= phi_end2
        case_num = 3;  % 第二段圆弧
    elseif theta <= theta_intersect2
        case_num = 4;  % 第二段反螺旋线
    else
        case_num = 5;  % 未知情况
    end
end
end