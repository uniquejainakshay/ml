function multiclass_nn()
    load_already_saved = 0 ; 

    j_theta_mean = 1000; 
    error = 0.001; 

    % outputs
    oi = zeros(784,1);
    oh = zeros(100,1);
    oj = zeros(4, 1) ; 
    
    %thetas
    Tih = (rand(785, 100, 1)-0.5) .* 1e-5; 
    Tho = (rand(101, 4 , 1 )-0.5) .* 1e-5; 
    
    %expected outputs
    tj = zeros(4, 1) ; 
    
    %gradients 
    gih = zeros(785, 100);
    gho = zeros(101, 4);
    
    % read training data
    data = load('mnist_all.mat');
    
    x = containers.Map('KeyType', 'int32', 'ValueType', 'any') ; 
    x(0) = double(data.train0)/255; 
    x(1) = double(data.train1)/255; 
    x(2) = double(data.train2)/255; 
    x(3) = double(data.train3)/255; 
    x(4) = double(data.train4)/255; 
    x(5) = double(data.train5)/255; 
    x(6) = double(data.train6)/255; 
    x(7) = double(data.train7)/255; 
    x(8) = double(data.train8)/255; 
    x(9) = double(data.train9)/255; 
    
    t = containers.Map('KeyType', 'int32', 'ValueType', 'any');
    t(0) = [0 0 0 0]';
    t(1) = [0 0 0 1]';
    t(2) = [0 0 1 0]';
    t(3) = [0 0 1 1]';
    t(4) = [0 1 0 0]';
    t(5) = [0 1 0 1]';
    t(6) = [0 1 1 0]';
    t(7) = [0 1 1 1]';
    t(8) = [1 0 0 0]';
    t(9) = [1 0 0 1]';
    
    m = containers.Map('KeyType', 'int32', 'ValueType', 'any');
    for i = 0:9
        [m(i),~ ]= size(x(i));
    end
    
    if load_already_saved == 0  % do not load saved thetas
        it = 0 ; 
        while j_theta_mean > error 
            if mod(it , 1000) == 0 
                it 
                j_theta_mean
            end
            it = it + 1; 
            j_theta_mean= 0 ; 
            for e = 0:9 
                %% iteration begin 
                    % choose the digit e 
                    xe = x(e);
                    oi = xe(randi([ 1 m(e)]), :)';
                    tj = t(e); 

                    %forward pass 
                    oh = sigmoid([1;oi]' * Tih)';  % 100x1
                    oj = sigmoid([1;oh]' * Tho)';  % 4x1 

                    %% backward pass 
                    %calculate gradients
                    delop = (tj - oj ) .* oj .* ( 1 - oj);     % 4x1 del output
                    gho =  -[1;oh] * delop';                      % 101x4 outer product

                    delh =  ( oh ) .* ( 1 - oh ) .* (Tho(2:end,:) * delop);  % 100x 1 del hidden 
                    gih = -[1;oi] * delh'; % 785 x 100 outer product 

                    %updated thetas 
                    eta = 1 / sqrt(it);
                    Tih = Tih - eta * gih ; 
                    Tho = Tho - eta * gho ; 

                    %calculate j theta 

                    jtheta = 0.5*(tj-oj)'*(tj-oj); 
                    j_theta_mean = j_theta_mean + jtheta ; 

                %% iteration end
            end
            j_theta_mean = j_theta_mean / 10 ; 
        end
        save('Tih');
        save('Tho');
    else % load the thetas from file 
        load('Tih');
        load('Tho');
    end
    %% training completed now testing
    
	x(0) = double(data.test0)/255; 
    x(1) = double(data.test1)/255; 
    x(2) = double(data.test2)/255; 
    x(3) = double(data.test3)/255; 
    x(4) = double(data.test4)/255; 
    x(5) = double(data.test5)/255; 
    x(6) = double(data.test6)/255; 
    x(7) = double(data.test7)/255; 
    x(8) = double(data.test8)/255; 
    x(9) = double(data.test9)/255;
    
    for i = 0:9
        [m(i),~ ]= size(x(i));
    end
    accuracy = containers.Map('KeyType', 'int32' , 'ValueType', 'any');
    for i = 0:9
        correct = 0 ;
        xi = x(i);
        for j = 1:m(i) 
            op = test_nn(xi(j,:), Tih, Tho);
            if op == t(i) 
                correct = correct+1 ; 
            end
        end
        accuracy(i) = 100 * correct / m(i);
    end
    res = '' ; 
    for i = 0:9
        res = strcat(res,{' '} , sprintf('%2.2f%s', accuracy(i), ' ' )); 
    end 
    disp(res);
    
end