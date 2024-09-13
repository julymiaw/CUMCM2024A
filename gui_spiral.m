clear;close all;
figure('Name','动态螺线','Position',[100, 100, 800, 800]);
axes = axes('Units','pixels','Position',[100, 100, 600, 600]);
slider = uicontrol('Style','slider','Position',[100,20,600,20],...
    'Min',0,'Max',432.8779,'Value',0);
set(slider,'Callback',{@slider_callback,axes});
function slider_callback(source, ~, axes)
t = get(source,'Value');
b = 55 / (2 * pi);
theta_list = calculate_angles(t);
plot_spiral(b, theta_list, axes);
end
b = 55 / (2 * pi);
theta_list = calculate_angles(0);
plot_spiral(b, theta_list, axes)