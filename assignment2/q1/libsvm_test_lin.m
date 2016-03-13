function libsvm_test_lin()
    data = importdata('train.txt');
    x = data(:, 1:end-1);
    y = data(: , end ) ; 
    [m, ~] = size(x);
    
    % t: 0 linear kernel
    
    model = svmtrain(y, x , '-t 0'); 
    svs = full(model.SVs);
    [m_sup, ~] = size(svs);
    
    sup_vec = zeros(m_sup, 1);
    for i = 1:m_sup
        for j = 1:m
            if svs(i,:) == x(j,:);
                sup_vec(i)= j ; 
                break;
            end
        end
    end
    sup_vec
                

   % read the test data 
    tdata = importdata('test.txt');
    x_test = tdata(:, 1:end-1);
    y_test = tdata(:, end);

    [y_cal, acc, prob_estimates] = svmpredict(y_test, x_test, model);
end