function population = CalObj(population)
% population = Init(1);

global Global

N = length(population);

for i=1:N
    ind = population(i);
    object_list = ind.decs(1:Global.num_object);
    satellite_list = ind.decs(Global.num_object+1:end);
    
    satellite_next_release_time = zeros(1,Global.num_satellite); %����վ����һ�οɹ۲�ʱ��
    
    time_start_guance = zeros(1,Global.num_object); %��ʼ�۲�ʱ��
    time_end_guance = zeros(1,Global.num_object); %�����۲�ʱ��
    index_window_guance = zeros(1,Global.num_object); %�۲ⴰ�ڵı��
    cons = 0; %Υ��Լ�������
    
    for j = 1:Global.num_object
        cur_object = object_list(j); %��ǰ�۲�Ŀ��
        cur_satellite = satellite_list(j); %��ǰ�۲�Ŀ��ѡ��ĵ���վ
        
        % ���μ�鵱ǰ�۲�Ŀ��Ĺ۲�ʱ�䴰
        flag = 0;
        for m = 1:Global.num_visible_window(cur_object,cur_satellite)
            time_start = Global.visible_window{cur_object,cur_satellite}(2*m-1); %�۲ⴰ�ڵĿ�ʼʱ��
            time_end = Global.visible_window{cur_object,cur_satellite}(2*m); %�۲ⴰ�ڵĽ���ʱ��
            if satellite_next_release_time(cur_satellite) > time_end
                continue;
            end
            time_begin = max(satellite_next_release_time(cur_satellite),time_start);
            
            if time_begin < time_end - Global.sat_need_time(cur_object) %��ǰ�۲ⴰ�ڿ��������۲�
                time_start_guance(cur_object) = time_begin;
                time_end_guance(cur_object) = time_start_guance(cur_object) + Global.sat_need_time(cur_object);
                satellite_next_release_time(cur_satellite) = time_end_guance(cur_object) + 60; %���ǵķ�Ӧʱ��
                index_window_guance(cur_object) = m;
                flag=1;
                break;
            end
        end
        if flag == 0 %˵������۲�Ŀ��û�б����ŵ�����վ
            cons = cons + Global.sat_need_time(cur_object);
        end
    end
    
    %% ����Ŀ�꺯��
    T = max(time_end_guance);
    total_rank = 0;
    for j = 1:Global.num_object
        cur_object = object_list(j); %��ǰ�۲�Ŀ��
        cur_satellite = satellite_list(j); %��ǰ�۲�Ŀ��ѡ��ĵ���վ
        total_rank = total_rank + Global.rank_satellite(cur_satellite) * Global.rank_object(cur_object);
    end
    
    %% ����ֵ
    population(i).objs = T - 10*total_rank;
    population(i).cons = cons;
    population(i).time_start_guance = time_start_guance;
    population(i).time_end_guance = time_end_guance;
    population(i).satellite_list = satellite_list;
    population(i).index_window_guance = index_window_guance;
    population(i).satellite_next_release_time = satellite_next_release_time;
end