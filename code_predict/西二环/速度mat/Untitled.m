%erhuan
temp=cell(36,1);
for i = 1:36
    temp{i,1} =find(CUBE_DATA{3,1}(i,:)==0);
end
%SN 12.3
m = 22;
n = 23;
for i = m:n
    CUBE_DATA{3,1}(8,i) = CUBE_DATA{3,1}(8,m-1) + (CUBE_DATA{3,1}(8,n+1)-CUBE_DATA{3,1}(8,m-1))/(n-m+2)*(i-m);
end
m = 41;
n = 42;
for i = m:n
    CUBE_DATA{3,1}(8,i) = CUBE_DATA{3,1}(8,m-1) + (CUBE_DATA{3,1}(8,n+1)-CUBE_DATA{3,1}(8,m-1))/(n-m+2)*(i-m);
end
m = 54;
n = 56;
for i = m:n
    CUBE_DATA{3,1}(8,i) = CUBE_DATA{3,1}(8,m-1) + (CUBE_DATA{3,1}(8,n+1)-CUBE_DATA{3,1}(8,m-1))/(n-m+2)*(i-m);
end
m = 22;
n = 23;
for i = m:n
    CUBE_DATA{3,1}(9,i) = CUBE_DATA{3,1}(9,m-1) + (CUBE_DATA{3,1}(9,n+1)-CUBE_DATA{3,1}(9,m-1))/(n-m+2)*(i-m);
end
m = 44;
n = 45;
for i = m:n
    CUBE_DATA{3,1}(9,i) = CUBE_DATA{3,1}(9,m-1) + (CUBE_DATA{3,1}(9,n+1)-CUBE_DATA{3,1}(9,m-1))/(n-m+2)*(i-m);
end
m = 33;
n = 34;
for i = m:n
    CUBE_DATA{3,1}(25,i) = CUBE_DATA{3,1}(25,m-1) + (CUBE_DATA{3,1}(25,n+1)-CUBE_DATA{3,1}(25,m-1))/(n-m+2)*(i-m);
end
m = 36;
n = 37;
for i = m:n
    CUBE_DATA{3,1}(25,i) = CUBE_DATA{3,1}(25,m-1) + (CUBE_DATA{3,1}(25,n+1)-CUBE_DATA{3,1}(25,m-1))/(n-m+2)*(i-m);
end
m = 53;
n = 54;
for i = m:n
    CUBE_DATA{3,1}(25,i) = CUBE_DATA{3,1}(25,m-1) + (CUBE_DATA{3,1}(25,n+1)-CUBE_DATA{3,1}(25,m-1))/(n-m+2)*(i-m);
end
m = 56;
n = 57;
for i = m:n
    CUBE_DATA{3,1}(25,i) = CUBE_DATA{3,1}(25,m-1) + (CUBE_DATA{3,1}(25,n+1)-CUBE_DATA{3,1}(25,m-1))/(n-m+2)*(i-m);
end

for i = 1:36
   if size(temp{i,1},2) >0
      for j = 1:size(temp{i,1},2)
          CUBE_DATA{3,1}(i,temp{i,1}(1,j))= (CUBE_DATA{3,1}(i,temp{i,1}(1,j)-1) + CUBE_DATA{3,1}(i,temp{i,1}(1,j)+1))/2;
      end
   end
end

temp=cell(36,1);
for i = 1:36
    temp{i,1} =find(CUBE_DATA{3,1}(i,:)==0);
end
%NS 12.3
m = 45;
n = 46;
for i = m:n
    CUBE_DATA{3,1}(12,i) = CUBE_DATA{3,1}(12,m-1) + (CUBE_DATA{3,1}(12,n+1)-CUBE_DATA{3,1}(12,m-1))/(n-m+2)*(i-m);
end
m = 49;
n = 50;
for i = m:n
    CUBE_DATA{3,1}(12,i) = CUBE_DATA{3,1}(12,m-1) + (CUBE_DATA{3,1}(12,n+1)-CUBE_DATA{3,1}(12,m-1))/(n-m+2)*(i-m);
end
m = 54;
n = 55;
for i = m:n
    CUBE_DATA{3,1}(12,i) = CUBE_DATA{3,1}(12,m-1) + (CUBE_DATA{3,1}(12,n+1)-CUBE_DATA{3,1}(12,m-1))/(n-m+2)*(i-m);
end
m = 57;
n = 58;
for i = m:n
    CUBE_DATA{3,1}(12,i) = CUBE_DATA{3,1}(12,m-1) + (CUBE_DATA{3,1}(12,n+1)-CUBE_DATA{3,1}(12,m-1))/(n-m+2)*(i-m);
end
for i = 1:36
   if size(temp{i,1},2) >0
      for j = 1:size(temp{i,1},2)
          CUBE_DATA{3,1}(i,temp{i,1}(1,j))= (CUBE_DATA{3,1}(i,temp{i,1}(1,j)-1) + CUBE_DATA{3,1}(i,temp{i,1}(1,j)+1))/2;
      end
   end
end










