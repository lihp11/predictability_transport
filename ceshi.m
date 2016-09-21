length(node_end(:,1)) == unique(length(node_end(:,1)));
A = link_to_ring(link);
A = points_interp(ring_longlat,100);

tic;
data_source = dlmread('G:\2015_Autumn\毕设\快速路提取\处理后外环gaode_2015_11_1.txt');
toc;
B = dailydata_to_tsstruct(data_source(:,1),data_source(:,2:3),data_source(:,4),...
                        A,5);
                    
index_frag = get_fragindex(data_source(:,2:3),A);
C = (struct2cell(B));
D = reshape(vertcat(B.avg_speed),288,503);

a(1,1).mat = magic(3);
a(1,2).mat = magic(3)+1;
a(2,1).mat = magic(3)+2;
a(2,2).mat = magic(3)+3;
D1 = [a.mat];
D2 = horzcat(a.mat);
D3 = vertcat(a.mat);
[d1,d2,d3,d4] = a.mat;
d5 = a.mat;


points=[0,0,0
        1,1,0
        1,1,3
        0,0,3];
f=[1 2 3 4];
color = (1:4)';
colormap('jet');   %n*1 or n*3
patch('Faces',f,'vertices',points,'FaceVertexCData',color,'FaceColor','flat')


tsplot(A,D);

mif_folder = 'g:\transport_research\可预测性\路段选择\路段分向选择\';
mid_cnum = [1,3,4,5,6];	
midmif_to_longlat(mif_folder,mid_cnum);

link_matnmae = 'west3th_ring_sn';
load([mif_folder,link_matnmae,'.mat']);


@g:\transport_research\可预测性\高德全年数据\oracle2csv.sql;

X = magic(6);
k = find(X,4,'last');
t = datetime([1991,1992,1993,1994],[12,12,12,11],[1,2,3,4]);
NumDays = daysact('7-dec-2002',  '25-dec-2002');

a = vec2unreliability(avg_tt(1,:),5,1,1.2);

syms x;
y = -(x*log(x)/log(2)+(1-x)*log(1-x)/log(2))+(1-x)*log(50-1)/log(2);
ezplot(y);

b = 'a'+3;
b = char(b);
b = uint8('a'); 

s = vector_to_string(rand(1,100),3,0.1,0.9);
t_min = min(min(tt_sum));
t_max = max(max(tt_sum));
a = tt_sum(:);
quant_t = quantile(a,0.15:0.1:0.85);
hist(a,300:60:900)

s = vector_to_string(tt_sum(110,:),20,0,2000);
upper = predict_upperbound(s);

s = which('classpath.txt');  % F:\Program Files\MATLAB\R2015b\toolbox\local\classpath.txt
conn_jdbc = database('localconnect','transport','www123com',...
    'oracle.jdbc.driver.OracleDriver','jdbc:oracle:thin:@localhost:1521:');
ping(conn_jdbc)




conna = database('lhp_matlab','transport','www123com');
setdbprefs('datareturnformat','cellarray');
curs1 = exec(conna,'select * from changan_ew where rownum<104');
curs = fetch(curs1,20);
Data = curs.Data;












