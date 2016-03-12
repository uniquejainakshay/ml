function display_digit(arr) 
    [~, n ] = size(arr); 
    if n ~= 28 * 28 
        disp('Wrong array size' ) ; 
        disp(n);
        return 
    end
    C = zeros(28 , 28 ) ; 
    for i = 1:28 
        C(i, :) = arr(1, 28*i-27:28*i);
    end
    %image(C);
    I = mat2gray(C);
    imshow(I);
end
