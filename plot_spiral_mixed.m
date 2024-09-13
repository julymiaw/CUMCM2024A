function plot_spiral_mixed(theta_list, axes, ratio)
% 固定 b 值
b = 170 / (2 * pi);

% 清空绘图区域
cla(axes);

hold(axes, 'on');

% 计算 theta_max
theta_max = max([max(abs(theta_list)), 32 * pi]);

% 绘制背景正螺旋线
theta_bg = linspace(450 / b, theta_max, 1000);
r_bg = b * theta_bg;
x_bg = r_bg .* cos(theta_bg);
y_bg = r_bg .* sin(theta_bg);
plot(axes, x_bg, y_bg, 'r-', 'LineWidth', 0.5);

% 绘制背景反螺旋线
r_bg_neg = -b * theta_bg;
x_bg_neg = r_bg_neg .* cos(theta_bg);
y_bg_neg = r_bg_neg .* sin(theta_bg);
plot(axes, x_bg_neg, y_bg_neg, 'b-', 'LineWidth', 0.5);

[x_center1, y_center1, radius1, x_center2, y_center2, radius2, ~, ~, phi_start1, phi_end1, phi_start2, phi_end2, ~, ~] = calculate_constant(ratio);

% 绘制第一个圆弧
theta_arc1 = linspace(phi_start1, phi_end1, 1000);
x_arc1 = x_center1 + radius1 * cos(theta_arc1);
y_arc1 = y_center1 + radius1 * sin(theta_arc1);
plot(axes, x_arc1, y_arc1, 'b-', 'LineWidth', 0.5);

% 绘制第二个圆弧
theta_arc2 = linspace(phi_start2, phi_end2, 1000);
x_arc2 = x_center2 + radius2 * cos(theta_arc2);
y_arc2 = y_center2 + radius2 * sin(theta_arc2);
plot(axes, x_arc2, y_arc2, 'b-', 'LineWidth', 0.5);

% 计算并绘制螺旋线或单个点
[x, y] = calculate_xy_mix(theta_list, ratio);

% 绘制螺旋线上的点
plot(axes, x, y, 'ro', 'MarkerSize', 5);
hold(axes, 'on');

% 使用 expand_points 函数计算相邻点的矩形
offset_x = 27.5;
offset_y = 15;
num_points = length(x);
rectangles = cell(1, num_points-1);
for i = 1:(num_points-1)
    rectangles{i} = expand_points(x(i), y(i), x(i+1), y(i+1), offset_x, offset_y);
end

% 绘制矩形
for i = 1:length(rectangles)
    fill(axes, rectangles{i}(:,1), rectangles{i}(:,2), 'b', 'FaceAlpha', 0.5); % 非重叠的矩形用蓝色
end

% 设置图形属性
grid(axes, 'on');
axis(axes, 'equal');
axis(axes, [-1800 1800 -1800 1800]);

% 保持绘图
hold(axes, 'off');
end