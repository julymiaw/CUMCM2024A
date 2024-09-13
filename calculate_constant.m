function [x_center1, y_center1, radius1, x_center2, y_center2, radius2, x_connection, y_connection, phi_start1, phi_end1, phi_start2, phi_end2, arc_length1, arc_length2] = calculate_constant(ratio)
% 已知参数
R = 450;
d = 170;
b = d / (2 * pi);

% 计算 theta_in
theta_in = 2 * pi * R / d;

% 计算 k_0
k_0 = - (cos(theta_in) - theta_in * sin(theta_in)) / (sin(theta_in) + theta_in * cos(theta_in));

% 计算点 P 和 Q 的极坐标
r_P = b * theta_in;
r_Q = -b * theta_in;

% 计算点 P 和 Q 的笛卡尔坐标
x_P = r_P * cos(theta_in);
y_P = r_P * sin(theta_in);
x_Q = r_Q * cos(theta_in);
y_Q = r_Q * sin(theta_in);

% 计算 k_PQ
k_PQ = (y_P - y_Q) / (x_P - x_Q);

% 计算 gamma
gamma = pi - 2 * (atan(k_PQ) - atan(k_0));

% 计算 r
r = R / ((ratio + 1) * sin(gamma / 2));

% 计算圆心 I_1 的坐标
x_center1 = x_P + (ratio * r) / sqrt(k_0^2 + 1);
y_center1 = y_P + (ratio * r * k_0) / sqrt(k_0^2 + 1);
radius1 = ratio * r;

% 计算圆心 I_2 的坐标
x_center2 = x_Q - r / sqrt(k_0^2 + 1);
y_center2 = y_Q - (r * k_0) / sqrt(k_0^2 + 1);
radius2 = r;

% 计算两圆连接点
x_connection = x_center1 + ratio/(ratio + 1) * (x_center2 - x_center1);
y_connection = y_center1 + ratio/(ratio + 1) * (y_center2 - y_center1);

% 计算圆弧的起点和终点角度
phi_start1 = atan2(y_P - y_center1, x_P - x_center1) + 2 * pi;
phi_end1 = atan2(y_connection - y_center1, x_connection - x_center1);

phi_start2 = atan2(y_connection - y_center2, x_connection - x_center2);
phi_end2 = atan2(y_Q - y_center2, x_Q - x_center2);

% 计算圆弧长度
arc_length1 = abs(phi_end1 - phi_start1) * radius1;
arc_length2 = abs(phi_end2 - phi_start2) * radius2;
end