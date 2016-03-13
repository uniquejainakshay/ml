function [index,matrix] = growTree( Y,X,depth,criteria,init )
    persistent itr  ;
    if init == 1
        itr = 0;
    end
    
    itr = itr + 1;
    id = itr;
    
    
    
    if depth == 0
        index = itr;
        matrix = [itr -1 0 0 0 mode(Y)]; %[itr  feature 1child 0child -1child predictlabel]
        return
    end
    
    if criteria == 1
        attr = bestAttribute(Y,X);
    else
        attr = bestAttributeEntropy(Y,X);
    end
    
    [row,~] = size(Y);
    if sum(Y==1)==row
        index = itr;
        matrix = [itr -1 0 0 0 1]; %[itr  feature 1child 0child -1child predictlabel]
        return 
    end
    
    if sum(Y==0)==row
        index = itr;
        matrix = [itr -1 0 0 0 0]; %[itr  feature 1child 0child -1child predictlabel]
        return 
    end
    
    
    f = X(1,:);
    feature = f(1,attr);
    
    
    f(attr) = [];
    X = X(2:end,:);
    
    X1 = X(find(X(:,attr)==1),:);
    Y1 = Y(find(X(:,attr)==1),:);
    [row1,~] = size(Y1);
    if row1 ~= 0
        X1(:,attr) = [];
        [I1,M1] = growTree(Y1,[f;X1],depth-1,criteria,0);
    else
        itr = itr + 1;
        I1 = itr;
        M1 = [itr -1 0 0 0 -1];
    end
    
    X2 = X(find(X(:,attr)==0),:);
    Y2 = Y(find(X(:,attr)==0),:);
    [row2,~] = size(Y2);
    if row2 ~= 0
        X2(:,attr) = [];
        [I2,M2] = growTree(Y2,[f;X2],depth-1,criteria,0);
    else
        itr = itr + 1;
        I2 = itr;
        M2 = [itr -1 0 0 0 -1];
    end
    X3 = X(find(X(:,attr)==-1),:);
    Y3 = Y(find(X(:,attr)==-1),:);
    [row3,~] = size(Y3);
    if row3 ~= 0
        X3(:,attr) = [];
        [I3,M3] = growTree(Y3,[f;X3],depth-1,criteria,0);
    else
        itr = itr + 1;
        I3 = itr;
        M3 = [itr -1 0 0 0 -1];
    end
    index = id;
    matrix = [[id feature I1 I2 I3 mode(Y)];M1;M2;M3];
end

