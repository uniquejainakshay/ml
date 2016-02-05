%Question 2 of assignment 1
function [] = assg2(type,tau)
    %clear all; close all; clc
    x = load('q3x.dat'); 
    y = load('q3y.dat');


    orig_x = x;
    orig_y = y;

    x = (x - mean(x))/std(x); % normalizing the inputs
    %y = (y - mean(y))/std(y); % normalizing the inputs

    [m, n] = size(x);

    x = [ones(m,1)  x];%add 1s for theta_zero
    X = x;
    Y = y;
    hyp = zeros(m,1);
    if type == 2
        
        for i = 1:m
            W_diag = exp(-(X(i,2) - X(:,2)).^2./(2*tau^2));
            W = diag(W_diag)
            theta_opt = (X'* W * X)\(X'* W * Y)
            hyp(i) = X(i,:)*theta_opt ;
        end
    end
    
    %optimal theta
    
    if type == 1
        theta_opt = (X'* X)\(X'* Y) ;
        hyp = X * theta_opt ;
    end
    plot(x(1:m,2), y,'+');
    xlabel('x2');
    ylabel('hyp and y');
    title('2nd question plot '); 
    hold on;
    plot(x(1:m,2),hyp,'og');
    y = theta_opt;
end
