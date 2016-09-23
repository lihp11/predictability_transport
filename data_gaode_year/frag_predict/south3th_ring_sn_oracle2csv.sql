set colsep ,  
set feedback off  
set heading off  
set trimspool on
set numwidth 6
set newp none
set termout off
set arraysize 5000
spool g:\transport_research\predictability\data_gaode_year\frag_predict\south3th_ring_ns_avgspeed.csv  
select mesh || ',' || road_id || ',' || year || ',' || month || ',' || day || ',' || nth_5min || ',' || avg_speed from SOUTH3TH_RING_NS_AVGSPEED;  
spool off  
exit 