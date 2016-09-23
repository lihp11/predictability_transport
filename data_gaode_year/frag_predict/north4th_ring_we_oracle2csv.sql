set colsep ,  
set feedback off  
set heading off  
set trimspool on
set numwidth 6
set newp none
set termout off
set arraysize 5000
spool g:\transport_research\predictability\data_gaode_year\frag_predict\north4th_ring_we_avgspeed.csv  
select mesh || ',' || road_id || ',' || year || ',' || month || ',' || day || ',' || nth_5min || ',' || avg_speed from NORTH4TH_RING_WE_AVGSPEED;  
spool off  
exit 