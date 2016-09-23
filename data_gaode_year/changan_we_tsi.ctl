options(rows=100000,readsize=258000000,bindsize=258000000,parallel=true)
load data
infile 'g:\transport_research\predictability\changan_we_tsi.txt'
into table changan_we_tsi
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