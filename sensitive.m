% 设定 ratio 的取值范围
% ratio_min = 1 / 2.1469;
% ratio_max = 2.1469;
% num_points = 100; % 设定取样点数

% % 生成对称的 ratio 取值
% ratios = linspace(ratio_min, ratio_max, num_points);
% ratios = unique([ratios, 1 ./ ratios]); % 确保对称性

% % 初始化存储最大速度的数组
% max_speeds = zeros(size(ratios));

% % 计算每个 ratio 对应的最大速度
% parfor i = 1:length(ratios)
%     ratio = ratios(i);
%     [max_speed_value, ~] = q5(ratio);
%     max_speeds(i) = max_speed_value;
% end

% % 绘制图像
% figure;
% plot(ratios, max_speeds, '-o', 'MarkerFaceColor', 'b', 'MarkerSize', 4);
% xlabel('Ratio');
% ylabel('最大速度 (cm/s)');
% title('Ratio 与最大速度的关系');
% grid on;

ratio_min = 0.9;
ratio_max = 1.1;

% 逐步减小步长找到最小值
tolerance = 1e-6; % 设定精度
step_size = 0.1; % 初始步长
current_min_ratio = ratio_min;
current_min_speed = inf;

while step_size > tolerance
    test_ratios = current_min_ratio:step_size:ratio_max;
    for ratio = test_ratios
        [speed, ~] = q5(ratio);
        if speed < current_min_speed
            current_min_speed = speed;
            current_min_ratio = ratio;
        end
    end
    % 减小步长并在更小范围内继续搜索
    ratio_min = max(current_min_ratio - step_size, 1 / 2.1469);
    ratio_max = min(current_min_ratio + step_size, 2.1469);
    step_size = step_size / 10;
end

% 使用 vpa 保持高精度计算结果
min_speed_inverse = vpa(200 / current_min_speed, 6);

% 显示结果
fprintf('加速比为 %.6f，对应的 ratio 为 %.6f\n', min_speed_inverse, current_min_ratio);