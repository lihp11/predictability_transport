function db_output_tsi(cube_longlat,tablename,num_fetch)
	% export txt files with %c1~c4:year,month,day,nth_5min,c5=speed,c6=nth_100m
	%cube_longlat:rnum=num of cube+1,c1=long,c2=lat
	%tablename:str=sql tablename
	%num_fetch:single=num of fetch
    tablename = link_matname;
	%% use odbc and cursor
	setdbprefs('datareturnformat','numeric');
	db_trans = database('lhp_matlab','transport','www123com');
	
	eval(['curs_trans = exec(db_trans,''select speed,longtitude,latitude from ',tablename,''');']);
	% curs_trans = exec(db_trans,'select speed,longtitude,latitude from changan_ew');
	for i=1:2488
        i
		curs_trans = fetch(curs_trans,num_fetch);	%skip 0
	end
	setdbprefs('datareturnformat','cellarray');
	eval(['curs_time = exec(db_trans,''select sj from ',tablename,''');']);
	% curs_time = exec(db_trans,'select sj from changan_ew');
	for i=1:2488
        i
		curs_time = fetch(curs_time,num_fetch); 	%skip 0
	end

	tic;
	nth_fetch = 1;
	while (~strcmp(curs_trans.Data,'No Data'))	%curs_trans.Data=num or char
	    disp(['Dealing with ',num2str(nth_fetch),' speed fetch.']);
		data_curs = curs_trans.Data;
		%data_curs:rnum=num_fetch,cnum=2,c1=speed,c2=long,c3=lat
		
		%% calc cubeindex
		index_curs = get_fragindex(data_curs(:,2:3),cube_longlat);
		%index_curs:rnum=num_fetch,c1=index of curs's data
		speed_nth100m = [data_curs(:,1),index_curs];
		%speed_nth100m:rnum=num_fetch,c1=speed,c2=nth_100m

	    disp(['Dealing with ',num2str(nth_fetch),' time fetch.']);
		time_curs = curs_time.Data;
		%time_curs:cellarray,rnum=num_fetch,c1=timestr(eg'2015-01-01 00:06:15.0')
		time_vec = datevec(time_curs,'yyyy-mm-dd HH:MM:SS');
		%time_vec:array,rnum=num_fetch,c1=year,c2=month,c3=day,c4=hour,c5=min,c6=s
		time_vec = [time_vec(:,1:3),ceil((time_vec(:,4)*60+time_vec(:,5))/5)];
		%time_vec:array,rnum=num_fetch,c1=year,c2=month,c3=day,c4=nth_5min

		disp(['Dealing with ',num2str(nth_fetch),' txt file.']);
		eval(['dlmwrite(''',tablename,'_tsi.txt'',[time_vec,speed_nth100m],''-append'');']);
		% dlmwrite('changan_ew_tsindex1.txt',[time_vec,speed_nth100m],'-append');
		%c1~c4:year,month,day,nth_5min,c5=speed,c6=nth_100m
		toc;
    	setdbprefs('datareturnformat','numeric');
		curs_trans = fetch(curs_trans,num_fetch);	%iter
    	setdbprefs('datareturnformat','cellarray');
		curs_time = fetch(curs_time,num_fetch); 	%iter
		nth_fetch = nth_fetch+1;
	end

	close(curs_trans);
	close(db_trans);
	toc;

end

syms x;
y = -(x*log2(x)+(1-x)*log2(1-x))+(1-x)*log2(20);
ezplot(y);






