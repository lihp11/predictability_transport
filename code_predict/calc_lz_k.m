function [knorm,k]=calc_lz_k(svect)
% author: Alberto Giovanni Busetto
% CALC_LZ_K finds a Lempel-Ziv upper bound to the Kolmogorov complexity of the input integer string svect
% INPUT:
%        svect:	integer vector; symbolic values labeled sequentially from n to m, m>n
% OUTPUT:
%	 k:     upper bound to the Kolmogorov complexity through Lempel-Ziv coding
%        knorm: normalized bit rate (that is, k/(n/log2(n))), where n=length(svect)	

% normalize numerical labels sequential range (n..m) to (0..m-n)
svect=svect(:);
nv=length(svect);
svect=svect-min(svect);
nby=ceil(log2(max(svect)));

% conversion to string
s='';
for i=1:nv
    nthisbit=length(dec2bin(svect(i)));
    for j=1:nby-nthisbit+1
        s=strcat(s,'0');
    end
    sv=str2double(dec2bin(svect(i)));
    sadd='';
	for j = 1 : numel(sv)
    	    sadd = [sadd sprintf('%1.0f',sv(j))]; %#ok<AGROW>
	end
    s=strcat(s,sadd);
end

% calculation of the LZ bound
n=length(s);
k=1;
km=1;
c=1;
i=0;
len=1;
exitloop=0;

while exitloop==0
    if s(i+k)~=s(len+k)
        if k>km
            km=k;
        end
        i=i+1;
        if i==len
            c=c+1;
            len=len+km;
            if len+1>n
                exitloop=1;
            else
                i=0;
                k=1;
                km=1;
            end
        else
            k=1;
        end
	else
        k=k+1;
        if len+k>n
            c=c+1;
            exitloop=1;
        end
    end
end

% normalization
k=c;
knorm=k/(nv/log2(nv));
