function libsvm_test_gau()
    data = importdata('train.txt');
    x = data(:, 1:end-1);
    y = data(: , end ) ; 
    [m, ~] = size(x);
    
    % t: 0 linear kernel
    
    model = svmtrain(y, x , '-t 2 -g 2.5e-4  -s 0 -c 1  '); 
    sup_vec = model.sv_indices;
    sup_vec
    model.totalSV

   % read the test data 
    tdata = importdata('test.txt');
    x_test = tdata(:, 1:end-1);
    y_test = tdata(:, end);

    [y_cal, acc, prob_estimates] = svmpredict(y_test, x_test, model);
end