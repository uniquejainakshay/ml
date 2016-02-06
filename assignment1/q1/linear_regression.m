%X = importdata('q1x.dat'); 
%Y = importdata('q1y.dat');
% th = linear_regression(0.000001, X , Y ) ; 


function [th] = linear_regression(eta, x, y, graph)  
    x = (x - mean(x))/std(x); 
    y = (y - mean(y))/std(y);
    
    [m , n ] = size(x);
    x = [ones(m , 1) x ];
    n = n + 1 ;  
    
    % graph plotting %
    if graph == 'b' 
        scatter(x, y);
        hold on ;
    elseif (graph == 'c' || graph == 'd' )   % draw J(theta) mesh 
        [m1, m2] = meshgrid(-2:0.05:2);
        jtheta = @(theta0, theta1) (1/(2*size(y, 1)))*(( y - (x * ([theta0 theta1]')) )' * ( y - (x * ([theta0 theta1]')) ));
        Z = zeros(size(m1));
        for i = 1:size(m1, 1)
            for j  = 1:size(m1, 2)
                Z(i,j) = jtheta(m1(i, j), m2(i, j));
            end
        end
        if graph == 'c' 
            mesh(m1, m2, Z);    
        elseif graph == 'd' 
            contour(m1, m2 , Z) ; 
        end 
        hold on; 
    end
        
    
    j = 0 ;
    theta = zeros(n,1);
    iter = 0 ;
    while 1 < 2
        iter = iter + 1 ; 
        prevj = j ; % storing this for termination condition
        error = y - x * theta; 
        theta = theta + (eta * (error' * x))';
        
        j = ( error' * error ) / ( 2 * m )  ;
        if ( abs ( prevj - j ) < 0.00000005 )
            break;
        end
        
        if (graph == 'c'  || graph == 'd' ) 
            scatter3(theta(1, 1), theta(2, 1) , j) ; 
            pause(0.2);
            hold on ;
        end
        
    end
    disp(iter); 
    th = theta; 
    if graph == 'b' 
        f = @(q) theta(2,1)*q + theta(1, 1);
        ezplot(f, [-1 , 24, -1 , 24]) ; 
        hold on ; 
    end
end
