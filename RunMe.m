%% 清空环境
clc
clear
close all

%% 模型参数
global Global
Global.num_satellite = 4;    %卫星数
Global.num_object = 12;    %观测目标数

%% 读取数据
% opts.SelectedVariableNames = 1:2;
a = readmatrix('data/G.csv','Range','B2:B5');
Global.rank_satellite = a';%卫星优先级（列表/矩阵）
a = readmatrix('data/P.csv','Range','B2:B13');
Global.rank_object = a';%观测目标优先级（列表/矩阵）
a = readmatrix('data/need.csv','Range','B2:B13');
Global.sat_need_time = a';%观测目标观测时长（列表/矩阵）

Global.visible_window = cell(Global.num_object,Global.num_satellite);
Global.num_visible_window = zeros(Global.num_object,Global.num_satellite);
for i=1:Global.num_object
    datfile = ['data/sat' num2str(i) '.csv'];
    a = readmatrix(datfile,'Range','B1:M4');
    
    for j=1:Global.num_satellite
        index = a(j,:)~=0;
        Global.visible_window{i,j} = a(j,index);
        Global.num_visible_window(i,j) = numel(Global.visible_window{i,j})/2;
    end
end

%% 算法参数
maxgen = 300;
popsize = 150;
population = Init(popsize);

trace_obj = zeros(1,maxgen);
trace_con = zeros(1,maxgen);

%% 进化开始
for i=1:maxgen
    % 交叉变异
    offspring = Mutate(population,i/maxgen);
    % 挑选新个体
    population = Select(population,offspring,popsize);
    
    % 记录信息
    bestobj = population(1).objs;
    trace_obj(i) = bestobj;
    trace_con(i) = population(1).cons;
    
    if ~mod(i,10)
        cons = [population.cons];
        num = sum(cons==0);
        avgcons = mean(cons);
        disp(['第' num2str(i) '代，满足约束个体数量：' num2str(num), '，最佳个体：' num2str(bestobj)])
    end
end
%进化结束

%% 展示结果
figure
plot(trace_obj)
title('最优目标值进化示意图')

bestsol = population(1);
drawresult