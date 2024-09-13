% 初始化螺距范围
d_min = 0;
d_max = 55;
tolerance = 0.0001;

% 二分查找调整螺距
while (d_max - d_min) > tolerance
    d_mid = (d_min + d_max) / 2;
    if check_collision_for_pitch(d_mid)
        d_min = d_mid;  % 如果发生碰撞，增大螺距
    else
        d_max = d_mid;  % 如果没有碰撞，减小螺距
    end
end

% 最终螺距
optimal_pitch = (d_min + d_max) / 2;
fprintf('最优螺距: %.4f\n', optimal_pitch);