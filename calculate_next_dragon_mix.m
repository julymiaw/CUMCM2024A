function theta2 = calculate_next_dragon_mix(b, theta1, l, ratio)
% 根据当前的 theta1 和 l 计算下一个 theta2

% 获取当前 theta1 的情况
case_num = get_theta_case(theta1, ratio);

switch case_num
    case 1
        % 第一种情况：正螺旋线
        theta2 = calculate_next_dragon_spiral_spiral(b, theta1, l);
        assert(get_theta_case(theta2, ratio) ~= 5, '情况一出现异常角，theta1为 %.4f，theta2为 %.4f', theta1, theta2);
        
    case 2
        % 第二种情况：第一段圆弧
        [x1, y1] = calculate_xy_mix(theta1, ratio);
        phi = calculate_next_dragon_circle_circle(x1, y1, l, 1, ratio);
        if get_theta_case(phi, ratio) == 2
            theta2 = phi;
        else
            theta2 = calculate_next_dragon_circle_spiral(b, x1, y1, l);
            assert(get_theta_case(theta2, ratio) == 1, '情况二出现异常角，theta1为 %.4f，第一次尝试结果为 %.4f，不符。第二次尝试结果为 %.4f，不符。\n', theta1, phi, theta2);
        end
        
    case 3
        % 第三种情况：第二段圆弧
        [x1, y1] = calculate_xy_mix(theta1, ratio);
        phi = calculate_next_dragon_circle_circle(x1, y1, l, 1, ratio);
        if get_theta_case(phi, ratio) == 2
            theta2 = phi;
        else
            phi2 = calculate_next_dragon_circle_circle(x1, y1, l, 2, ratio);
            assert(get_theta_case(phi2, ratio) == 3, '情况三出现异常角，theta1为 %.4f，第一次尝试结果为 %.4f，不符。第二次尝试结果为 %.4f，不符。\n', theta1, phi, phi2);
            theta2 = phi2;
        end
        
    case 4
        % 第四种情况：反螺旋线
        theta2 = calculate_next_dragon_spiral_spiral(b, theta1, l);
        if get_theta_case(theta2, ratio) == 4
            return;
        else
            temp1 = calculate_next_dragon_spiral_circle(b, theta1, l, 2, ratio);
            if get_theta_case(temp1, ratio) == 3
                theta2 = temp1;
                return;
            else
                temp2 = calculate_next_dragon_spiral_circle(b, theta1, l, 1, ratio);
                assert(get_theta_case(temp2, ratio) == 2, '情况四出现异常角，theta1为 %.4f，第一次尝试结果为 %.4f，第二次尝试结果为 %.4f，第三次尝试结果为 %.4f。\n', theta1, theta2, temp1, temp2);
                theta2 = temp2;
            end
        end
        
    case 5
        error('出现异常角，theta1为 %.4f', theta1);
end
end