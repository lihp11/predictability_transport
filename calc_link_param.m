%% calc link's unreliability params
function shuffled_link = calc_link_param(shuffled_link,avg_tt,bin_length,mini,maxi,interval,alpha)
	% input:(1)avg_tt:cellarray,num=num of link,avg_tt(i):array(288,577),
	% content=tt of ith link;(2)shuffled_link: struct array:1-longlat(array)
	% ,2-mesh(num),3-road_id,4-node_start,5-node_end,6-road_length,7-avgspeed
	% bin_length: length of bin
	% mini:vector,num = num of links,the num vector's min
	% maxi:vector,num = num of links,the num vector's max
	% interval: for lowpredict
	% alpha: used for calc f7:factor of tt50
	% output:(1)avg_tt:cellarray,num=num of link,avg_tt(i):array(288,577),
	% content=tt of ith link;(2)shuffled_link: struct array:1-longlat(array)
	% ,2-mesh(num),3-road_id,4-node_start,5-node_end,6-road_length,7-avgspeed
	% 8-params
	for nth_link = 1:length(shuffled_link)
	    avg_tt_w4 = avg_tt{nth_link}(:,1:7:end);
	    avg_tt_w5 = avg_tt{nth_link}(:,2:7:end);
	    avg_tt_w6 = avg_tt{nth_link}(:,3:7:end);
	    avg_tt_w7 = avg_tt{nth_link}(:,4:7:end);
	    avg_tt_w8 = avg_tt{nth_link};   % all year includs all weekday
	    avg_tt_w1 = avg_tt{nth_link}(:,5:7:end);
	    avg_tt_w2 = avg_tt{nth_link}(:,6:7:end);
	    avg_tt_w3 = avg_tt{nth_link}(:,7:7:end);
	        % calc index for each mesh roadid
	    for nth_5min = 1:288
	        disp(['Calc ',num2str(nth_link),'th link ',num2str(nth_5min),'th nth_5min.']);

	        % change here: 7 to 8 if want all year
	        for nth_weekday = 1:7
	            eval(['param(nth_5min,nth_weekday) = vec2unreliability(avg_tt_w',...
	                num2str(nth_weekday),'(nth_5min,:),bin_length,mini(nth_link),maxi(nth_link),interval,alpha);']);
	        end
	        % param(nth_5min,5) = vec2unreliability(avg_tt_w5,bin_length,mini(nth_link),maxi(nth_link),interval,alpha)
	        
	        %param:struct array:rnum=288,c1=mon,c2=tue,c3...c6=sat,c7=sun,c8=total
	        %param(i,j):ith 5min's jth day's param outcom
	        %function param = vec2unreliability(vector,n,interval,alpha) f1=lowpredict,f2=uppredict,
	        % f3=std,f4=cov,f5=BI(buffer index),f6=MI(misery index),f7=probablity of tt>alpha*tt50
	        % f8=lam_skew,f9=lam_var,f10=UIr
	    end
	    shuffled_link(nth_link).params = param;
	end
end