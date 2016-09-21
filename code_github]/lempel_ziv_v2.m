function [codice, code_bin, code_book] = lempel_ziv(alfabeto, stringa)

% Test with str='bcababbcabcbcbbccaabbababb' e alf=['a' 'b' 'c']

alf=alfabeto;   % It's the alphabet that contains the char used in the string
%需要用的基本字符表例如['a' 'b' 'c'],或者'abcdef'等
%行数=1，列数=基本字符数，内容=基本字符
str=stringa;    % It's the string to codify
%要编码的字符串
code_book=cell(length(alf),1);      % Initializes the code-book
%编码字典初始化
%code_book：cell数组：行数=基本字符数（此处初始的），列1=字符阵
for i=1:1:length(alf)               % Inserts in code-book the firsts elements
    code_book{i}=alf(i);
    %code_book：cell数组：行数=字典字符串数（初始为基本字符表字符），列1=字符阵
end

k=str(1);   % It's the first word to codify
%字符串（待检验是否加入字典）：行数=1，列数=不确定
codice=[];  % Initializes the variable used to save the decimal code
n = 1;
% index=1;
while n<=length(str)   
    trovato=0; %待检验字符串在字典中能否找到的标志
    for i=1:length(code_book)
        if(length(k)==length(code_book{i}))  % Checks if the word to codify is already contained in the code-book
            %up：若待检验字符串长度与字典某记录的字符串长度相等
            if(strcmp(k,code_book{i})==1)
                %up:若待检验字符串与字典某记录的字符串完全一致
                 %z=i;    % It's the decimal code of the word to codify
                trovato=1; break;
            end
        end
    end
    n = n+1;
    if trovato==0   % If the word isn't contained in the code-book, updates the code-book
        %如果找不到待检验字符串
        code_book{length(code_book)+1}=k; 
        %行数=字典字符串数，列1=字符阵
        codice(end+1)=codice(end)+1;
        %行数=目前为止字典中非基本字符阵数目，列1=字典数字编号     % Update the decimal code of the known word %单元素=字典新加字符串如'ab'的数字编号
        k=k(end);     % Takes the unknown part of the word
        %新增加后取最后一个字符
    end
    if trovato==1  % Else updates the decimal code, increments the index and checks the string's end      
%         index=index+1; 
%         %单元素=当前调查结束（是否在字典中）的字符串的字符数+1（下一次的调查次数或最大延伸位置）
%         if index>length(str)    
%             % If string terminates, it codifies the last word 
%             %如果字符串结束
%             for i=1:length(code_book)
%                 if(length(k)==length(code_book{i}))
%                     if(strcmp(k,code_book{i})==1)
%                         z=i;
%                     end
%                 end
%             end
%             codice(end+1)=z;
%             break;
%         end
        k=[k str(n)];   % Takes a new word
        %行数=1，列数=当前调查好的字符串字符数+1
    end
end
code_bin=dec2bin(codice);   % Codifies with binary code the result