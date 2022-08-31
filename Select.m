function population=Select(population,offspring,N)
% 本函数对每一代种群中的染色体进行选择，以进行后面的交叉和变异

joint = [population,offspring];
objs = [joint.objs]';
cons = [joint.cons]';

[~,index] = sortrows([cons,objs]);

joint = joint(index);

% 删除重复个体
del = [];
for i=1:length(joint)-1
    if find(i==del)
        continue;
    end
   for j=i+1:length(joint)
       if isequal(joint(i).decs,joint(j).decs)
          del = [del j]; 
       end
   end
end
joint(del) = [];

population = joint(1:N);