%% main script of prediciton for 100mcube
clc,clear,close all;

% change here!!
mif_folder = 'G:\transport_research\predictability\roadfrag_select\direction_select\';

% change here!!
link_matname = 'north4th_ring_we';

load([mif_folder,link_matname,'.mat']);
shuffled_link = link_connect(link);
%shuffled_link: struct array:1-longlat(array),2-mesh(num),3-road_id
%4-node_start,5-node_end,6-road_length
line_longlat = plot_line_road(shuffled_link,link_matname);
%array:c1=long,c2=lat,r_num=num of points+1

%get cube_longlat,change here
cube_length = 100;
cube_longlat = points_interp(line_longlat,cube_length);

% change here!!
num_fetch = 100000;

db_output_tsi(cube_longlat,link_matname,num_fetch);

% read tablename_avgspeed from db (after sqlldr)
% change here!!
tbname_speed = 'west3th_ring_sn_avgspeed';

%% calc_link_road_time
[avg_tt,tt_sum] = calc_cube_road_time(num_fetch,tbname_speed);
	% num_fetch:num of each db fetch
	% tbname_speed:tablename from db,c1~c4:year,month,day,nth_5min,c5=speed,c6=nth_100m
	% avg_tt:cellarray,num=num of cube,avg_tt(i):array(288,517days of data),
    % content=tt of ith cube
    % tt_sum:array(288,517):content=tt of road

        % %% calc_link_param if needed
        %     % change here : update bin_length,mini,maxi used for vector_to_string
        % for nth_cube = 1:(length(cube_longlat)-1)
        %     tt15_tt85 = quantile(avg_tt{nth_cube}(:),[0.15,0.85]);
        %     mini(nth_cube) = tt15_tt85(1);
        %     maxi(nth_cube) = tt15_tt85(2);

        %     % initiation of cubes
        %     cubes(nth_cube).param = [];
        % end
        % bin_length = 0.1;    % single = length of time(s) to discriminate symbols
        % interval = 1;
        % alpha = 1.2;


        % cubes = calc_cube_param(cubes,avg_tt,bin_length,mini,maxi,interval,alpha);
        %     % output:(1)avg_tt:cellarray,num=num of link,avg_tt(i):array(288,577),
        %     % content=tt of ith link;(2)cubes: struct array:1-params

        % %% plot cube-time color map at nth_wkday
        %     % change here: 7 to 8 if want all year
        % for nth_wkday = 1:7
        % 	plot_cube_predict(cubes,nth_wkday,link_matname);
        %     close all;
        % end

%% calc road unreliability param (front hour version)
% load([link_matname,'.mat']);    % temp calc for taking front 1hour
    % change here : update bin_length,mini,maxi used for vector_to_string
mini = 0;
maxi = 1500;
bin_length = 20/40*length(avg_tt);    % single = length of time(s) to discriminate symbols
interval = 1;
alpha = 1.2;

param = calc_road_param(tt_sum,bin_length,mini,maxi,interval,alpha);
save([link_matname,'.mat'],'avg_tt','tt_sum','link_matname','param');

%% plot road nth_weekday-nth_5min index colormap
plot_road_predict(param,link_matname);
plot_road_predictnorm(param,link_matname);


