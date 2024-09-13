function plot_spiral(b, theta_list, axes, varargin)
cla(axes);
% 计算 theta_max
theta_max = max(max(theta_list), 32 * pi);

% 坐标转换
x = b * theta_list .* cos(theta_list);
y = b * theta_list .* sin(theta_list);

% 解析可选参数
p = inputParser;
addOptional(p, 'DrawCircle', false, @islogical);
addOptional(p, 'SetThetaLowerBound', false, @islogical);
addOptional(p, 'DrawNegativeSpiral', false, @islogical);
parse(p, varargin{:});
drawCircle = p.Results.DrawCircle;
setThetaLowerBound = p.Results.SetThetaLowerBound;
drawNegativeSpiral = p.Results.DrawNegativeSpiral;

% 绘图
cla(axes);

% 绘制背景螺旋线
if setThetaLowerBound
    theta_bg = linspace(450/b, theta_max, 1000);  % 生成theta值
else
    theta_bg = linspace(0, theta_max, 1000);  % 生成theta值
end
r_bg = b * theta_bg;                % 计算r值
x_bg = r_bg .* cos(theta_bg);
y_bg = r_bg .* sin(theta_bg);
plot(axes, x_bg, y_bg, 'r-', 'LineWidth', 0.5);  % 绘制背景螺旋线
hold(axes, 'on');

% 绘制负螺旋线
if drawNegativeSpiral
    r_bg_neg = -b * theta_bg;       % 计算负r值
    x_bg_neg = r_bg_neg .* cos(theta_bg);
    y_bg_neg = r_bg_neg .* sin(theta_bg);
    plot(axes, x_bg_neg, y_bg_neg, 'b-', 'LineWidth', 0.5);  % 绘制负螺旋线
    hold(axes, 'on');
end

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

% 检查矩形是否重叠
collision_pairs = check_collision(rectangles);

% 绘制矩形
for i = 1:length(rectangles)
    if any(collision_pairs(:) == i)
        fill(axes, rectangles{i}(:,1), rectangles{i}(:,2), 'r', 'FaceAlpha', 0.5); % 重叠的矩形用红色
    else
        fill(axes, rectangles{i}(:,1), rectangles{i}(:,2), 'b', 'FaceAlpha', 0.5); % 非重叠的矩形用蓝色
    end
end

% 如果启用了绘制圆的功能，绘制一个以原点为圆心，450为半径的圆
if drawCircle
    theta_circle = linspace(0, 2*pi, 1000);
    x_circle = 450 * cos(theta_circle);
    y_circle = 450 * sin(theta_circle);
    plot(axes, x_circle, y_circle, 'r-', 'LineWidth', 0.5);  % 圆的颜色与螺线相同
    
    % 计算螺线与圆的交点
    theta_intersect = 450 / b;
    x_intersect = 450 * cos(theta_intersect);
    y_intersect = 450 * sin(theta_intersect);
    
    % 计算负螺线与圆的交点
    x_intersect_neg = -450 * cos(theta_intersect);
    y_intersect_neg = -450 * sin(theta_intersect);
    
    % 计算切线斜率
    k_v = (sin(theta_intersect) + theta_intersect * cos(theta_intersect)) / ...
        (cos(theta_intersect) - theta_intersect * sin(theta_intersect));
    
    % 绘制切线
    tangent_length = 1000; % 切线长度
    x_tangent = linspace(x_intersect - tangent_length, x_intersect + tangent_length, 100);
    y_tangent = k_v * (x_tangent - x_intersect) + y_intersect;
    plot(axes, x_tangent, y_tangent, 'g--', 'LineWidth', 1.5);
    
    x_tangent_neg = linspace(x_intersect_neg - tangent_length, x_intersect_neg + tangent_length, 100);
    y_tangent_neg = k_v * (x_tangent_neg - x_intersect_neg) + y_intersect_neg;
    plot(axes, x_tangent_neg, y_tangent_neg, 'g--', 'LineWidth', 1.5);
    
    % 绘制垂直于切线的直线
    k_perpendicular = -1 / k_v;
    x_perpendicular = linspace(x_intersect - tangent_length, x_intersect + tangent_length, 100);
    y_perpendicular = k_perpendicular * (x_perpendicular - x_intersect) + y_intersect;
    plot(axes, x_perpendicular, y_perpendicular, 'm--', 'LineWidth', 1.5);
    
    x_perpendicular_neg = linspace(x_intersect_neg - tangent_length, x_intersect_neg + tangent_length, 100);
    y_perpendicular_neg = k_perpendicular * (x_perpendicular_neg - x_intersect_neg) + y_intersect_neg;
    plot(axes, x_perpendicular_neg, y_perpendicular_neg, 'm--', 'LineWidth', 1.5);
    
    % 连接两个切点
    plot(axes, [x_intersect, x_intersect_neg], [y_intersect, y_intersect_neg], 'k-', 'LineWidth', 1.5);
end

grid on;
axis(axes, [-1500 1500 -1500 1500]);
end