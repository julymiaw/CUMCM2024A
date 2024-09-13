function generate_mix_spiral_video()
close all;
% 生成时间序列
t = -100:0.01:500;
v = 100;
ratio = 2;

% 创建视频对象
video = VideoWriter('q4_high_quality.mp4', 'MPEG-4');
video.FrameRate = 100; % 设置帧率为100帧每秒
open(video);

% 初始化进度条
h = waitbar(0, '生成视频中...');
start_time = tic; % 记录开始时间

% 每次处理10帧
frames_per_batch = 10;
num_batches = ceil(length(t) / frames_per_batch);

c = parcluster('local');
c.NumWorkers = 12;
parpool(c, 8);

for batch = 1:num_batches
    start_idx = (batch - 1) * frames_per_batch + 1;
    end_idx = min(batch * frames_per_batch, length(t));
    
    % 提取当前批次的时间序列子集
    t_subset = t(start_idx:end_idx);
    
    % 预分配帧数组
    frames(1:length(t_subset)) = struct('cdata', [], 'colormap', []);
    
    % 并行生成帧
    parfor i = 1:length(t_subset)
        % 创建图窗对象
        fig = figure('Visible', 'off', 'Position', [100, 50, 800, 960]);
        ax1 = axes('Parent', fig, 'Units', 'pixels', 'Position', [100, 250, 600, 600]);
        ax2 = axes('Parent', fig, 'Units', 'pixels', 'Position', [100, 50, 600, 150]);
        
        % 计算 s 和 theta_list
        s = t_subset(i) * v;
        theta_list = calculate_angles_mix(s, ratio);
        
        % 绘制螺线图
        plot_spiral_mixed(theta_list, ax1, ratio);
        
        % 计算速度
        speed_list = calculate_speeds_mix(theta_list, ratio);
        
        % 绘制速度柱状图
        plot(ax2, speed_list);
        xlabel(ax2, 'Index');
        ylabel(ax2, 'Speed');
        title(ax2, '速度分布图');
        ylim(ax2, [50, 170]); % 指定速度的显示范围
        xlim(ax2, [1, 224]); % 指定 x 轴的显示范围
        
        % 添加总标题
        sgtitle(fig, sprintf('当前时间点: %.2f', t_subset(i)));
        
        % 获取当前图像
        frame = getframe(fig);
        frames(i) = frame;
        
        % 关闭并删除图窗对象以释放内存
        close(fig);
        delete(fig);
    end
    
    % 写入视频
    for i = 1:length(t_subset)
        writeVideo(video, frames(i));
    end
    
    % 清理不再需要的变量
    clear frames t_subset;
    
    % 更新进度条
    elapsed_time = toc(start_time); % 计算已用时间
    remaining_time = elapsed_time * (num_batches - batch) / batch; % 估计剩余时间
    waitbar(batch / num_batches, h, sprintf('生成视频中... (已用时间: %.2f s, 剩余时间: %.2f s)', elapsed_time, remaining_time));
end

% 关闭进度条
close(h);

% 关闭视频对象
close(video);

% 关闭并行池
delete(gcp('nocreate'));
end