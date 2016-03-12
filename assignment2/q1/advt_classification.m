function advt_classification ()
    data = importdata('train.txt');
    x = data(:, 1:end-1);
    y = data(: , end ) ; 
    [m , ~ ] = size(x); 

    temp = diag(y) * x; 
    Q = temp * temp'; 

    cvx_begin 
        variable alp(m, 1);
        variable b(m, 1);
        l = zeros(m , 1); 
        u = ones(m , 1 ); 
        %variable c 
        
        maximize(alp' * Q * alp + b' * alp) ;
        %minimize( -(alp' * Q * alp + b' * alp + c )) ;
        
        

        
        
        subject to 
            l <= alp <= u;
            alp' * y == 0; 
    cvx_end 


    aj = 1; 
end