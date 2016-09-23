--1.create south3th_ring_sn table
drop table south3th_ring_sn;
create table south3th_ring_sn
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

--2.write south3th_ring_sn.ctl
	--infile,talbename,cname:change here
options(rows=100000,readsize=258000000,bindsize=258000000,parallel=true)
load data
infile 'g:\transport_research\predictability\data_gaode_year\south3th_ring_sn.txt'
into table south3th_ring_sn
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
sqlldr transport@localconnect/www123com control=g:\transport_research\predictability\data_gaode_year\south3th_ring_sn.ctl
--4.create index on frequent query col
create index timeIdx on south3th_ring_sn
(
	sj asc
);

--5.select very fast

select * from south3th_ring_sn
where sj>to_date('2016-01-01 00:00:00','yyyy-mm-dd hh24:mi:ss')
	and sj<to_date('2016-01-01 00:05:00','yyyy-mm-dd hh24:mi:ss');

	--select mesh roadid avgspeed
create table south3th_ring_sn_avgspeed as
select mesh,road_id,
		to_char(sj,'yyyy') year,
		to_char(sj,'mm') month,
		to_char(sj,'dd') day,
		ceil((to_number(to_char(sj,'hh24'))*60+to_number(to_char(sj,'mi')))/5) nth_5min,
		avg(abs(speed)) avg_speed
from south3th_ring_sn
group by mesh,road_id,
		to_char(sj,'yyyy'),
		to_char(sj,'mm'),
		to_char(sj,'dd'),
		ceil((to_number(to_char(sj,'hh24'))*60+to_number(to_char(sj,'mi')))/5)
order by mesh,road_id,year,month,day,nth_5min;

--6.sqlplus export big table to csv file

@g:\transport_research\predictability\data_gaode_year\frag_predict\south3th_ring_sn_oracle2csv.sql;
