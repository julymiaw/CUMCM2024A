function theta = calculate_dragon_head_angle_mix(S, ratio)
% 计算龙头在极坐标系下的theta值
% 输入参数:
%   S: 龙头经过的总弧长
%   ratio: 比例参数
% 输出参数:
%   theta: 龙头对应角度

% 调用 calculate_constant 函数
[~, ~, R1, ~, ~, R2, ~, ~, phi_start1, phi_end1, phi_start2, phi_end2, L1, L2] = calculate_constant(ratio);

b = 170 / (2 * pi);  % 固定 b 值
theta_intersect = 450 / b;  % 切线处角度
theta_max = 32 * pi;  % 最大角度

% 定义弧长函数
L = @(theta) b/2 * (theta * sqrt(1 + theta^2) + log(theta + sqrt(1 + theta^2)));

options = optimset('TolX', 1e-6);  % 设置位置容差

% 目标函数
if S < 0
    S = -S;
    fun = @(theta) L(theta) - L(theta_intersect) - S;
    theta = fzero(fun, [theta_intersect, theta_max], options);
    assert(theta > theta_intersect, ...
        sprintf('情况1: theta_list1 中存在小于 theta_intersect 的角度。当前值: %.4f, 正确范围: > %.4f', theta, theta_intersect));
elseif S <= L1
    fun = @(phi) R1 * (phi_start1 - phi) - S;
    theta = fzero(fun, [0, 3 * pi / 2], options);
    assert(theta >= phi_end1 && theta <= phi_start1, ...
        sprintf('情况2: theta_list2 中存在不在圆弧范围内的角度。当前值: %.4f, 正确范围: [%.4f, %.4f]', theta, phi_end1, phi_start1));
elseif S <= L1 + L2
    S = S - L1;
    fun = @(phi) R2 * (phi - phi_start2) - S;
    theta = fzero(fun, [-pi, pi/2], options);
    assert(theta >= phi_start2 && theta <= phi_end2, ...
        sprintf('情况3: theta_list3 中存在不在圆弧范围内的角度。当前值: %.4f, 正确范围: [%.4f, %.4f]', theta, phi_start2, phi_end2));
else
    S = S - L1 - L2;
    fun = @(theta) L(theta) - L(theta_intersect) - S;
    theta = - fzero(fun, [theta_intersect, theta_max], options);
    assert(theta < -  theta_intersect, ...
        sprintf('情况4: theta_list4 中存在大于 - theta_intersect 的角度。当前值: %.4f, 正确范围: < %.4f', theta, - theta_intersect));
end
end