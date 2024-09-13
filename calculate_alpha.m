function alpha = calculate_alpha(theta, ratio)
% 根据输入的 theta 计算对应的 alpha

% 获取 theta 的情况编号
case_num = get_theta_case(theta, ratio);

switch case_num
    case 1
        % 第一段正螺旋线
        k_v = (sin(theta) + theta * cos(theta)) / (cos(theta) - theta * sin(theta));
        if cos(theta) > theta * sin(theta)
            alpha = atan(k_v) + pi;
        elseif cos(theta) < theta * sin(theta)
            alpha = atan(k_v);
        else
            if mod(theta, 2*pi) >= -pi/2 && mod(theta, 2*pi) <= pi/2
                alpha = 3*pi/2;
            else
                alpha = pi/2;
            end
        end
    case 2
        % 第一段圆弧
        alpha = theta - pi/2;
    case 3
        % 第二段圆弧
        alpha = theta + pi/2;
    case 4
        % 第二段反螺旋线
        theta = -theta;
        k_v = (sin(theta) + theta * cos(theta)) / (cos(theta) - theta * sin(theta));
        if cos(theta) > theta * sin(theta)
            alpha = atan(k_v) + pi;
        elseif cos(theta) < theta * sin(theta)
            alpha = atan(k_v);
        else
            if mod(theta, 2*pi) >= -pi/2 && mod(theta, 2*pi) <= pi/2
                alpha = 3*pi/2;
            else
                alpha = pi/2;
            end
        end
    otherwise
        % 未知情况
        alpha = NaN;
end
end