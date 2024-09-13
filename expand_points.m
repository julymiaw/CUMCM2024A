function [points] = expand_points(x1, y1, x2, y2, offset_x, offset_y)
%EXPAND_POINTS 平移点并生成包围矩形
%   [points] = expand_points(x1, y1, x2, y2, offset_x, offset_y)
%   输入：
%       x1, y1, x2, y2: 两个点的x,y坐标
%       offset_x: 沿两点连线方向的平移距离
%       offset_y: 垂直于连线方向的平移距离
%   输出：
%       points: 包围这两个点的四个点，按照左上、右上、右下、左下顺序

% 计算两点之间的向量
vector = [x2 - x1, y2 - y1];

% 计算向量长度和单位向量
vector_length = norm(vector);
unit_vector = vector / vector_length;

% 计算垂直向量
perp_vector = [-unit_vector(2), unit_vector(1)];

% 计算四个角的坐标
p1 = [x1, y1] - offset_x * unit_vector + offset_y * perp_vector; % 左上
p2 = [x2, y2] + offset_x * unit_vector + offset_y * perp_vector; % 右上
p3 = [x2, y2] + offset_x * unit_vector - offset_y * perp_vector; % 右下
p4 = [x1, y1] - offset_x * unit_vector - offset_y * perp_vector; % 左下

% 将结果按照要求的顺序组合
points = [p1; p2; p3; p4];
end