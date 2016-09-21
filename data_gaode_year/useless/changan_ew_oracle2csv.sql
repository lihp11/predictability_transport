set colsep ,  
set feedback off  
set heading off  
set trimspool on
set numwidth 6
set newp none
set termout off
set arraysize 5000
spool c:\Users\lhp\Desktop\changan_ew_avgspeed.csv  
select mesh || ',' || road_id || ',' || year || ',' || month || ',' || day || ',' || nth_5min || ',' || avg_speed from CHANGAN_EW_AVGSPEED;  
spool off  
exit 