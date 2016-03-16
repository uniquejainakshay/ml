function [val] = test_nn(x, Tih, Tho ) 
    %x : 1x784  
    % Tih 785 x 100 
    % Tho 101 x 4 
    oh = sigmoid([1 x] * Tih) ; % 1 x 100 
    op = sigmoid([1 oh ] * Tho) ; % 1 x 1 
    val = op' >= 0.5; 
end
    