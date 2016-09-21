options(rows=100000,readsize=258000000,bindsize=258000000,parallel=true)
load data
infile 'g:\transport_research\ø…‘§≤‚–‘\north4th_ring_ew.txt'
into table north4th_ring_ew
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