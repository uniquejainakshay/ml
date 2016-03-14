function main()
    data = importdata('mnist_all.mat');
    
    three_eight= struct('train3', data.train3 ,'train8', data.train8, 'test3', data.test3, 'test8' , data.test8 );
    save('mnist_bin38.mat', 'three_eight' );

    aj = 1 ; 
end
