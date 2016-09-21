--1.create changan_ew table
drop table changan_ew;
create table changan_ew
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

--2.write changan_ew.ctl
	--infile,talbename,cname:change here
options(rows=100000,readsize=258000000,bindsize=258000000,parallel=true)
load data
infile 'g:\transport_research\可预测性\高德全年数据\changan_ew.txt'
into table changan_ew
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
sqlldr transport@localconnect/www123com control=g:\transport_research\可预测性\高德全年数据\changan_ew.ctl
--4.create index on frequent query col
create index timeIdx on changan_ew
(
	sj asc
);

--5.select very fast

select * from changan_ew
where sj>to_date('2016-01-01 00:00:00','yyyy-mm-dd hh24:mi:ss')
	and sj<to_date('2016-01-01 00:05:00','yyyy-mm-dd hh24:mi:ss');

	--select mesh roadid avgspeed
create table changan_ew_avgspeed as
select mesh,road_id,
		to_char(sj,'yyyy') year,
		to_char(sj,'mm') month,
		to_char(sj,'dd') day,
		ceil((to_number(to_char(sj,'hh24'))*60+to_number(to_char(sj,'mi')))/5) nth_5min,
		avg(abs(speed)) avg_speed
from changan_ew
group by mesh,road_id,
		to_char(sj,'yyyy'),
		to_char(sj,'mm'),
		to_char(sj,'dd'),
		ceil((to_number(to_char(sj,'hh24'))*60+to_number(to_char(sj,'mi')))/5)
order by mesh,road_id,year,month,day,nth_5min;

--6.sqlplus export big table to csv file

@g:\transport_research\可预测性\高德全年数据\changan_ew_oracle2csv.sql;

		
-- add col for bigtable and create smalltable
--1 add col 'nth_100m' for big table
alter table changan_ew add nth_100m number(4,0);
--3 create small table for nth_100m
drop table changan_ew100index;
create table changan_ew100index(
	nth_100m number(4,0)
);
--4.cmd sqlloader nth_100m
sqlldr transport@localconnect/www123com control=g:\transport_research\可预测性\高德全年数据\changan_ew_loadindex.ctl
-- --5.update big table using small table (bug)
-- update changan_ew a ,changan_ew100index b
-- set a.nth_100m=b.nth_100m;

--expand existing tablespace (as sysdba)
--1 view tablespace name and file location
select tablespace_name, file_id, file_name,
round(bytes/(1024*1024),0) total_space
from dba_data_files
order by tablespace_name
--2 expand the user tablespace
alter database datafile 'F:\APP\LHP\ORADATA\LHPLOCAL\USERS01.DBF' resize 40000m
--3 set auto expanding
alter database datafile 'F:\APP\LHP\ORADATA\LHPLOCAL\USERS01.DBF'
autoextend on next 100m maxsize 100000m

--add new tablespace
--1 add datafile if origin tablespace is max
alter tablespace USERS
	add datafile 'F:\APP\LHP\ORADATA\LHPLOCAL\USERS02.DBF' size 30000m
--2 set auto expanding
alter database datafile 'F:\APP\LHP\ORADATA\LHPLOCAL\USERS02.DBF' resize 40000m
--3 view tablespace status
select a.tablespace_name,a.bytes/1024/1024 "sum MB",
(a.bytes-b.bytes)/1024/1024 "used MB",b.bytes/1024/1024 "free MB",
round (((a.bytes-b.bytes)/a.bytes)*100,2) "used%" from
(select tablespace_name,sum(bytes) bytes from dba_data_files group by tablespace_name) a,
(select tablespace_name,sum(bytes) bytes,max (bytes) largest from dba_free_space group by tablespace_name)b
where a.tablespace_name=b.tablespace_name
order by ((a.bytes-b.bytes)/a.bytes) desc;

--merge small table into big table (too slow)

--methond 1 (using table joining)
create table changan_ew_tt as
select a.sj,a.speed,b.nth_100m from
	(select rownum as lineid,sj,speed from changan_ew) a,
	(select rownum as lineid,nth_100m from changan_ew100index) b
where a.lineid = b.lineid;

--method 2 (using updating cursor)
declare
	cursor c_100index is
	select * from changan_ew_sam100index;
	v_100index changan_ew_sam.nth_100m%type;
	
	cursor c_changan is
	select * from changan_ew_sam for update of nth_100m;
	v_changan changan_ew_sam%rowtype;
begin
	open c_100index;
	open c_changan;
	loop
		fetch c_100index into v_100index;
		exit when c_100index%notfound;
		fetch c_changan into v_changan;	--just fetch is useful
		update changan_ew_sam set nth_100m = v_100index
			where current of c_changan;
	end loop;

end;

--delete some row or drop a column
delete from changan_ew_sam where speed is null;
commit;
alter table  CHANGAN_EW drop column nth_100m;
commit;

--use changan_ew_tsi to compute avgspeed

--1 create table changan_ew_tsi
drop table changan_ew_tsi;
create table changan_ew_tsi
	(
		year number(4,0),
		month number(2,0),
		day number(2,0),
		nth_5min number(3,0),
		speed number(5,2),
		nth_100m number(3,0)
		);

--2 cmd  change here
sqlldr transport@localconnect/www123com control=g:\transport_research\可预测性\高德全年数据\changan_ew_tsi.ctl
--3 calc avgspeed
drop table changan_ew_avgspeed;
create table changan_ew_avgspeed as
	select nth_100m,
			year,
			month,
			day,
			nth_5min,
			avg(abs(speed)) avgspeed
	from changan_ew_tsi
	group by nth_100m,year,month,day,nth_5min
	order by nth_100m,year,month,day,nth_5min;
--4 drop points not in any cube or any 5min
delete from changan_ew_avgspeed where (nth_100m=0 or nth_5min=0 or year=2014) ;
commit;
