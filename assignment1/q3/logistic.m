function logistic()
	x = importdata('q2x.dat'); 
	y = importdata('q2y.dat'); 

	[m , n] = size(x);

	for i = 1:n
		x(:, i) = (x(:, i)-mean(x(:, i))) / std(x(:, i)); 
	end
	y = (y-mean(y)) / std(y);

	x = [ones(m, 1 ) x];
	n = n + 1 ; 

	% here we start with some theta and converge to
	% optimal theta 
	theta = zeros(n , 1) ; 


	% Hessian : 
	% Each element Hij here is defined by 
	% H(i , j ) = x(i) * x(j) * g(theta'*x) * (1-g(theta'*x))
	H = zeros(n, n ) ; 

	% Gradient : 
	% 
	G = zeros(n,1); 

	count = 0 ;
	while true 
		% calculate ht = 1/(1+exp(theta*x)) 
		ht = 1/(1+exp(-x * theta )); % (x*theta) (nx1)

		% calculate the Hessian matrix 
		H = x' * x * (ht * ( ht - 1 )'); % ( H -> n x n ) 

		% the gradient Matrix 
		G = x' * ( y - ht') ; % (G ->  n x 1 )  

		theta = theta - H\G ; 
		% lets run till 100 iterations 
		count = count + 1 
		if count == 1
			break 
		end
	end;
	% plotting the graph 
	class1 = find(y > 0 );
	class2 = find(y < 0);
	% plot both the classes 
	plot(x(class1 , 2), x(class1 ,3), '+r')
	xlabel('x1');
	ylabel('x2');
	hold on;
	plot(x(class2 , 2), x(class2 , 3), 'ob')
	hold on

	% plotting the decision boundary 

	% the equation is ( th0 + th1 x1 + th2 x2 = 0 ) 
	% rewriting the equation (  x2 = - (th0 + th1 x1 )/ th2 )     
	f = @(p) -(theta(1)+theta(2)*p)/theta(3);
	ezplot(f, [-3, 3, -3, 3 ]);
end
