%% calc link's unreliability params
function param = calc_road_param(tt_sum,bin_length,mini,maxi,interval,alpha)
	tt_sum_w4 = tt_sum(:,1:7:end);
	tt_sum_w5 = tt_sum(:,2:7:end);
	tt_sum_w6 = tt_sum(:,3:7:end);
	tt_sum_w7 = tt_sum(:,4:7:end);
	tt_sum_w8 = tt_sum;	% all year includs all weekday
	tt_sum_w1 = tt_sum(:,5:7:end);
	tt_sum_w2 = tt_sum(:,6:7:end);
	tt_sum_w3 = tt_sum(:,7:7:end);
	for nth_5min = 1:288
	    disp(['Calc total road ',num2str(nth_5min),'th nth_5min.']);

	    % change here: 7 to 8 if want all year
		for nth_weekday = 1:8
	    	eval(['param(nth_5min,nth_weekday) = vec2unreliability(tt_sum_w',...
	    		num2str(nth_weekday),'(nth_5min,:),bin_length,mini,maxi,1,1.2);']);
		end
		% param(nth_5min,5) = vec2unreliability(tt_sum_w5(nth_5min,:),5,1,1.2);
		% total: param(nth_5min,8) = vec2unreliability(tt_sum_w8{nth_link}(nth_5min,:),5,1,1.2);
		
		%param:struct array:rnum=288,c1=mon,c2=tue,c3...c6=sat,c7=sun,c8=total
		%param(i,j):ith 5min's jth day's param outcom
		%function param = vec2unreliability(vector,bin_length,mini,maxi,interval,alpha) f1=lowpredict,f2=uppredict,
		% f3=std,f4=cov,f5=BI(buffer index),f6=MI(misery index),f7=probablity of tt>alpha*tt50
		% f8=lam_skew,f9=lam_var,f10=UIr
	end
end