%% calc cube's unreliability params
function cubes = calc_cube_param(cubes,avg_tt,bin_length,mini,maxi,interval,alpha)
	% input:(1)avg_tt:cellarray,num=num of cube,avg_tt(i):array(288,577),
	% content=tt of ith cube;(2)cubes: struct array:1-[]
	% mini:vector,num = num of cubes,the num vector's min
	% maxi:vector,num = num of cubes,the num vector's max
	% interval: for lowpredict
	% alpha: used for calc f7:factor of tt50
	% output:(1)avg_tt:cellarray,num=num of cube,avg_tt(i):array(288,577),
	% content=tt of ith cube;(2)cubes: struct array:1--params
	for nth_cube = 1:length(cubes)
	    avg_tt_w4 = avg_tt{nth_cube}(:,1:7:end);
	    avg_tt_w5 = avg_tt{nth_cube}(:,2:7:end);
	    avg_tt_w6 = avg_tt{nth_cube}(:,3:7:end);
	    avg_tt_w7 = avg_tt{nth_cube}(:,4:7:end);
	    avg_tt_w8 = avg_tt{nth_cube};   % all year includs all weekday
	    avg_tt_w1 = avg_tt{nth_cube}(:,5:7:end);
	    avg_tt_w2 = avg_tt{nth_cube}(:,6:7:end);
	    avg_tt_w3 = avg_tt{nth_cube}(:,7:7:end);
	        % calc index for each mesh roadid
	    for nth_5min = 1:288
	        disp(['Calc ',num2str(nth_cube),'th cube ',num2str(nth_5min),'th nth_5min.']);

	        % change here: 7 to 8 if want all year
	        for nth_weekday = 1:7
	            eval(['param(nth_5min,nth_weekday) = vec2unreliability(avg_tt_w',...
	                num2str(nth_weekday),'(nth_5min,:),bin_length,mini(nth_cube),maxi(nth_cube),interval,alpha);']);
	        end
	        % param(nth_5min,5) = vec2unreliability(avg_tt_w5,bin_length,mini(nth_cube),maxi(nth_cube),interval,alpha)
	        
	        %param:struct array:rnum=288,c1=mon,c2=tue,c3...c6=sat,c7=sun,c8=total
	        %param(i,j):ith 5min's jth day's param outcom
	        %function param = vec2unreliability(vector,n,interval,alpha) f1=lowpredict,f2=uppredict,
	        % f3=std,f4=cov,f5=BI(buffer index),f6=MI(misery index),f7=probablity of tt>alpha*tt50
	        % f8=lam_skew,f9=lam_var,f10=UIr
	    end
	    cubes(nth_cube).params = param;
	end
end