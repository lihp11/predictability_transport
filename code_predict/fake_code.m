
sumlength = 0;
for i = 1:n
	if i=1 sublength = 1,substring = string(1),sumlength = 1；
	if i~=1
		substring = string(1);
		sublength = 1;
		while (string(1:i-1) 包含 substring)
			if i-1+sublength = n break;
			sublength++; %最后：不包含的最小长度
			substring = string(i:i-1+sublength); %最后：不包含的最小子串
		sumlength = sumlength+sublength;
