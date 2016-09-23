options(rows=100000,readsize=258000000,bindsize=258000000,parallel=true)
load data
infile 'g:\transport_research\predictability\data_gaode_year\west3th_ring_sn.txt'
into table west3th_ring_sn
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