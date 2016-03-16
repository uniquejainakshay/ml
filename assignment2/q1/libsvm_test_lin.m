function libsvm_test_lin()
    data = importdata('train.txt');
    x = data(:, 1:end-1);
    y = data(: , end ) ; 
    [m, ~] = size(x);
 
    model = svmtrain(y, x , '-t 0 -s 0 -c 1'); 
    sup_vec = model.sv_indices;
    sup_vec
                

   % read the test data 
    tdata = importdata('test.txt');
    x_test = tdata(:, 1:end-1);
    y_test = tdata(:, end);

    [y_cal, acc, prob_estimates] = svmpredict(y_test, x_test, model);
    acc
end