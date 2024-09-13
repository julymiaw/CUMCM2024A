function theta = calculate_dragon_head_angle(b, S, theta_max)
% 计算龙头在极坐标系下的theta值
% 输入参数:
%   b: 螺线参数
%   S: 龙头经过的总弧长
%   theta_max: 螺线最大角度
% 输出参数:
%   theta: 龙头对应角度

% 定义弧长函数
L = @(theta) b/2 * (theta * sqrt(1 + theta^2) + log(theta + sqrt(1 + theta^2)));

% 目标函数
fun = @(theta) L(theta_max) - L(theta) - S;

% 使用fzero求解，并设置容差
options = optimset('TolX', 1e-6);  % 设置位置容差
theta = fzero(fun, [0, theta_max], options);
end