function [string,n] = vector_to_string(vector,bin_length,mini,maxi)
% vector:num vec
% bin_length: length of bin
% mini:the vector's min
% maxi: the vector's max
% output:string:string with n+2 symbols,length=length(string)

n = ceil((maxi-mini)/bin_length); % num of bin between limit
maxi = mini + n*bin_length;	% update maxi to make each bin_length equal

for nth_ele = 1:length(vector)
	if (vector(nth_ele)<mini)	% if element<mini,map to char(65) = A
		string(nth_ele) = 'A';	% the first bin represented by 'A'
	elseif (vector(nth_ele)>=maxi)
		string(nth_ele) = char('A'+n+1);	% the (n+2)th bin represented by char('A'+n+1)
	else
		string(nth_ele) = char('A'+ floor((vector(nth_ele)-mini)/bin_length)+1);
	end			
end

end