% 读取 Excel 文件
filename = './附件/result1.xlsx';
opts = detectImportOptions(filename, 'Sheet', '位置');
opts.VariableNamingRule = 'preserve';
position_data = readtable(filename, opts);

opts = detectImportOptions(filename, 'Sheet', '速度');
opts.VariableNamingRule = 'preserve';
speed_data = readtable(filename, opts);

% 定义时间范围
time_range = 0:1:300;

% 初始化结果表格
num_points = 224;
num_time_steps = length(time_range);
position_result = cell(num_points * 2, num_time_steps);
speed_result = cell(num_points, num_time_steps);

% 计算每个时间点的角度和速度
for t = time_range
    % 计算角度
    theta_list = calculate_angles(t);
    
    % 计算速度
    speed_list = calculate_speeds(theta_list);
    
    % 定义螺线参数
    b = 55 / (2 * pi);
    
    % 初始化 x 和 y 坐标列表
    x_list = zeros(length(theta_list), 1);
    y_list = zeros(length(theta_list), 1);
    
    % 将极坐标转换为笛卡尔坐标
    for i = 1:length(theta_list)
        r = b * theta_list(i);
        x_list(i) = r * cos(theta_list(i));
        y_list(i) = r * sin(theta_list(i));
    end
    
    % 将坐标和速度转换为米
    x_list = x_list / 100;
    y_list = y_list / 100;
    speed_list = speed_list / 100;
    
    % 填入数据到结果表格中
    for i = 1:length(x_list)
        position_result{2*i-1, t+1} = x_list(i); % 填入横坐标x (m)
        position_result{2*i, t+1} = y_list(i); % 填入纵坐标y (m)
        speed_result{i, t+1} = speed_list(i); % 填入速度 (m/s)
    end
end

% 将 double 数组转换为 cell 数组
position_result_cell = num2cell(position_result);
speed_result_cell = num2cell(speed_result);

% 填入数据到原表格中
position_data{1:448, 2:end} = position_result_cell; % 填入位置数据
speed_data{1:224, 2:end} = speed_result_cell; % 填入速度数据

% 将结果写回到 Excel 文件
writetable(position_data, 'result1.xlsx', 'Sheet', '位置');
writetable(speed_data, 'result1.xlsx', 'Sheet', '速度');