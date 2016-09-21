%%CPI,房价,天气,上证,交通路网指标

%% 数据读取
clc,clear,close all;
bj_city_vf = xlsread('g:\2015_Autumn\transport_research\可预测性\天津季度报告数据需求_每天6点.xlsx',1,'E486:E547'); 
tj_city_vf = xlsread('g:\2015_Autumn\transport_research\可预测性\天津季度报告数据需求_每天6点.xlsx',1,'E1032:E1093');
bj_city_vm = xlsread('g:\2015_Autumn\transport_research\可预测性\天津季度报告数据需求_每天6点.xlsx',1,'F486:F547'); 
tj_city_vm = xlsread('g:\2015_Autumn\transport_research\可预测性\天津季度报告数据需求_每天6点.xlsx',1,'F1032:F1093'); 
bj_city_conjestion_index = xlsread('g:\2015_Autumn\transport_research\可预测性\天津季度报告数据需求_每天6点.xlsx',1,'G486:G547'); 
tj_city_conjestion_index = xlsread('g:\2015_Autumn\transport_research\可预测性\天津季度报告数据需求_每天6点.xlsx',1,'G1032:G1093'); 
disp('北京天津城市交通指标读取完毕！');


tj_urban_vf = xlsread('g:\2015_Autumn\transport_research\可预测性\天津季度报告数据需求_每天6点.xlsx',2,'C486:C547'); 
tj_urban_vm = xlsread('g:\2015_Autumn\transport_research\可预测性\天津季度报告数据需求_每天6点.xlsx',2,'D486:D547'); 
tj_urban_conjestion_index = xlsread('g:\2015_Autumn\transport_research\可预测性\天津季度报告数据需求_每天6点.xlsx',2,'E486:E547'); 
disp('天津城六区交通指标读取完毕！');

tj_heping_vf = xlsread('g:\2015_Autumn\transport_research\可预测性\天津季度报告数据需求_每天6点.xlsx',3,'F486:F547'); 
tj_heping_vm = xlsread('g:\2015_Autumn\transport_research\可预测性\天津季度报告数据需求_每天6点.xlsx',3,'G486:G547'); 
tj_heping_conjestion_index = xlsread('g:\2015_Autumn\transport_research\可预测性\天津季度报告数据需求_每天6点.xlsx',3,'H486:H547'); 
disp('天津和平区交通指标读取完毕！');

tj_hebei_vf = xlsread('g:\2015_Autumn\transport_research\可预测性\天津季度报告数据需求_每天6点.xlsx',3,'F2670:F2731'); 
tj_hebei_vm = xlsread('g:\2015_Autumn\transport_research\可预测性\天津季度报告数据需求_每天6点.xlsx',3,'G2670:G2731'); 
tj_hebei_conjestion_index = xlsread('g:\2015_Autumn\transport_research\可预测性\天津季度报告数据需求_每天6点.xlsx',3,'H2670:H2731'); 
disp('天津河北区交通指标读取完毕！');

tj_hedong_vf = xlsread('g:\2015_Autumn\transport_research\可预测性\天津季度报告数据需求_每天6点.xlsx',3,'F1032:F1093'); 
tj_hedong_vm = xlsread('g:\2015_Autumn\transport_research\可预测性\天津季度报告数据需求_每天6点.xlsx',3,'G1032:G1093'); 
tj_hedong_conjestion_index = xlsread('g:\2015_Autumn\transport_research\可预测性\天津季度报告数据需求_每天6点.xlsx',3,'H1032:H1093'); 
disp('天津河东区交通指标读取完毕！');

tj_hexi_vf = xlsread('g:\2015_Autumn\transport_research\可预测性\天津季度报告数据需求_每天6点.xlsx',3,'F1578:F1639'); 
tj_hexi_vm = xlsread('g:\2015_Autumn\transport_research\可预测性\天津季度报告数据需求_每天6点.xlsx',3,'G1578:G1639'); 
tj_hexi_conjestion_index = xlsread('g:\2015_Autumn\transport_research\可预测性\天津季度报告数据需求_每天6点.xlsx',3,'H1578:H1639'); 
disp('天津河西区交通指标读取完毕！');

