%% plot time-weekday color map for total road
function plot_road_predictnorm(road_params,road_namestr)
	%road_params:struct array,rnum=288(5min),cum=8(7 days in week and total day for 8)
	%road_params(i,j):struct:f1-f9 = index_str's param (single)
	index_str = {'lowpredict','uppredict','std','cov','BI','MI','PR','lam_skew','lam_var'};
	for nth_wkday = 1:8
		for nth_index=1:length(index_str)
			eval(['road_',index_str{nth_index},'(nth_wkday,:) = horzcat(road_params(:,nth_wkday).',index_str{nth_index},');'])
		end
	end
		% eval sample: road_lowpredict(nth_wkday,:) = horzcat(road_params(:,nth_wkday).lowpredict);
		% road_lowpredict:rnum=8 weekdays(7 days in week and total day for 8),
		% cnum=288(5min), content = tt of total road
	%% plot color map for each index
	for nth_index=1:length(index_str)
% 		if ~(nth_index==1 || nth_index==2)
			eval(['road_',index_str{nth_index},' = (road_',index_str{nth_index},'-min(min(road_',index_str{nth_index},')))./(max(max(road_',index_str{nth_index},'))-min(min(road_',index_str{nth_index},')));'])
			% road_lowpredict = (road_lowpredict-min(min(road_lowpredict)))./(max(max(road_lowpredict))-min(min(road_lowpredict)));
% 		end
		
		eval(['figure(''Name'',''road_',index_str{nth_index},''');']);
		colormap('jet');
		% figure('Name','road_lowpredict');
		eval(['imagesc(road_',index_str{nth_index},');'])
		% imagesc(road_lowpredict);
		caxis([0,1]);
		colorbar;
        
        title([road_namestr,'_sumtt_',index_str{nth_index}],'Interpreter', 'none');
		xlabel('hour','Interpreter', 'none');
        set(gca,'xtick',[0,72,144,216,288],'xticklabel',[0,72,144,216,288]/12);
		ylabel('nth_wkday','Interpreter', 'none');
		% change here: 8 for total days
        set(gca,'ytick',1:7,'yticklabel',1:7);
        saveas(gcf,['.\pic_out_min\',road_namestr,'_sumtt_',index_str{nth_index},'_norm.png']);

	end
    %% plot total year index curve
	figure('Name',[road_namestr,'_index_compare']);
	ylim([0,1]);
    for nth_index = 1:length(index_str)
    	eval(['h = plot(1:288,road_',index_str{nth_index},'(8,:));'])
    	hold on;
    	% h = plot(1:288,road_lowpredict(8,:));
    end
    legend(index_str,'Interpreter', 'none');
	xlabel('hour','Interpreter', 'none');
    set(gca,'xtick',[0,72,144,216,288],'xticklabel',[0,72,144,216,288]/12);
	ylabel('unreliability or predictability','Interpreter', 'none');
	title([road_namestr,'_index_compare'],'Interpreter', 'none');
    saveas(gcf,['.\pic_out_min\',road_namestr,'_index_compare','_norm.png']);
    hold off;
end

