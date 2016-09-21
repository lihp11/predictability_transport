%% vector, num of symbols, interval alpha,for lowpredict to param struct
% param : struct(all field is single): f1=lowpredict,f2=uppredict,
% f3=std,f4=cov,f5=BI(buffer index),f6=MI(misery index),f7=probablity of tt>alpha*tt50
% f8=lam_skew,f9=lam_var,f10=UIr
function param = vec2unreliability(vector,bin_length,mini,maxi,interval,alpha)
	% vector: travel time vector (mainly tod/dow vecotr)
	% bin_length: length of bin
	% mini:the vector's min
	% maxi: the vector's max
	% interval: for lowpredict
	% alpha: used for calc f7:factor of tt50
	string = vector_to_string(vector,bin_length,mini,maxi);
	% string: char vector
	tt_quantile = quantile(vector,[0.1,0.5,0.8,0.9]);
	%tt_quantile:vector(num=3)
	tt_mean = mean(vector);
	tt10 = tt_quantile(1);
	tt50 = tt_quantile(2);
	tt80 = tt_quantile(3);
	tt90 = tt_quantile(4);
	param.lowpredict = predict_lowerbound(string,interval);
	param.uppredict = predict_upperbound(string);
	param.std = std(vector);
	param.cov = param.std/tt_mean;
	param.BI = (tt90-tt_mean)/tt_mean;
	param.MI = mean(vector(vector>tt80))/tt_mean;
	param.PR = sum(vector>alpha*tt50)/length(vector);
	param.lam_skew = (tt90-tt50)/(tt50-tt10);
	param.lam_var = (tt90-tt10)/tt50;
end

