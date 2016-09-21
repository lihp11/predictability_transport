%% calc avg_tt cellarray and tt_sum for each road
function [avg_tt,tt_sum] = calc_cube_road_time(num_fetch,tbname_speed)
	% num_fetch:num of each db fetch
	% tbname_speed:tablename from db,c1~c4:year,month,day,nth_5min,c5=speed,c6=nth_100m
	% avg_tt:cellarray,num=num of cube,avg_tt(i):array(288,517days of data),
    % content=tt of ith cube
    % tt_sum:array(288,517):content=tt of road
	setdbprefs('datareturnformat','numeric');
	db_trans = database('lhp_matlab','transport','www123com');
	eval(['curs_trans = exec(db_trans,''select * from ',tbname_speed,''');']);
		% curs_trans = exec(db_trans,'select * from changan_ew_avgspeed');
	curs_trans = fetch(curs_trans,num_fetch);	%skip 0

	tic;
	nth_fetch = 1;
	while (~strcmp(curs_trans.Data,'No Data'))	%curs_trans.Data=num or char
	    disp(['Dealing with ',num2str(nth_fetch),' cube_avgspeed fetch.']);
		data_curs = curs_trans.Data;
		%data_curs:rnum=num_fetch,c1=nth_100m,c2~c5:year,month,day,nth_5min,c6=speed,
		ymd = datetime(data_curs(:,2:4));
		% ymd:datetime vector:rownum=num_fetch
		past_days = days(ymd - datetime(2014,12,31));
		% past_days:rownum=num_fetch,c1=past days from 2014-12-31
		for nth_rec = 1:size(data_curs,1)
			link_sp(data_curs(nth_rec,1)).avgsp(data_curs(nth_rec,5),past_days(nth_rec))...
			=data_curs(nth_rec,6);
		% link_sp:cellarray,num=num of cube,link_sp(i):array(288,517days of data),
	    % content=avgspeed of ith cube
        end
        curs_trans = fetch(curs_trans,num_fetch);	%skip 0
        nth_fetch = nth_fetch+1;
	end

	%% calc each cube's and road's 288*571 tt
	for nth_cube = 1:length(link_sp)
		avg_speed = link_sp(nth_cube).avgsp;
	    %avg_speed:rnum=288,cnum=517num of days in data,content=avgspeed
	    cube_length = 100;

	    avg_speed = speedinterp(avg_speed);
	    avg_speed = avg_speed';
	    avg_speed = speedinterp(avg_speed);
	    avg_speed = avg_speed';

	    avg_tt{nth_cube} = 3.6*cube_length./avg_speed;
	    %avg_tt{nth_cube}:rnum=288,cnum=517num of days in data,content=tt(s)
	end
	%change here:total days
	tt_sum = zeros(288,517);
	%% calc total road time at every tod/dow
	for nth_cube = 1:length(link_sp)
		num_days = size(tt_sum,2);
		% single=num of total days in data
		cube_days = size(avg_tt{nth_cube},2);
		% single=num of tatal days in this cube
        if cube_days<num_days  % some link is too short
	        avg_tt{nth_cube}(:,(cube_days+1):num_days) = repmat(mean(avg_tt{nth_cube},2),1,num_days-cube_days);
	        % tt_sum:array size as avg_tt{nth_cube} (288*571),
	        % content=tt of total road at special tod/dow
        end
	        tt_sum = tt_sum+avg_tt{nth_cube};
	end
end