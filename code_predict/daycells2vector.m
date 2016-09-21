function vector = daycells2vector(dayscell)
%输入：dayscell：行数=天数，列数=1，dayscell{i}:行数=100m的数目，列数=288，内容=时空单元格的平均速度
%输出：vector：行数=天数×288，列1=相应时刻道路平均速度
days = length(dayscell);
dayMeanSpeed = zeros(days,288);
for i = 1:days
   dayMeanSpeed(i,:) = mean( dayscell{i},1 );  %dayMeanSpeed：cellarray，行数=天数，列数=1，dayMeanSpeed{i}:行数=1，列数=288，内容=道路相应列个5min的平均速度   
end
   dayMeanSpeed = dayMeanSpeed';
   vector = dayMeanSpeed(:);
end
