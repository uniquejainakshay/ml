function [matrix,flag] = child(dTree,index)


if dTree(index,2) == -1 % 
    matrix = [];
    flag = -1;
else
    matrix = [dTree(index,3) dTree(index,4) dTree(index,5)];
    flag = 1;
end


end

