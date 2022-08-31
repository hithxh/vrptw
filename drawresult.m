% close all

figure
global Global

% c_space = linspecer(Global.num_object);
c_space = colormap(jet(12));
for i=1:Global.num_object
    cur_object = bestsol.decs(i);
    cur_satellite = bestsol.satellite_list(i);
    ind_window = bestsol.index_window_guance(cur_object);
    
    subplot(4,3,cur_object)
    
    t_s = bestsol.time_start_guance(cur_object);
    t_e = bestsol.time_end_guance(cur_object);
    
    if t_s == 0 && t_e ==0
        continue;
    end
    
    t_s_window = Global.visible_window{cur_object,cur_satellite}(2*bestsol.index_window_guance(cur_object)-1);
    t_e_window = Global.visible_window{cur_object,cur_satellite}(2*bestsol.index_window_guance(cur_object));
    rec = [t_s_window,cur_satellite-0.1,t_e_window-t_s_window,0.2];
    rectangle('Position',rec,'LineWidth',0.5,'LineStyle','-','FaceColor',c_space(i,:),'Curvature',0.5);%draw every rectangle
%     for j=1:Global.num_visible_window(cur_object,cur_satellite)
%         t_s_window = Global.visible_window{cur_object,cur_satellite}(2*j-1);
%         t_e_window = Global.visible_window{cur_object,cur_satellite}(2*j);
%         rec = [t_s_window,cur_satellite-0.1,t_e_window-t_s_window,0.2];
%         rectangle('Position',rec,'LineWidth',0.5,'LineStyle','-','FaceColor',c_space(i,:),'Curvature',0.5);%draw every rectangle
%     end
    
    rec = [t_s,cur_satellite-0.25,t_e-t_s,0.5];
    rectangle('Position',rec,'LineWidth',0.5,'LineStyle','-','FaceColor',c_space(i,:),'Curvature',0.5);%draw every rectangle
    text(t_s+100,cur_satellite,num2str(cur_object),'FontWeight','Bold','fontsize',8);
    ylim([0,5])
    title(['Object ' num2str(cur_object)])
end

figure
for i=1:Global.num_object
    cur_object = bestsol.decs(i);
    cur_satellite = bestsol.satellite_list(i);
    ind_window = bestsol.index_window_guance(cur_object);
    
    t_s = bestsol.time_start_guance(cur_object);
    t_e = bestsol.time_end_guance(cur_object);
    
    t_s_window = Global.visible_window{cur_object,cur_satellite}(2*bestsol.index_window_guance(cur_object)-1);
    t_e_window = Global.visible_window{cur_object,cur_satellite}(2*bestsol.index_window_guance(cur_object));
    
    if t_s == 0 && t_e ==0
       continue; 
    end
    
    x = [t_s_window,t_e_window,t_e_window,t_s_window];
    y = [cur_satellite-0.02,cur_satellite-0.02,cur_satellite+0.02,cur_satellite+0.02]+i/50;
    patch(x,y,c_space(i,:),'facealpha',0.5);
    
    x = [t_s,t_e,t_e,t_s];
    y = [cur_satellite-0.1,cur_satellite-0.1,cur_satellite+0.1,cur_satellite+0.1]+i/50;

    patch(x,y,c_space(i,:),'facealpha',0.8);
    text(t_s+50,cur_satellite+i/50,num2str(cur_object),'FontWeight','Bold','fontsize',16);
    ylim([0,5])
end
for i=0.5:1:4.5
   line([min(bestsol.time_start_guance),max(bestsol.time_end_guance)],[i,i],'linestyle','-.') 
end