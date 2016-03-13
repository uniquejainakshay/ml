clc 
clear all
train = importdata('validation.data',',');%s = char(train);
[row,col] = size(train);
w = zeros(row,17);

for i = 1:row
    s = train{i,1};
    tr =  strsplit(s,',');
    if strcmp('republican',char(tr(1,1))) == 1
       w(i,1) = 1;
    else
       w(i,1) = 0;      
    end   
    for j = 2:17
        if char(tr(1,j)) == 'y'
            w(i,j) = 1;
        elseif char(tr(1,j)) == 'n'
            w(i,j) = 0;
        else
            w(i,j) = -1;
        end
    end   
end

save validation w
