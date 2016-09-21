-- add col for bigtable and create smalltable
--1.create a small changan_ew table
drop table changan_ew_sam;
create table changan_ew_sam as
select * from changan_ew where rownum<100000;
--2.add col 'nth_100m' for big table
alter table changan_ew_sam add nth_100m number(4,0);
--3 create small table for nth_100m
drop table changan_ew_sam100index;
create table changan_ew_sam100index(
	nth_100m number(4,0)
);
--4.cmd sqlloader nth_100m
sqlldr transport@localconnect/www123com control=g:\transport_research\可预测性\高德全年数据\changan_ew_loadindex.ctl
-- --5.update big table using small table (bug)
-- update changan_ew_sam a ,changan_ew_sam100index b
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

--merge small table into big table
create table changan_ew_tt as
select a.sj,a.speed,b.nth_100m from
	(select rownum as lineid,sj,speed from changan_ew_sam) a,
	(select rownum as lineid,nth_100m from changan_ew_sam100index) b
where a.lineid = b.lineid;
