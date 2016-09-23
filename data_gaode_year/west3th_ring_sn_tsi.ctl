options(rows=100000,readsize=258000000,bindsize=258000000,parallel=true)
load data
infile 'g:\transport_research\predictability\west3th_ring_sn_tsi.txt'
into table west3th_ring_sn_tsi
replace
FIELDS TERMINATED BY ','
TRAILING NULLCOLS
(
		year ,
		month ,
		day ,
		nth_5min ,
		speed ,
		nth_100m
)