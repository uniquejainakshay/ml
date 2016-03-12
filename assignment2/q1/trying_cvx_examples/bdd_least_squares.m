% bounded least squares 

function bdd_least_squares()
    m = 16; n = 8;
    A = randn(m,n);
    b = randn(m,1);
    
    bnds = randn(n,2);
    l = min( bnds, [], 2 );
    u = max( bnds, [], 2 );
    x_ls = A \ b; 
    % x_ls is useless since its not the solution to 
    % the constrained problem

    cvx_begin
        variable x(n)
        minimize( norm(A*x-b) )
        % cvx internally minimizes the square of the objective 
        % This makes the problem a QP problem
        subject to 
            l <= x <= u 
    cvx_end
    akshay = 1; 
end