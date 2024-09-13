function speed_list = calculate_speeds(theta_list)
% 定义初始速度
v1 = 100;

% 初始化速度列表
speed_list = zeros(1, length(theta_list));
speed_list(1) = v1;

% 初始化上一个alpha
prev_alpha = 0;

% 计算速度列表
for i = 1:length(theta_list)
    % 计算k_v
    k_v = (sin(theta_list(i)) + theta_list(i) * cos(theta_list(i))) / ...
        (cos(theta_list(i)) - theta_list(i) * sin(theta_list(i)));
    
    % 计算alpha
    if cos(theta_list(i)) > theta_list(i) * sin(theta_list(i))
        alpha = atan(k_v) + pi;
    elseif cos(theta_list(i)) < theta_list(i) * sin(theta_list(i))
        alpha = atan(k_v);
    else
        if mod(theta_list(i), 2*pi) >= -pi/2 && mod(theta_list(i), 2*pi) <= pi/2
            alpha = 3*pi/2;
        else
            alpha = pi/2;
        end
    end
    
    if i > 1
        % 计算k_l
        k_l = (theta_list(i) * sin(theta_list(i)) - theta_list(i-1) * sin(theta_list(i-1))) / ...
            (theta_list(i) * cos(theta_list(i)) - theta_list(i-1) * cos(theta_list(i-1)));
        
        % 计算beta
        if theta_list(i-1) * cos(theta_list(i-1)) > theta_list(i) * cos(theta_list(i))
            beta = atan(k_l);
        elseif theta_list(i-1) * cos(theta_list(i-1)) < theta_list(i) * cos(theta_list(i))
            beta = atan(k_l) + pi;
        else
            if theta_list(i-1) * sin(theta_list(i-1)) > theta_list(i) * sin(theta_list(i))
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