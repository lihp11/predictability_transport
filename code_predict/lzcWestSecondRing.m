%将多条道路的dayscell（每天的时空阵构成的cell）转化为每条道路的复杂度

%% 数据读取
clc,clear,close all;
load('timeSpaceWestSecondRing2015q4.mat');

roadName = {'erhuan_ns','erhuan_sn','fuchengmenwaidajie_ew','fuchengmenwaidajie_we',...
    'fuxingmenneidajie_ew','fuxingmenneidajie_we','jinrongjie_ns','jinrongjie_sn',...
    'nanbeilishi_ns','nanbeilishi_sn','pinganjie_ew','pinganjie_we','taipingqiaodajie_ns',...
    'taipingqiaodajie_sn','yuetanbeijie_ew','yuetanbeijie_we','yuetannanjie_ew','yuetannanjie_we'};

roadNum = length(roadName);
symbol = cell(length(roadName),1);
speedVector = cell(roadNum,1);
for i=1:length(roadName)  %对变量名循环
    dayscell = eval(roadName{i});   %eval相当于去掉引号
    %dayscell：行数=天数，列数=1，dayscell{k}:行数=100m的数目，列数=288，内容=时空单元格的平均速度
    dayscellInterp1 = arrayfun(@(x)speedinterp(x{:}),dayscell,'UniformOutput',false);
    dayscellInterp2 = arrayfun(@(x)speedinterp((x{:})'),dayscellInterp1,'UniformOutput',false); 
    dayscellInterp3 = arrayfun( @(x)(x{:})',dayscellInterp2,'UniformOutput',false );
    %两次插值去掉所有0和NaN
    %dayscellInterp：行数=天数，列数=1，dayscell{k}:行数=100m的数目，列数=288，内容=时空单元格的平均速度
    speedVector{i} = daycells2vector(dayscellInterp3);
    %speedVector：cellarray：行数=道路数，列数=1
    %speedVector{i}:行数=天数×288，列1=第i个路名的相应时刻道路平均速度  
end



  

%% 道路复杂度函数调用
roadComplexity = zeros(9,roadNum);%行数=道路书，列数=10-1=9
symbolVector = cell(9,1);
for i = 2:10
%把最大值最小值分成的区间数
symbolVector{i-1} = arrayfun( @(x)vector_to_string(x{:},i),speedVector,'UniformOutput',false);  %仅speedVector(i-1)作为输入参数x
%symbolVector;cellarray行数=区间划分数9，列数=1
%symbolVector{i-1} ：cellarray行数=道路数，列数=1，内容=i个字符时的道路字符串
roadComplexity(i-1,:) = arrayfun(@(x)cal_complexity(x{:},i,1),symbolVector{i-1});
%roadComplexity;行数=区间划分数9，列数=道路数，内容=复杂度
end
roadComplexity = roadComplexity';
%行数=道路数，列数=区间划分数9，内容=复杂度

%% 随机数和固定数复杂度调用
randNum = rand(1,length(speedVector{i}));
fixComplexity = zeros(9,1);
randVector = cell(9,1);
randComplexity = zeros(9,1);
for i =2:10
    fixComplexity(i-1) = cal_complexity( repmat('x',length(speedVector{i}),1),i,1 );
    
    randVector{i-1} = vector_to_string(randNum,i);
    randComplexity(i-1) = cal_complexity( randVector{i-1},i,1 );
    
end
fixComplexity = fixComplexity';
randComplexity = randComplexity';









