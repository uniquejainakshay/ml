function lw_linear_regression(x, y, subq, tau)
    	x = (x - mean(x))/std(x); 
    	y = (y - mean(y))/std(y);
	[m , n] = size(x);
	x = [ones(m, 1 ) x];
	n = n + 1 ; 
	%% part a 
		theta = (( x' * x )^ -1) * x' * y ; 
        	scatter(x(:,2), y);
		hold on ; 
		f = @(x) theta(1) + theta(2)*x; 
        	ezplot(f, [-2 , 2, -2 , 2]) ; 
		hold on ; 
	%% part b 
		ht = zeros(m, 1);
		for i = 1:m 
			% x - x(i) gives delta of each example from current point 
            		% ( m x 2 ) ( 2 x m ) ==>> m x m 
	    		diff = x ; 
			for k = 1:m 
				diff(k, :) = diff(k, :) - x(i, :); 
			end;
			t = (diff*diff')/ ( 2 * (tau^2)); 
			w = exp(-t); 
			w = diag(diag(w)); % clear non diagonal elements
			theta_lw = (x'*w*x)\(x'*w*y);
			ht(i) = x(i,:)*theta_lw; 
		end
		%pause(3);
		plot(x(:, 2), ht, 'or'); 
		hold on; 
		
end
