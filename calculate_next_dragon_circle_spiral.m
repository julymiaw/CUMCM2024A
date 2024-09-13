function theta2 = calculate_next_dragon_circle_spiral(b, x1, y1, l)
% 已知圆弧上一点，求解螺线上下一个点的theta值
% 输入参数:
%   b: 螺线参数
%   x, y: 上一个把手坐标
%   l: 相邻把手距离
% 输出参数:
%   phi: 下一个把手对应角度

d = sqrt(x1^2 + y1^2);
theta1 = atan2(y1, x1);

theta_start = 450 / b;  % 初始角度

% 设置fzero选项以提高求解精度
options = optimset('TolX', 1e-10, 'TolFun', 1e-10);

% 定义目标函数
fun = @(theta2) d^2 + b^2 * theta2^2 - 2 * b * d * theta2 * cos(theta2 - theta1) - l^2;

% 使用fzero求解
theta2 = fzero(fun, [theta1 + 6 * pi, theta_start + pi], options);

end