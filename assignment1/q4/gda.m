function gda()
	x = importdata('q4x.dat'); 
	y = importdata('q4y.dat'); 

	yt = zeros(size(y, 1), 1 ) ;
	for i = 1:size(y,1)
        cmp = strcmp(strtrim(y(i)), 'Alaska');
        if cmp == 1 
			yt(i) = 0 ;
		else 
			yt(i) = 1 ; 
		end
	end
	y = yt; 

	[m , n ] = size(x);
	for i = 1:n
		x(:,i) = (x(:,i) - mean(x(:,i)))/std(x(:,i));
	end;

	ac = 0; % count of alaska 
	cc = 0; % count of canada 
	mu_a= zeros(n,1); % mean vector for alaska  
	mu_c= zeros(n,1); % mean vector for canada 

	for i = 1:m
	    if y(i) == 0
		ac = ac +1;
		mu_a= mu_a+ (x(i,:))';
	    else
		mu_c= mu_c+ (x(i,:))';
		cc= cc+1;
	    end
	end

	mu_a= mu_a/ac;
	mu_c= mu_c/cc;

	%% common covariance 
	sigma = zeros(n);
	for i = 1:m
	    sigma = + ((x(i,:)' - mu_a)*(x(i,:)' - mu_a)');
	end

	sigma = sigma .* (1/m);

	mu_a
	mu_c 
	sigma
%% part A :- completed 
%% part B : plot the data 

	
	class1 = find(y == 0 );
	class2 = find(y == 1 );
	plot(x(class1 , 1), x(class1 ,2), '+r')
	xlabel('x1');
	ylabel('x2');
	hold on;
	plot(x(class2 , 1), x(class2 , 2), 'ob')
	hold on;
	%sigma_inv= inv(sigma );
end
