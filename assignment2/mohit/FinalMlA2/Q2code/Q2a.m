load('mnist_all.mat');
raw = input('enter file name ');

index = input('Enter index ');
if (index > size(raw,1))
    disp('Index out of bound')
else
    matrix = zeros(28,28);
    testindex = 0;
    for i = 1:28
        for j = 1:28
            testindex = testindex + 1;
            matrix(i,j) = raw(index,testindex);
        end
    end
    imshow(matrix)
end
       