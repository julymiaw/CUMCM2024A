function [max_speed_value, max_speed_time] = q5(ratio)
if nargin < 1
    ratio = 2;
    display = true;
end

% 初始步长
step_size = 1;

% 初始时间序列
t = -100:step_size:100;

% 初始最大速度及其对应的时刻
[max_speed_value, max_speed_time, max_speed_nodes] = find_max_speed(t, ratio);

% 迭代提高精度
for iteration = 1:6
    % 缩小搜索范围
    t = max_speed_time - step_size:step_size/10:max_speed_time + step_size;
    step_size = step_size / 10;
    
    % 找到新的最大速度及其对应的时刻
    [max_speed_value, max_speed_time, max_speed_nodes] = find_max_speed(t, ratio);
end

% 打印最终的最大速度及其对应的时刻
if display
    fprintf('最终最大速度: %.6f cm/s\n', max_speed_value);
    fprintf('最终最大速度对应的时刻: %.6f\n', max_speed_time);
    fprintf('最大速度对应的节点索引: ');
    fprintf('%d ', max_speed_nodes);
    fprintf('\n');
end
end

function [max_speed_value, max_speed_time, max_speed_nodes] = find_max_speed(t, ratio)
% 并行计算每个时刻的最大速度
max_speeds = zeros(size(t));
max_speed_nodes = cell(size(t)); % 使用 cell 数组存储每个时刻的最大速度节点索引
tolerance = 1e-6; % 设定精度
parfor i = 1:length(t)
    % 计算 s 和 theta_list
    s = t(i) * 100;
    theta_list = calculate_angles_mix(s, ratio);
    
    % 计算速度
    speed_list = calculate_speeds_mix(theta_list, ratio);
    
    % 找到当前时刻的最大速度及其对应的节点索引
    max_speed = max(speed_list);
    max_speed_nodes{i} = find(abs(speed_list - max_speed) < tolerance); % 找到所有并列第一的最大值索引
    max_speeds(i) = max_speed;
end

% 找到所有时刻中的最大速度及其对应的时刻和节点索引
[max_speed_value, idx] = max(max_speeds);
max_speed_time = t(idx);
max_speed_nodes = max_speed_nodes{idx}; % 获取对应时刻的所有最大速度节点索引
end