clear; clc;
% 生成时间序列
t = 400:0.1:432.8779;
% 定义螺线参数
b = 55 / (2 * pi);

% 创建视频对象
v = VideoWriter('q2.mp4', 'MPEG-4');
v.FrameRate = 10; % 设置帧率为10帧每秒
open(v);

% 初始化计时器
start_time = tic; % 记录开始时间

% 每次处理10帧
frames_per_batch = 60;
num_batches = ceil(length(t) / frames_per_batch);

parpool('local', 4); % 启动并行池，使用4个核

for batch = 1:num_batches
    start_idx = (batch - 1) * frames_per_batch + 1;
    end_idx = min(batch * frames_per_batch, length(t));
    
    % 提取当前批次的时间序列子集
    t_subset = t(start_idx:end_idx);
    
    % 预分配帧数组
    frames(1:length(t_subset)) = struct('cdata', [], 'colormap', []);
    
    % 并行生成帧
    parfor i = 1:length(t_subset)
        % 计算theta
        theta_list = calculate_angles(t_subset(i));
        
        % 绘制螺线图
        fig = figure('Visible', 'off', 'Position', [100, 50, 800, 900]);
        ax1 = axes('Parent', fig, 'Units', 'pixels', 'Position', [100, 225, 600, 600]);
        plot_spiral(b, theta_list, ax1);
        
        % 绘制速度图
        ax2 = axes('Parent', fig, 'Units', 'pixels', 'Position', [100, 50, 600, 150]);
        plot_speed(theta_list, ax2);
        
        % 添加总标题
        sgtitle(fig, sprintf('当前时间点: %.2f', t_subset(i)));
        
        % 获取当前图像
        frames(i) = getframe(fig);
        
        % 关闭图窗
        close(fig);
    end
    
    % 写入视频
    for i = 1:length(t_subset)
        writeVideo(v, frames(i));
    end
    
    % 输出进度信息
    elapsed_time = toc(start_time); % 计算已用时间
    remaining_time = elapsed_time * (num_batches - batch) / batch; % 估计剩余时间
    fprintf('生成视频中... (已用时间: %.2f s, 剩余时间: %.2f s)\n', elapsed_time, remaining_time);
end

% 关闭视频对象
close(v);

% 关闭并行池
delete(gcp('nocreate'));
