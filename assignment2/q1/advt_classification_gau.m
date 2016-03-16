function advt_classification_gau()
    %%  part C
    data = importdata('train.txt');
    x = data(:, 1:end-1);
    y = data(: , end ) ; 
    [m , ~ ] = size(x); 
    K = zeros(m , m ) ; 
    bw = 2.5e-4 ; 
    for i = 1 : m 
        for j = 1 : i 
            K (i , j) = gaus_kern(x(i, :),x(j , : ), bw);
            K(j, i ) = K(i ,j ); 
        end
    end
    
    Y = y * y' ; % yi * yj
    Q = Y .* K ; % yi.yj.K(xi,xj)
    
    b = ones(m, 1);
    cvx_precision low
    cvx_begin 
        variable alp(m, 1);
        maximize(-alp' * Q * alp + b' * alp ) ;
        subject to 
            0 <=  alp <= 1;
            alp' * y == 0; 
    cvx_end
    
    sup_vec = find(0.000001 < alp & alp < 0.999999);
    sup_vec
    
    x_sup = x(sup_vec, :);
    y_sup = y(sup_vec, :);
    alp_sup = alp(sup_vec,:);
    
    [m_sup, ~] = size(x_sup);
    
    % calculate b 
    % calculate using yi=sum(alpi*yi*xi*x)+b
    idx = find(alp==max(alp_sup));

    K_xi_x = zeros(m,1);
    for i = 1:m
        K_xi_x(i, 1 ) = gaus_kern(x(i, : ), x(idx, : ), bw) ; 
    end
    
    b_opt = y(idx) - ( alp .* y)' * K_xi_x ; 

    % testing against test data 
    tdata = importdata('test.txt');
    x_test = tdata(:, 1:end-1);
    y_test = tdata(:, end);
    [test_size, ~ ] = size(x_test);
    y_cal = zeros(test_size, 1 ) ; 
    % using only support vectors for classification 
    for l = 1: test_size
        k_xi_x = zeros(m_sup, 1) ; 
        for p = 1:m_sup 
            k_xi_x(p , : ) = gaus_kern(x_sup(p, : ) , x_test(l, : ) , bw); 
        end
        y_cal(l , : ) = (alp_sup .* y_sup)' * k_xi_x + b_opt ; 
    end
            
    % count the mismatches 
    [total , ~ ] = size(y_test);
    [correct, ~] = size(find(y_cal .* y_test > 0 )) ; 
    
    disp('Accuracy : ' ) ; 
    disp(100 * correct / total ) ; 
    %% part C completed 
end