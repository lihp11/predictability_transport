clc;clear
cube_matrix_B_temp2{3,1}(isnan(cube_matrix_B_temp2{3,1})) = 0;
num_all = 0;
for j = 61:264
    for i = 1:size(cube_matrix_B_temp2{3,1},1)
        if cube_matrix_B_temp2{3,1}(i,j)>0 && cube_matrix_B_temp2{3,1}(i,j)<25
            num_all = num_all + 1;
        end
    end
end
hour = num_all / (size(cube_matrix_B_temp2{3,1},1)) * 5 / 60;


clc;clear
cube_matrix_B_temp2{3,1}(isnan(cube_matrix_B_temp2{3,1})) = 0;
num_all = 0;
speed = 0;
for j = 73:240
    for i = 1:size(cube_matrix_B_temp2{3,1},1)
        if cube_matrix_B_temp2{3,1}(i,j)>0
            num_all = num_all + 1;
            speed = speed + cube_matrix_B_temp2{3,1}(i,j);
        end
    end
end
speed = speed / num_all ;

num_all = 0;
speed = 0;
for j = 73:120
    for i = 1:size(cube_matrix_B_temp2{3,1},1)
        if cube_matrix_B_temp2{3,1}(i,j)>0
            num_all = num_all + 1;
            speed = speed + cube_matrix_B_temp2{3,1}(i,j);
        end
    end
end
speed = speed / num_all ;

num_all = 0; 
speed = 0;
for j = 181:228
    for i = 1:size(cube_matrix_B_temp2{3,1},1)
        if cube_matrix_B_temp2{3,1}(i,j)>0
            num_all = num_all + 1;
            speed = speed + cube_matrix_B_temp2{3,1}(i,j);
        end
    end
end
speed = speed / num_all ;
