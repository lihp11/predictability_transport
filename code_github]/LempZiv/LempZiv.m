% Author: Mehedi Hasan
% Bangladesh University of Engineering and Tech.
% email: mh.eee08@gmail.com

% ref: http://www.data-compression.com/lempelziv.html

% data is a string of character or anything

% dict is a cell containing the dictionary

% comdata is the compressed form of the data 

% ComdataBin is the binary representation of compressed data

function [dict,comdata,comdataBin] = LempZiv(data)

 
% data = ['ABBAABBAABABBAAAABAABBA']

N = length(data);
dict = cell(1,N);

dict{1} = ['A'];% Begin with 'A' and 'B', later occurance of nonexisting entry could be dynamically updated.

dict{2} = ['B'];

cp = 1;

ddp = 3;
comdata = NaN;
cdp = 1;
for ii = 1:N
    ndp = 0;
    ndp_increase = 0;
    bal = 0; % Break All Loop (in case, end of data is reached)
    indmatch = [];
    for kk = 1:N % This section increase length of string to be compared with the dict entry(ies)
        enl = 1;
        for jj = 1:(ddp) % This section compares a given length with every entry in dict.
            
            if (cp+ndp)>N % End of string is confronted with 'cp+ndp'
                ndp = ndp - 1;
                bal = 1;
            end
            
            if jj>(length(dict))
                enl = 0;
            end
            
            if enl && strcmp(data(cp:(cp+ndp)),dict{jj}) % if the given length data is found in dic., then increase length of string to compare
                ndp_increase = 1;
                indmatch = jj; % track the index of largest entry that matched
                break;
            else
                ndp_increase = 0; % else, comtinue checking till the end of dict.
            end
            
        end
        if ndp_increase % Increase the length of string to be comaperd, if prescribed (from jj loop).
            ndp = ndp + 1;
            if (cp+ndp)>N
                comdata(cdp) = indmatch;
                bal = 1;
                break;
            end
            
        else % if an increase is not prescribed before the exit of previous
            % loop (the jj loop), it implies that the current length of srting does not
            % belong to the existing dict. Hence, this string is added to the dict.  and
            % Current Position (cp) is updated along with Dictionany
            % Data Pointer (ddp)
            dict{ddp} = data(cp:(cp+ndp));
            if isempty(indmatch)
                comdata(cdp) = ddp;
                cdp = cdp + 1;
                cp = cp + ndp + 1;
                if cp>N
                    bal = 1;
                    break;
                end
                ddp = ddp + 1;
            else
                comdata(cdp) = indmatch;
                ddp = ddp + 1;
                cp = cp + ndp;
                cdp = cdp + 1;
                break;
            end
        end
    end
    if bal
        break;
    end
end
for ii = 1:N
    if isempty(dict{ii})
        break;
    end
end
dict = dict(1:(ii-1));
n = ceil(log2(max(comdata)));
comdataBin = cell(1,length(comdata));
for ii = 1:length(comdata)
    comdataBin{ii} = (dec2bin(comdata(ii),n));
end