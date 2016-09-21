%测试n字符的算法
clc,clear;
%方法1
% [codice, code_bin, code_book] = lempel_ziv('abc', 'abcbabcbabbbbcccaaacbc');
[codice, code_bin, code_book] = lempel_ziv('01', '1011010100010');
comlexity1 = length(unique(codice));

%方法2 可以，但注意算出来的值是2bit，n_bit应更改底数Interpretation of the Lempel-Ziv Complexity Measure in the Context of Biomedical Signal Analysis
comlexity2 = cal_complexity('1011010100010',0);

%方法3 可以，但注意算出来的值是2bit，n_bit应更改底数，参见Interpretation of the Lempel-Ziv Complexity Measure in the Context of Biomedical Signal Analysis
[knorm,k]=calc_lz_k('1011010100010');
comlexity3 = k;   

a = {'china','beijing';'shanghai','tianjin'};
b = a(1,1);  %b为1×1的cell_array
c = a{1,1};  %c为字符数组'china'
d = a{:};  %仅仅返回第一个的cell的内容
e = a(:);  %排成一列，类型不变


a = speedinterp(fuchengmenwaidajie_we{2,1});
vector = daycells2vector(fuchengmenwaidajie_we);

string = vector_to_string_transport([12 50 60 45 35]);

x = 1:10;
y = zeros(10,2);
y(1:10,2) = arrayfun(@(m)add(m),x);
y(:,2) = arrayfun(@(m)add(m),x);

x = 1:10;
y = zeros(10,1);
y = arrayfun(@(m)add(m),x);  %此时y会被覆盖成1×10

para_equation = @(x,c)(x-3+c);
c=1;
myfun = @(x) para_equation(x,1);
y = fzero(@(x) para_equation(x,1),0.5)

clc,clear;

predict_upperbound('aaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaa');
	uppredict = fzero( @(x)lz_para_equation(x,0.7),0.5)


string = 'qwoifjlkbnfdhfugvujcnlamfruihbvvm,.a;flqefuajuisdfbcmjvnxc,.sv,.mdasogfijdsg';
string = 'aaaaaaaaaaaabbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbaaaaaaaaaaaaaaaaaaaa';
	n = length(string);	%单元素=字符数
	N = length(unique(string));	%symbol数
	lz_entropy = zeros(n,1);
	%up:行数=字符数，列1=相应行字符及之前字符的条件熵的上限
	for i=1:n
		lz_entropy(i,1) = lempel_ziv_entropy(string(1:i));
	end
	lz_entropy_mean = mean(lz_entropy);

	%由N和lz_entropy计算上限,参数方程采用 @(未知数，参数)(方程) 的形式
	lz_para_equation = @(x,c)(-(x*log(x)/log(2)+(1-x)*log(1-x)/log(2))+(1-x)*log(N-1)/log(2)-c);
	uppredict = fzero( @(x)lz_para_equation(x,lz_entropy_mean),0.5)

string = 'asdhfjoquewhfkljdasfkldasfhdjbkjdsbncvkljvbuiqoweyruivbamsdfdasfdasfnmdascvnalsdfjyh';
string = 'asdzxccdsasssdccccccxxxxzzssaasasdasddsazxccxzzxcdsaazzasxdccdcdxxsaazzassasdcxzxceda'
string = 'ababababababababcbcabbcabcabbababcabcabcbcabcbacbabcbbcbcababcbabcabcbacbcbabcbacbabc'
string = 'abcabcabcabbabcabcabcacaabcabcabccaaabcabcabcbcaabcabcabcabcccaacabcabcabcabcbabcabcab'
predict_upperbound(string)
predict_lowerbound(string)
s=dlmread('g:\transport_research\可预测性\高德全年数据\north4th_ring_ew_avgspeed.csv',',');



