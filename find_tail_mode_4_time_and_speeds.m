function find_tail_mode_4_time_and_speeds()
% 定义初始参数
v = 100;
ratio = 2;
tolerance = 1e-6; % 设定精度

% 封装函数用于判断指定时刻的龙尾模式是否为4
    function is_mode_4 = is_tail_in_mode_4(t)
        S = t * v;
        theta_list = calculate_angles_mix(S, ratio);
        tail_theta = theta_list(end);
        case_num = get_theta_case(tail_theta, ratio);
        is_mode_4 = (case_num == 4);
    end

% 使用二分查找法找到最后一个点恰好进入模式4的时间点
left = 382;
right = 385;
while left < right - tolerance
    mid = (left + right) / 2;
    if is_tail_in_mode_4(mid)
        right = mid;
    else
        left = mid;
    end
end
final_time = (left + right) / 2;

% 计算该时间点下的所有把手速度
S = final_time * v;
theta_list = calculate_angles_mix(S, ratio);
speed_list = calculate_speeds_mix(theta_list, ratio);

% 找出最大速度和最小速度
max_speed = max(speed_list);
min_speed = min(speed_list);

% 绘制速度图像
figure;
plot(speed_list, '-o', 'MarkerFaceColor', 'b', 'MarkerSize', 4);
xlabel('点索引');
ylabel('速度 (cm/s)');
title('各点速度图像');
grid on;

% 输出结果
fprintf('最后一个点恰好进入模式4的时间点为 %.6f\n', final_time);
fprintf('最大速度为 %.6f cm/s\n', max_speed);
fprintf('最小速度为 %.6f cm/s\n', min_speed);
end