function [al] = advt_classification ()
    data = importdata('train.txt.small');
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
    % part a completed 
    
    sup_vec = find(y>0.001);

    aj = 1; 
end