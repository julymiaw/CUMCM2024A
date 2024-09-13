% 读取 Excel 文件
filename = './附件/result2.xlsx';
opts = detectImportOptions(filename);
opts.VariableNamingRule = 'preserve';
data = readtable(filename, opts);

t_end = find_collision_time();

% 使用 calculate_angles 函数计算角度
theta_list = calculate_angles(t_end);

% 使用 calculate_speeds 函数计算速度
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

% 将 double 数组转换为 cell 数组
x_list_cell = num2cell(x_list);
y_list_cell = num2cell(y_list);
speed_list_cell = num2cell(speed_list');

% 填入数据到原表格中
data{1:224, 2} = x_list_cell; % 填入横坐标x (m)
data{1:224, 3} = y_list_cell; % 填入纵坐标y (m)
data{1:224, 4} = speed_list_cell; % 填入速度 (m/s)

% 将结果写回到当前文件夹下的新 Excel 文件
writetable(data, 'result2.xlsx');