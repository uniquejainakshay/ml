%Question 3 assignment 1
function [] = assg3()


x = load('q2x.dat'); 
y = load('q2y.dat');

x(:,1) = (x(:,1) - mean(x(:,1)))/std(x(:,1));
x(:,2) = (x(:,2) - mean(x(:,2)))/std(x(:,2));

[m, n] = size(x);

% Add intercept term to x
x = [ones(m, 1), x]; 

% Plot the training data
% Use different markers for positives and negatives
figure

% Intercept term
thetas = zeros(n+1, 1);

% Newton's method
iter = 0;
J = zeros(iter, 1);

H = zeros(n+1); % Hessian matrix
hyp = zeros(m,1);
G = zeros(n+1,1); %gradient vector

while true

    iter = iter +1;
    
    % Calculate the hypothesis function
    z = x * thetas;
    for b = 1:m
        hyp(b) = 1.0 ./ (1.0 + exp(-z(b)));
    end
    
    % gradient
    for c = 1:n+1
        G(c) = sum(x(:,c) .* (y-hyp));
    end
    G
    
    %hessian
    for b = 1:n+1
        for c = 1:n+1
            H(b,c) = sum(-hyp.*(1-hyp).* x(:,b).*x(:,c));
        end
    end
    H 
    
    % Calculate J (for testing convergence)
    %J(i) =(1/m)*sum(-y.*log(hyp) - (1-y).*log(1-hyp));
    
    thetas = thetas - H\G;
    
    iter
    if ( abs(G(1)) <= 0.004 && abs(G(2)) <= 0.004 && abs(G(3)) <= 0.004)
        break;
    end
end
% Display theta
thetas

% Plot Newton's method result

positives = find(y);
negatives = find(y == 0);
plot(x(positives, 2), x(positives,3), '+r')
xlabel('x1');
ylabel('x2');
title('question 3 plot');
hold on
plot(x(negatives, 2), x(negatives, 3), 'og')
hold on

plot_x = [min(x(:,2))   max(x(:,2))]% choosing the end points
% Calculate the decision boundary line
plot_y = (-1./thetas(3)).*(thetas(2).*plot_x +thetas(1))

plot(plot_x, plot_y)
end