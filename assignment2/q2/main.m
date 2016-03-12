function main()
    data = importdata('mnist_all.mat');
    
    display_digit(data.train0(1, :));
    aj = 1 ; 
end
