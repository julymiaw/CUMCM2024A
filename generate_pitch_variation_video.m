function generate_pitch_variation_video()
% 初始化螺距范围
d_min = 30;
d_max = 55;
step_size = 0.01;
frames_per_batch = 120;

% 创建视频对象
v = VideoWriter('q3.mp4', 'MPEG-4');
v.FrameRate = 120; % 设置帧率为120帧每秒
open(v);

% 计算总帧数
total_frames = floor((d_max - d_min) / step_size) + 1;
num_batches = ceil(total_frames / frames_per_batch);

% 初始化进度条
h = waitbar(0, '正在处理...');
start_time = tic; % 记录开始时间

% 创建100个不可见的图窗对象
figs = gobjects(1, frames_per_batch);
axes_array = gobjects(1, frames_per_batch);
for k = 1:frames_per_batch
    figs(k) = figure('Visible', 'off', 'Position', [100, 100, 800, 800]);
    axes_array(k) = axes('Parent', figs(k), 'Units', 'pixels', 'Position', [100, 100, 600, 600]);
end

for batch = 1:num_batches
    start_frame = (batch - 1) * frames_per_batch + 1;
    end_frame = min(batch * frames_per_batch, total_frames);
    num_frames = end_frame - start_frame + 1;
    
    % 预分配帧数组
    frames = struct('cdata', cell(1, num_frames), 'colormap', cell(1, num_frames));
    
    parfor i = 1:num_frames
        frame_index = start_frame + i - 1;
        d = d_max - (frame_index - 1) * step_size;
        
        % 定义螺线参数
        b = d / (2 * pi);
        
        % 计算角度列表
        theta_list = calculate_angles_for_pitch(b);
        
        % 获取分配的图窗和轴对象
        fig = figs(i);
        ax = axes_array(i);
        
        % 清除当前轴内容
        cla(ax);
        
        % 启用绘制圆和设置theta下界的功能
        plot_spiral(b, theta_list, ax, 'DrawCircle', true, 'SetThetaLowerBound', true);
        
        % 添加总标题
        sgtitle(fig, sprintf('当前螺距: %.2f', d));
        
        % 获取当前图像
        frames(i) = getframe(fig);
    end
    
    % 写入视频
    for i = 1:num_frames
        writeVideo(v, frames(i));
    end
    
    % 更新进度条
    elapsed_time = toc(start_time); % 计算已用时间
    remaining_time = elapsed_time * (num_batches - batch) / batch; % 估计剩余时间
    waitbar(batch / num_batches, h, sprintf('正在处理... (Elapsed: %.2f s, Remaining: %.2f s)', elapsed_time, remaining_time));
end

% 关闭进度条
close(h);

% 关闭视频对象
close(v);

% 关闭所有图窗对象
for k = 1:frames_per_batch
    close(figs(k));
end
end