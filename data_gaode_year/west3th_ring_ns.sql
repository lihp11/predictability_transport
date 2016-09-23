--1.create west3th_ring_ns table
drop table west3th_ring_ns;
create table west3th_ring_ns
	(
		trace_id varchar2(50),
		user_id varchar2(30),
		sj date,
		longtitude number(15,6),
		latitude number(15,6),
		speed number(8,2),
		mesh varchar2(10),
		road_id varchar2(10)
	);

--2.write west3th_ring_ns.ctl
	--infile,talbename,cname:change here
options(rows=100000,readsize=258000000,bindsize=258000000,parallel=true)
load data
infile 'g:\transport_research\predictability\data_gaode_year\west3th_ring_ns.txt'
into table west3th_ring_ns
replace
FIELDS TERMINATED BY ','
TRAILING NULLCOLS
(
	trace_id,
	user_id,
	sj date 'YYYYMMDDHH24MISS',
	longtitude,
	latitude,
	speed,
	mesh,
	road_id
)
--3.cmd   change here
sqlldr transport@localconnect/www123com control=g:\transport_research\predictability\data_gaode_year\west3th_ring_ns.ctl


--use west3th_ring_ns_tsi to compute avgspeed

--1 create table west3th_ring_ns_tsi
drop table west3th_ring_ns_tsi;
create table west3th_ring_ns_tsi
	(
		year number(4,0),
		month number(2,0),
		day number(2,0),
		nth_5min number(3,0),
		speed number(5,2),
		nth_100m number(3,0)
		);

--2 cmd  change here
sqlldr transport@localconnect/www123com control=g:\transport_research\predictability\data_gaode_year\west3th_ring_ns_tsi.ctl
--3 calc avgspeed
drop table west3th_ring_ns_avgspeed;
create table west3th_ring_ns_avgspeed as
	select nth_100m,
			year,
			month,
			day,
			nth_5min,
			avg(abs(speed)) avgspeed
	from west3th_ring_ns_tsi
	group by nth_100m,year,month,day,nth_5min
	order by nth_100m,year,month,day,nth_5min;
--4 drop points not in any cube or any 5min
delete from west3th_ring_ns_avgspeed where (nth_100m=0 or nth_5min=0 or year=2014) ;
commit;
