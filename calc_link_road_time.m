%% calc link's time and road's time
function [avg_tt,tt_sum,shuffled_link] = calc_link_road_time(data_source,shuffled_link)
	% data_source:rownum=many,c1=mesh,c2=roadid,c3=year,
	%c4=month,c5=day,c6=nth_minute,c7=speed
	%shuffled_link: struct array:1-longlat(array),2-mesh(num),3-road_id
	%4-node_start,5-node_end,6-road_length
	% output:(1)avg_tt:cellarray,num=num of link,avg_tt(i):array(288,577),
	% content=tt of ith link;(2)tt_sum:array(288,571):content=tt of road
	%(3)shuffled_link: struct array:1-longlat(array),2-mesh(num),3-road_id
	%4-node_start,5-node_end,6-road_length,7-avgspeed
	
	%% calc past days
	ymd = datetime(data_source(:,3:5));
	% ymd:datetime vector:rownum=many
	past_days = days(ymd - datetime(2014,12,31));
	% past_days:rownum=many,c1=past days from 2014-12-31
	nth_5min = data_source(:,6);
	% nth_5min:rownum=many,c1=num of 5 min in one day (first=1)

	for nth_rec = 1:length(data_source)
	    if (mod(nth_rec,10000)==0)
	    	disp(['Calc ',num2str(nth_rec),' records.']);
	    end
		link_index = find((vertcat(shuffled_link.mesh)==data_source(nth_rec,1) & ...
							vertcat(shuffled_link.road_id)==data_source(nth_rec,2)),1);
						% when find link_index,1 means stop
		shuffled_link(link_index).avgspeed(nth_5min(nth_rec),past_days(nth_rec)) = ...
			data_source(nth_rec,7);
	    %shuffled_link(link_index).avgspeed:rnum=288,cnum=517num of days in data,content=avgspeed
	end

	%% calc each link's and road's 288*571 tt 
	for nth_link = 1:length(shuffled_link)
		avg_speed = shuffled_link(nth_link).avgspeed;
	    %avg_speed:rnum=288,cnum=517num of days in data,content=avgspeed
	    road_length = shuffled_link(nth_link).road_length;

	    avg_speed = speedinterp(avg_speed);
	    avg_speed = avg_speed';
	    avg_speed = speedinterp(avg_speed);
	    avg_speed = avg_speed';

	    avg_tt{nth_link} = 3.6*road_length./avg_speed;
	    %avg_tt{nth_link}:rnum=288,cnum=517num of days in data,content=tt(s)
	end
	
	tt_sum = zeros(size(avg_tt{nth_link}));
	%% calc total road time at every tod/dow
	for nth_link = 1:length(shuffled_link)
        if ~isempty(avg_tt{nth_link})   % some link is too short
            tt_sum = tt_sum + avg_tt{nth_link};
            % tt_sum:array size as avg_tt{nth_link} (288*571),
            % content=tt of total road at special tod/dow
        end
	end

end