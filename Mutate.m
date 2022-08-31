function offspring=Mutate(population,state)
% ��������ɱ������
% population = Init(10);

global Global
N=length(population);

offspring = population;
for i=1:N
    p1 = population(i).decs;
    if rand < 0.8 % ����
        p2 = i;
        while p2==i
           p2 = randperm(N,1); 
        end
        p2 = population(p2).decs;
        pos = sort(randperm(Global.num_object,2)); %�����ѡ����λ�ý���Ƭ�ν���
        for j=pos(1):pos(2)
           if p1(j) ~= p2(j)
               ind = find(p1(1:Global.num_object)==p2(j));
               p1(ind) = p1(j);
               p1(j) = p2(j);
           end
        end
        
        p1(pos(1)+Global.num_object:pos(2)+Global.num_object) = p2(pos(1)+Global.num_object:pos(2)+Global.num_object);
    end
    
    if rand < 0.4 % ����
        pos = sort(randperm(Global.num_object,2)); %�����ѡ����λ�ý���Ƭ����ת
        tmp = p1;
        p1(pos(1):pos(2)) = tmp(pos(2):-1:pos(1));
        pos = pos + Global.num_object;
        p1(pos(1):pos(2)) = tmp(pos(2):-1:pos(1));
    end
    
    offspring(i).decs = p1;
end
offspring = CalObj(offspring);