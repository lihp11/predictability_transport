%% plot link-time color map at nth_wkday
function plot_cube_predict(cubes,nth_wkday,road_namestr)
	index_str = {'lowpredict','uppredict','std','cov','BI','MI','PR','lam_skew','lam_var'};

	for nth_cube = 1:length(shuffled_link)
		
		for nth_index=1:length(index_str)
			eval(['link_',index_str{nth_index},'(:,nth_cube) = vertcat(shuffled_link(nth_cube).params(:,nth_wkday).',index_str{nth_index},');'])
		end
			% link_lowpredict(:,nth_cube) = vertcat(shuffled_link(nth_cube).params(:,nth_wkday).lowpredict);
		
		%lowpredict:rnum=num of links,cnum=288,content=lowpredict at nth_wkday
	end

	for nth_index=1:length(index_str)
		if ~(nth_index==1 || nth_index==2)
			eval(['link_',index_str{nth_index},' = link_',index_str{nth_index},'./max(max(link_',index_str{nth_index},'));'])
			% link_lowpredict = link_lowpredict./max(max(link_lowpredict));
		end
		eval(['figure(''Name'',''link_',index_str{nth_index},''');']);
		colormap('jet');
		% figure('Name','link_lowpredict');
		eval(['imagesc(link_',index_str{nth_index},');'])
		% imagesc(link_lowpredict);
		caxis([0,1]);
		colorbar;
		xlabel('nth_cube','Interpreter', 'none');
        set(gca,'ytick',[0,72,144,216,288],'yticklabel',[0,72,144,216,288]/12);
		ylabel('nth_5min','Interpreter', 'none');
        title([road_namestr,'_',num2str(nth_wkday),'thwkd_',index_str{nth_index}],'Interpreter', 'none');
        saveas(gcf,['.\output_pic\',road_namestr,'_',num2str(nth_wkday),'thwkd_',index_str{nth_index},'.png']);
	end

end