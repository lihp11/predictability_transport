function [codice, code_bin, code_book] = lempel_ziv(alfabeto, stringa)

% Test with str='bcababbcabcbcbbccaabbababb' e alf=['a' 'b' 'c']

alf=alfabeto;   % It's the alphabet that contains the char used in the string
str=stringa;    % It's the string to codify
code_book=cell(length(alf),1);      % Initializes the code-book
for i=1:1:length(alf)               % Inserts in code-book the firsts elements
    code_book{i}=alf(i);
end

k=str(1);   % It's the first word to codify
codice=[];  % Initializes the variable used to save the decimal code
i=1;
index=1;
while 1  
    trovato=0;
    for i=1:length(code_book)
        if(length(k)==length(code_book{i}))  % Checks if the word to codify is already contained in the code-book 
            if(strcmp(k,code_book{i})==1)
                z=i;    % It's the decimal code of the word to codify
                trovato=1;
                break; %找到小串的位置，跳出寻找的循环
            end
        end
    end
    if trovato==0   % If the word isn't contained in the code-book, updates the code-book
        code_book{length(code_book)+1}=k;
        codice(length(codice)+1)=z;     % Update the decimal code of the known word ，将添加的indice内容为可扩展的最大长度=刚刚添加到字典内容-最后一个字符 ②
        k=k(length(k));     % Takes the unknown part of the word
    end
    if trovato==1  % Else updates the decimal code, increments the index and checks the string's end      
        index=index+1;
        if index>length(str)    % If string terminates, it codifies the last word
            %down7：寻找最后一点字符串在字典的位置（不再进一步扩大因为字符串读完了）
            for i=1:length(code_book)
                if(length(k)==length(code_book{i}))
                    if(strcmp(k,code_book{i})==1)
                        z=i;
                    end
                end
            end
            codice(length(codice)+1)=z;  %马上结束了，不会再有新添加到字典的内容，将目前长度有限的内容k添加到字典
            break;  %此break终止大循环用
        end
        k=[k str(index)];   % Takes a new word
    end
end
code_bin=dec2bin(codice);   % Codifies with binary code the result