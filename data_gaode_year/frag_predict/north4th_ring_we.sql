--1.create north4th_ring_we table
drop table north4th_ring_we;
create table north4th_ring_we
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

--2.write north4th_ring_we.ctl
	--infile,talbename,cname:change here
options(rows=100000,readsize=258000000,bindsize=258000000,parallel=true)
load data
infile 'g:\transport_research\predictability\data_gaode_year\north4th_ring_we.txt'
into table north4th_ring_we
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
sqlldr transport@localconnect/www123com control=g:\transport_research\predictability\data_gaode_year\north4th_ring_we.ctl
--4.create index on frequent query col
create index timeIdx on north4th_ring_we
(
	sj asc
);

--5.select very fast

select * from north4th_ring_we
where sj>to_date('2016-01-01 00:00:00','yyyy-mm-dd hh24:mi:ss')
	and sj<to_date('2016-01-01 00:05:00','yyyy-mm-dd hh24:mi:ss');

	--select mesh roadid avgspeed
create table north4th_ring_we_avgspeed as
select mesh,road_id,
		to_char(sj,'yyyy') year,
		to_char(sj,'mm') month,
		to_char(sj,'dd') day,
		ceil((to_number(to_char(sj,'hh24'))*60+to_number(to_char(sj,'mi')))/5) nth_5min,
		avg(abs(speed)) avg_speed
from north4th_ring_we
group by mesh,road_id,
		to_char(sj,'yyyy'),
		to_char(sj,'mm'),
		to_char(sj,'dd'),
		ceil((to_number(to_char(sj,'hh24'))*60+to_number(to_char(sj,'mi')))/5)
order by mesh,road_id,year,month,day,nth_5min;

--6.sqlplus export big table to csv file

@g:\transport_research\predictability\data_gaode_year\frag_predict\north4th_ring_we_oracle2csv.sql;
