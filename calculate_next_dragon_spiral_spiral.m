function theta2 = calculate_next_dragon_spiral_spiral(b, theta1, l)
% 已知螺线上一点，求解螺线上下一个点的theta值
% 输入参数:
%   b: 螺线参数
%   theta1: 上一个把手对应角度
%   l: 相邻把手距离
% 输出参数:
%   theta2: 下一个把手对应角度

% 定义目标函数
fun = @(theta2) b^2 * theta1^2 + b^2 * theta2^2 - 2 * b^2 * theta1 * theta2 * cos(theta2 - theta1) - l^2;

% 使用fzero求解
theta2 = fzero(fun, [theta1, theta1 + pi]);
end