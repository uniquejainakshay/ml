function advt_classification_gau()
    %%  part C
    data = importdata('train.txt.small');
    x = data(:, 1:end-1);
    y = data(: , end ) ; 
    [m , ~ ] = size(x); 
 
    b = ones(m, 1);
	l = zeros(m , 1); 
	u = ones(m , 1 ); 
    K = zeros(m , m ) ; 
    for i = 1 : m 
        for j = 1 : i 
            diff = x(i, :) - x(j , : );
            K(i, j ) = diff * diff'; 
            K(j, i ) = K(i ,j ); 
        end
    end
    bw = 2.5e-4 ; 
    K = exp(-K * bw);
    
    
    Y = y * y' ; % yi * yj
    Q = Y .* K ; % yi.yj.K(xi,xj)
    
    b = ones(m, 1);
	l = zeros(m , 1); 
	u = ones(m , 1 ); 
    
    cvx_begin 
        variable alp(m, 1);
        maximize(-alp' * Q * alp + b' * alp ) ;
        subject to 
            l <=  alp <= u;
            alp' * y == 0; 
    cvx_end
    
    sup_vec = find(0.00000001 < alp & alp < 0.99999999);
    sup_vec
    
    % calculate b 
    % Take any random support vector and calculate yi=sum(alpi*yi*xi*x)+b 
    % Get b from the above equation
    
    idx = sup_vec(1) ; % taking the first one  itself, doesn't seem working 
    
    %idx = find(alp==max(alp(find(alp>1e-4 & alp<0.9999))))  % TODO : no
    %need I think 
    
    diff = x ; 
    for i = 1:m
        diff(i, : ) = diff(i, : ) - x(idx, : ) ; 
    end
    xi_x = diag(diff * diff'); 
    
    b_opt = y(idx) - ( alp .* y)' * xi_x ; 

    % testing against test data 
    tdata = importdata('test.txt');
    x_test = tdata(:, 1:end-1);
    y_test = tdata(:, end);
    
    y_cal = (w_opt' * x_test')' + b_opt ; 
    % count the mismatches 
    [total , ~ ] = size(y_test);
    [correct, ~] = size(find(y_cal .* y_test > 0 )) ; 
    
    disp('Accuracy : ' ) ; 
    disp(100 * correct / total ) ; 
    
    % foolish forgot the bw parameter
    
end