function overlap = is_overlap(rect1, rect2)
% is_overlap: 判断两个矩形是否重叠
%   rect1, rect2: 矩形的四个顶点坐标，分别为4x2的矩阵

% 计算所有可能的分离轴
axes = [rect1(2,:) - rect1(1,:); rect1(3,:) - rect1(2,:); ...
    rect2(2,:) - rect2(1,:); rect2(3,:) - rect2(2,:)];

% 对于每个轴，投影两个矩形到该轴上，判断投影区间是否重叠
overlap = true;
for i = 1:size(axes, 1)
    axis = axes(i, :);
    proj1 = rect1 * axis';
    proj2 = rect2 * axis';
    if max(proj1) < min(proj2) || max(proj2) < min(proj1)
        overlap = false;
        break;
    end
end
end