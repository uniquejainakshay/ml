function [] = assg4()
%clear all; close all; clc

x = load('q4x.dat'); 
%y = fopen('q4y.dat');
txt = textread('q4y.dat', '%s', 'delimiter', '\n','whitespace', '');


x(:,1) = (x(:,1) - mean(x(:,1)))/std(x(:,1));
x(:,2) = (x(:,2) - mean(x(:,2)))/std(x(:,2));
[m, n] = size(x);

for i = 1:m
    if( strcmp(txt(i),'Alaska') == 0)
        y(i) = 1;
    else
        y(i) = 0;
    end
end

n_canada = 0;
n_alaska = 0;
mu_alaska = zeros(n,1);
mu_canada = zeros(n,1);

for i = 1:m
    if y(i) == 1
        
        n_alaska = n_alaska+1;
        mu_alaska = mu_alaska + (x(i,:))';
        
    else
        mu_canada = mu_canada + (x(i,:))';
        n_canada = n_canada+1;
    end
end

mu_canada  = mu_canada.*(1/n_canada)
mu_alaska  = mu_alaska .*(1/n_alaska)

cov = zeros(n);
for i = 1:m
    cov = cov + ((x(i,:)' - mu_alaska)*(x(i,:)' - mu_alaska)');
end

cov = cov .* (1/m)
icov = inv(cov);
phi_alaska = n_alaska/m  % this is p(y = alaska)
phi_canada = 1 - phi_alaska % p(y = canada)

p_x_alaska = (1/(2*pi*sqrt(det(cov))))*exp(-0.5);  % p(x|y=alaska)

%Cov -1 - Covariance for alaska
cov1 = zeros(n);

%Cov - 2 - Covariance for canada
cov2 = zeros(n);

for i =  1:m
    if y(i) == 1
        cov1 = cov1 + ((x(i,:)' - mu_alaska)*(x(i,:)' - mu_alaska)');
    else
        cov2 = cov2 + ((x(i,:)' - mu_canada)*(x(i,:)' - mu_canada)');
    end
end

cov1 = cov1 ./ n_alaska 
icov1 = inv(cov1);
cov2 = cov2 ./ n_canada 
icov2 = inv(cov2);
% Plot the training data
% Use different markers for alaska and canada

figure
alaska = find(y); canada = find(y == 0); %class1 - alaska , class2 - canada
plot(x(alaska, 1), x(alaska,2), '+r')
xlabel('x1 - fresh water');
ylabel('x2 - marine water');
title('Question 4 plot');
hold on
plot(x(canada, 1), x(canada, 2), 'og')
hold on

% Plot Newton's method result
plot_x = [min(x(:,2)) max(x(:,2))];% choosing the end points
% Calculate the decision boundary line
%RHS of the separator - Observations - mu_canada = -mu_alpha
A = (0.5).*((mu_alaska)'*icov*mu_alaska);
plot_y = (A -(plot_x*icov(1,1)*mu_alaska(1) + plot_x*icov(1,2)*mu_alaska(2)))/(icov(1,2)*mu_alaska(1)+icov(2,2)*mu_alaska(2));
plot(plot_x, plot_y);
hold on;
%form equations for qda

%plot_x = linspace(-2.5,2.5,50);
cov_ratio = log(det(cov2)/det(cov1));
sep_func  = @(u) (u'*(icov2 - icov1)*u +2*u'*(icov1+icov2)*mu_alaska + cov_ratio);
%sep_func_2 = @(v)( (v - mu_canada)'*icov2*(v - mu_canada) + log(det(cov2)) + log(0.5));


plot_x1 = linspace(-2.5,2.5,50);
plot_x2 = linspace(-2.5,2.5,50);

cls_line = zeros(1,50);
for i = 1:50
    plot_x = [plot_x1(i);plot_x2(i)];
    cls_line(i) = sep_func(plot_x);
    
end

plot(plot_x1,cls_line);


end