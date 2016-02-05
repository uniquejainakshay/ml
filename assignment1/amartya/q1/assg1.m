% Question 1 - assignment
function y = assg1(type,eta)
 
    x = load('q1x.dat'); 
    y = load('q1y.dat');


    orig_x = x;
    orig_y = y;

    x = (x - mean(x))/std(x); % normalizing the inputs
    y = (y - mean(y))/std(y); % normalizing the inputs

    %eta = 1.8; % initial learning rate
    [m, n] = size(x);

    x = [ones(m,1)  x];%add 1s for theta_zero

    %code for mesh /contour plot
    if (type == 2 || type == 3)
        
        Z = zeros(30);
        th_1 = linspace(-2,2,30);
        th_0 = linspace(-2,2,30);
        [th_0,th_1] = meshgrid(th_0,th_1);
        hyp = zeros(m,1);%the hypothesis values

          for i = 1:30
            for j = 1:30
                    s_error = 0;
                    for k = 1:m
                       hyp(k) =  th_0(i,j)*x(k,1) + th_1(i,j)*x(k,2);
                       error = y(k) - hyp(k);
                       s_error = s_error + error^2;
                    end
                Z(i,j) = s_error/(2*m);
            end
          end
    figure      
    end
    
    if type == 2
        mesh(th_0,th_1,Z);
        xlabel('theta_zero');
        ylabel('theta_one');
        zlabel('J(theta)');
        title('1st question plot');
        hold on;
    end
    
    if type == 3
        %might want to change the axis for y so that all circles come
        
        contour(th_0,th_1,Z);
        
        xlabel('theta zero');
        ylabel('theta one');
        title('1st question plot');
        hold on;
    end    

    %code for mesh plot

    theta_zero = 0;
    theta_one = 0;
    % Add intercept term to 

    theta_n_zero = 0;
    theta_n_one = 0;
    hyp = zeros(m,1);%the hypothesis values
    j = 0;
    lse  = 0;% large initial value to ensure convergence not met at first
    lse_n = 0;

    %code to plot the 2d plot
    if type == 1
        plt = plot(x(1:m,2), y,'+');
        xlabel('x2');
        ylabel('hyp & y');
        title('1st question plot');
        hold on;
        plt2 = plot(x(1:m,2),hyp,'-g');
        
    end
    %code to plot the 2d plot
    if type == 2 || type == 3
        %code for scatter plot to move in mesh and contour plot
        sc_plot = scatter3(theta_n_zero,theta_n_one,lse_n,'filled');
    end
    while(true)
        j =  j+1

        theta_zero = theta_n_zero;
        theta_one = theta_n_one;

        for i = 1:m
            hyp(i) = theta_n_zero*x(i,1) + theta_n_one*x(i,2);
        end
        
        if type == 1
            %update plotted figure for 2d plot
            set(plt2 , 'XData',x(1:m,2),'YData',hyp);
        end
        
        if (type == 2 || type == 3)
            %update plotted figure for scatter plot
            set(sc_plot , 'XData',theta_n_zero,'YData',theta_n_one,'ZData',lse_n);
        end
        
        error = hyp-y;

        lse = lse_n;
        lse_n = (error'*error)/(2*m);

        delta_zero = sum(error)*(1/m);
        delta_one = sum(error.* x(1:m,2))*(1/m);

        theta_n_zero = theta_zero - eta*delta_zero
        theta_n_one = theta_one - eta*delta_one
        
        lse
        lse_n
        
        pause(0.2)

       if(abs(lse_n - lse) <= 0.0000005  || j > 5000)
                break;
       end
    end
    fprintf('I am done!Final theta = %d %d . \n',theta_n_zero,theta_n_one);
    fprintf('Eta value =%d',eta);
    y = j;
    
end
