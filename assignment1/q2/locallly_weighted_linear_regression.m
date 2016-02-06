function lw_linear_regression(x, y, subq)
    	x = (x - mean(x))/std(x); 
    	y = (y - mean(y))/std(y);
	[m , n] = size(x);
	x = [ones(m, 1 ) x];
	n = n + 1 ; 
	disp('here');
	if subq == 'b' 
		theta = (( x' * x )^ -1) * x' * y ; 
        	scatter(x(:,2), y);
		f = @(x) theta(1) + theta(2)*x; 
        	ezplot(f, [-1 , 24, -1 , 24]) ; 
		hold on ; 
	end
end
