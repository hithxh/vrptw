%% ��ջ���
clc
clear
close all

%% ģ�Ͳ���
global Global
Global.num_satellite = 4;    %������
Global.num_object = 12;    %�۲�Ŀ����

%% ��ȡ����
% opts.SelectedVariableNames = 1:2;
a = readmatrix('data/G.csv','Range','B2:B5');
Global.rank_satellite = a';%�������ȼ����б�/����
a = readmatrix('data/P.csv','Range','B2:B13');
Global.rank_object = a';%�۲�Ŀ�����ȼ����б�/����
a = readmatrix('data/need.csv','Range','B2:B13');
Global.sat_need_time = a';%�۲�Ŀ��۲�ʱ�����б�/����

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

%% �㷨����
maxgen = 300;
popsize = 150;
population = Init(popsize);

trace_obj = zeros(1,maxgen);
trace_con = zeros(1,maxgen);

%% ������ʼ
for i=1:maxgen
    % �������
    offspring = Mutate(population,i/maxgen);
    % ��ѡ�¸���
    population = Select(population,offspring,popsize);
    
    % ��¼��Ϣ
    bestobj = population(1).objs;
    trace_obj(i) = bestobj;
    trace_con(i) = population(1).cons;
    
    if ~mod(i,10)
        cons = [population.cons];
        num = sum(cons==0);
        avgcons = mean(cons);
        disp(['��' num2str(i) '��������Լ������������' num2str(num), '����Ѹ��壺' num2str(bestobj)])
    end
end
%��������

%% չʾ���
figure
plot(trace_obj)
title('����Ŀ��ֵ����ʾ��ͼ')

bestsol = population(1);
drawresult