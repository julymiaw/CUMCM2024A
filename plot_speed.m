function plot_speed(theta_list, axes)
% 计算速度值
speeds = calculate_speeds(theta_list);

% 判断数据长度并补零
num_speeds = length(speeds);
if num_speeds < 224
    speeds = [speeds, zeros(1, 224 - num_speeds)];
end

% 绘制速度图
cla(axes);
bar(axes, speeds);
ylim(axes, [-100, 100]); % 设置y轴范围
xlabel(axes, '节点');
ylabel(axes, '速度');
end