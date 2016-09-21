% TTT = load('.\cube_matrix_B_taipingqiaodajie_ns.mat');
CUBE_DATA = cube_matrix_B_temp2; 
cube_interval = 5;
intervals=24*60/cube_interval;
%分天的处理
nnnn = size(CUBE_DATA{3,1},1);

%taipingqiaodajie_ns
for i = 3:9
    CUBE_DATA{i,1}(23,:) = (CUBE_DATA{i,1}(22,:) + CUBE_DATA{i,1}(24,:))/2;
end
%taipingqiaodajie_sn
for i = 3:9
    CUBE_DATA{i,1}(10,:) = (CUBE_DATA{i,1}(9,:) + CUBE_DATA{i,1}(11,:))/2;
end
for i = 3:9
    CUBE_DATA{i,1}(13,:) = (CUBE_DATA{i,1}(12,:) + CUBE_DATA{i,1}(14,:))/2;
end
for i = 3:9
    CUBE_DATA{i,1}(22,:) = (CUBE_DATA{i,1}(21,:) + CUBE_DATA{i,1}(23,:))/2;
end
%jinrongdajie_ns
for i = 3:9
    CUBE_DATA{i,1}(2,:) = (CUBE_DATA{i,1}(1,:) + CUBE_DATA{i,1}(3,:))/2;
end
for i = 3:9
    CUBE_DATA{i,1}(9,:) = (CUBE_DATA{i,1}(8,:) + CUBE_DATA{i,1}(10,:))/2;
end
%jinrongdajie_sn
for i = 3:9
    CUBE_DATA{i,1}(4,:) = (CUBE_DATA{i,1}(3,:) + CUBE_DATA{i,1}(5,:))/2;
end
for i = 3:9
    CUBE_DATA{i,1}(11,:) = (CUBE_DATA{i,1}(10,:) + CUBE_DATA{i,1}(12,:))/2;
end
%nanbeilishi_ns
for i = 3:9
    CUBE_DATA{i,1}(3,:) = (CUBE_DATA{i,1}(2,:) + CUBE_DATA{i,1}(4,:))/2;
end
for i = 3:9
    CUBE_DATA{i,1}(18,:) = (CUBE_DATA{i,1}(20,:) - CUBE_DATA{i,1}(17,:))/3 + CUBE_DATA{i,1}(17,:);
    CUBE_DATA{i,1}(19,:) = (CUBE_DATA{i,1}(20,:) - CUBE_DATA{i,1}(17,:))/3*2 + CUBE_DATA{i,1}(17,:);
end
%nanbeilishi_sn
for i = 3:9
    CUBE_DATA{i,1}(11,:) = (CUBE_DATA{i,1}(13,:) - CUBE_DATA{i,1}(10,:))/3 + CUBE_DATA{i,1}(10,:);
    CUBE_DATA{i,1}(12,:) = (CUBE_DATA{i,1}(13,:) - CUBE_DATA{i,1}(10,:))/3*2 + CUBE_DATA{i,1}(10,:);
end


for dd=3:9 %1:month_day
    COLOR=zeros(nnnn,intervals);
    
    cmax = 80;
    cmin = 20;
    for i = 1:24*60/cube_interval
        for j = 1:nnnn
            if CUBE_DATA{dd,1}(j,i)==0
                COLOR(j,i) = nan;
            elseif CUBE_DATA{dd,1}(j,i)~=0
                CUBE_DATA{dd,1}(j,i)= min(CUBE_DATA{dd,1}(j,i),cmax);
                CUBE_DATA{dd,1}(j,i)= max(CUBE_DATA{dd,1}(j,i),cmin);
                COLOR(j,i) =100- CUBE_DATA{dd,1}(j,i);
            end
        end
    end
    
    COLOR_NEW=COLOR;
    start=1;
    final=nnnn;
    colortemp=COLOR_NEW(start:final,1:intervals);%COLOR_NEW(299:327,1:144)
    figure(dd)
    gcm = pcolor(1:24*60/cube_interval,1:size(colortemp,1),colortemp(1:end,1:intervals));
    
    hold on
    shading interp
    set(gcm, 'LineStyle','none');
    colormap('jet')
    
    caxis([cmin cmax])
    h=colorbar;
%     colorbar('YTick',...
%         [60:-10:0],'YTickLabel',{'0','10','20','30','40','50','60'})
    set(h,'ytick',[20 30 40 50 60 70 80]);
    set(h,'yticklabel',{'80','70','60','50','40','30','20'});

    set(gca,'xtick',[1 72 144 216 288]);
    set(gca,'xticklabel',{'0','6','12','18','24'});
% % % % % %     set(gca,'ytick',[ 5 22 33]);
% % % % % %     set(gca,'yticklabel',{'复兴门','阜成门','车公庄'});%'安定门','东直门桥下游',
    set(gcf,'unit','centimeters','position',[10 15 14.4 5.7]);
    % % ylabel('Hour (h)', 'FontName', 'Times New Roman', 'FontSize', 14);
    % % xlabel('Position (m)', 'FontName', 'Times New Roman', 'FontSize', 14);
    saveas(gcf,['.\erhuan_sn_12月',num2str(dd),'日.png']);
end










    