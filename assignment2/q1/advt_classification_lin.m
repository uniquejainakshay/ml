function [al] = advt_classification_lin ()
    data = importdata('train.txt');
    x = data(:, 1:end-1);
    y = data(: , end ) ; 
    [m , ~ ] = size(x); 

    temp = diag(y) * x; 
    Q = temp * temp'; 
    
    b = ones(m, 1);
	l = zeros(m , 1); 
	u = ones(m , 1 ); 
    

    cvx_begin 
        variable alp(m, 1);
        
        maximize(-alp' * Q * alp + b' * alp ) ;
        %minimize( -(alp' * Q * alp + b' * alp + c )) ;
        
        subject to 
            l <=  alp <= u;
            alp' * y == 0; 
    cvx_end
    al = alp;
    sup_vec = find(0.0001 < alp & alp < 0.999999);
    sup_vec
    %% part a completed -------------------------------------------
    
    % calculate optimal w*
    % TODO : optimize this calculation, use only support vectors 
    w_opt = ((alp .* y)' * x)'; 
    
    %calculate optimal b*
    wx = (w_opt' * x')' ;
    ma = max(wx(find(y==-1), :)); 
    mi = min(wx(find(y== 1), :)); 
    b_opt = -( ma + mi ) / 2.0 ;
    
    % classify the test data 
    
    tdata = importdata('test.txt');
    x_test = tdata(:, 1:end-1);
    y_test = tdata(:, end);
    
    y_cal = (w_opt' * x_test')' + b_opt ; 
    % count the mismatches 
    [total , ~ ] = size(y_test);
    [correct, ~] = size(find(y_cal .* y_test > 0 )) ; 
    
    disp('Accuracy : ' ) ; 
    disp(100 * correct / total ) ; 
    %% part B completed -------------------------------------------
end