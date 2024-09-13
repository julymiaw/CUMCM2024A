function phi = calculate_next_dragon_circle_circle(x1, y1, l, circle, ratio)
% 已知螺线上一点，求解圆弧上下一个点的phi值
% 输入参数:
%   x1, y1: 上一个把手坐标
%   l: 相邻把手距离
%   circle: 选择圆弧1或2
%   ratio: 比例参数
% 输出参数:
%   phi: 下一个把手对应角度

% 调用 calculate_constant 函数
[x_center1, y_center1, radius1, x_center2, y_center2, radius2, ~, ~, ~, ~, ~, ~, ~, ~] = calculate_constant(ratio);

% 根据 circle 参数选择圆心和半径
if circle == 1
    d = sqrt((x1 - x_center1)^2 + (y1 - y_center1)^2);
    phi = atan2(y1 - y_center1, x1 - x_center1) + acos((d^2 + radius1^2 - l^2) / (2 * d * radius1));
    if isreal(phi)
        phi = mod(phi, 2 * pi);
    end
else
    d = sqrt((x1 - x_center2)^2 + (y1 - y_center2)^2);
    phi = atan2(y1 - y_center2, x1 - x_center2) - acos((d^2 + radius2^2 - l^2) / (2 * d * radius2));
end
end