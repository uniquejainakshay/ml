function binary_nn()
    cumj = 1000; 
    error = 0.0001; 
    
    % outputs
    oi = zeros(784,1);
    oh = zeros(100,1);
    oj = 0 ; 
    
    %thetas
    Tih = (rand(785, 100, 1) - 0.5) .* 1e-5; 
    Tho = (rand(101, 1 , 1 ) -0.5) .* 1e-5; 
    
    %expected outputs
    tj = 0 ; 
    
    %gradients 
    gih = zeros(785, 100);
    gho = zeros(101, 1);
    
    % read training data
    data = load('mnist_bin38.mat');
    [m3, ~] = size(data.three_eight.train3);
    [m8, ~] = size(data.three_eight.train8);
    it = 0 ; 
    while cumj > error 
        it = it + 1; 
        cumj= 0 ; 
        for e = 0:1 
            %% iteration begin 
                if e ==0 % choose 3 or 8 
                    oi = double(data.three_eight.train3(randi([ 1 m3]), :)')/255;
                    tj = 0 ; 
                else
                    oi = double(data.three_eight.train8(randi([ 1 m8]), :)')/255;
                    tj = 1 ; 
                end
                
                %forward pass 
                oh = sigmoid([1;oi]' * Tih)';  % 100x1
                oj = sigmoid([1;oh]' * Tho)';  % 1x1 
                
                %% backward pass 
                %calculate gradients
                delop = (tj - oj ) * oj * ( 1 - oj);     % 1x1 del output
                gho =  -[1;oh] * delop;                      % 100x1 
                
                delh =  ( oh ) .* ( 1 - oh ) .* (Tho(2:end,:) * delop);  % 100x 1 del hidden 
                gih = -[1;oi] * delh'; % 784 x 100
                
                %updated thetas 
                eta = 1 / sqrt(it);
                Tih = Tih - eta * gih ; 
                Tho = Tho - eta * gho ; 
                
                %calculate j theta 
                
                jtheta = 0.5 * (tj - oj )^2; 
                cumj = cumj + jtheta ; 
                
            %% iteration end
        end
    end
    
    %% training completed now testing
    
    % testing 3 
    test3 = double(data.three_eight.test3)/255;
    [m3, ~] = size(test3);
    correct = 0 ;
    for i = 1:m3 
        op = test_nn(test3(i, :), Tih, Tho);
        if op == 0 
            correct = correct+1 ; 
        end
    end
    disp('Accuracy for 3 ' ) ; 
    disp(100 * correct / m3);
    
    %testing 8
    test8 = double(data.three_eight.test8)/255;
    [m8, ~] = size(test8);
    correct = 0 ;
    for i = 1:m8 
        op = test_nn(test8(i, :), Tih, Tho);
        if op == 1 
            correct = correct+1 ; 
        end
    end
    disp('Accuracy for 8 ' ) ; 
    disp(100 * correct / m8);
    aj = 1 ; 
end