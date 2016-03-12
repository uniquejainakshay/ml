function y = q2(j,i)
    load('mnist_all.mat')
    if j == 1
        x = train1(i,:)
    end
    if j == 2
        x = train2(i,:)
    end
    if j == 3
        x = train3(i,:)
    end
    if j == 4
        x = train4(i,:)
    end
    if j == 5
        x = train5(i,:)
    end
    if j == 6
        x = train6(i,:)
    end
    if j == 7
        x = train7(i,:)
    end
    if j == 8
        x = train8(i,:)
    end
    
    
    img_matrix = zeros(28,28);
    u=1;
    for i = 1:28
        for j = 1:28
            img_matrix(i,j) = x(u);
            u = u+1
        end
    end

    image(img_matrix)
end