tj_hongqiao_vf = xlsread('g:\2015_Autumn\transport_research\可预测性\天津季度报告数据需求_每天6点.xlsx',3,'F3216:F3277'); 
tj_hongqiao_vm = xlsread('g:\2015_Autumn\transport_research\可预测性\天津季度报告数据需求_每天6点.xlsx',3,'G3216:G3277'); 
tj_hongqiao_conjestion_index = xlsread('g:\2015_Autumn\transport_research\可预测性\天津季度报告数据需求_每天6点.xlsx',3,'H3216:H3277'); 
disp('天津红桥区交通指标读取完毕！');

tj_nankai_vf = xlsread('g:\2015_Autumn\transport_research\可预测性\天津季度报告数据需求_每天6点.xlsx',3,'F2124:F2185'); 
tj_nankai_vm = xlsread('g:\2015_Autumn\transport_research\可预测性\天津季度报告数据需求_每天6点.xlsx',3,'G2124:G2185'); 
tj_nankai_conjestion_index = xlsread('g:\2015_Autumn\transport_research\可预测性\天津季度报告数据需求_每天6点.xlsx',3,'H2124:H2185'); 
disp('天津南开区交通指标读取完毕！');

tj_freeway_vf = xlsread('g:\2015_Autumn\transport_research\可预测性\天津季度报告数据需求_每天6点.xlsx',4,'C486:C547'); 
tj_freeway_vm = xlsread('g:\2015_Autumn\transport_research\可预测性\天津季度报告数据需求_每天6点.xlsx',4,'D486:D547'); 
tj_freeway_conjestion_index = xlsread('g:\2015_Autumn\transport_research\可预测性\天津季度报告数据需求_每天6点.xlsx',4,'E486:E547'); 
disp('天津快速路交通指标读取完毕！');

tj_outring_vf = xlsread('g:\2015_Autumn\transport_research\可预测性\天津季度报告数据需求_每天6点.xlsx',5,'C486:C547'); 
tj_outring_vm = xlsread('g:\2015_Autumn\transport_research\可预测性\天津季度报告数据需求_每天6点.xlsx',5,'D486:D547'); 
tj_outring_conjestion_index = xlsread('g:\2015_Autumn\transport_research\可预测性\天津季度报告数据需求_每天6点.xlsx',5,'E486:E547'); 
disp('天津外环交通指标读取完毕！');
rand_num = rand(1,61);
fix_num = ones(1,61);
indicator_cell = {
    bj_city_vf,tj_city_vf,bj_city_vm,tj_city_vm,bj_city_conjestion_index,tj_city_conjestion_index,...
    tj_urban_vf,tj_urban_vm,tj_urban_conjestion_index,...
    tj_heping_vf,tj_heping_vm,tj_heping_conjestion_index,...
    tj_hebei_vf,tj_hebei_vm,tj_hebei_conjestion_index,...
    tj_hedong_vf,tj_hedong_vm,tj_hedong_conjestion_index,...
    tj_hexi_vf,tj_hexi_vm,tj_hexi_conjestion_index,...
    tj_hongqiao_vf,tj_hongqiao_vm,tj_hongqiao_conjestion_index,...
    tj_nankai_vf,tj_nankai_vm,tj_nankai_conjestion_index,...
    tj_freeway_vf,tj_freeway_vm,tj_freeway_conjestion_index,...
    tj_outring_vf,tj_outring_vm,tj_outring_conjestion_index,...
    rand_num,fix_num}'; %行数=指标类型数量,列数=1,内容=各指标vector（列向量）
num_indicator = length(indicator_cell);
%% 复杂度函数调用
%把最大值最小值分成的区间数
[indicator_string,indicator_nsymbol] = arrayfun(@(x)vector_to_string_transport(x{:},10),indicator_cell,'UniformOutput',false); 
%indicator_string：cell数组：行数=指标数,列1=各指标字符串阵；
%indicator_nsymbol：cell数组：行数=指标数,列1=指标类型数；
indicator_complexity = arrayfun(@(x,y,z)cal_complexity(x{:},y{:},z),indicator_string,indicator_nsymbol,ones(num_indicator,1));
%indicator_complexity:行数=指标数,列1=复杂度















