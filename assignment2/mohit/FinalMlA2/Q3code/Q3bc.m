clc 
clear all

train = load('train.mat');
train = train.w;
[row,col] = size(train)

Y = train(:,1);
X = train(:,2:col);
X = [[1,2,3,4,5,6,7,8,9,10,11,12,13,14,15,16];X];

a = bestAttributeEntropy(Y,X);

[indx,dTree] = growTree(Y,X,16,2,1)
plotAccuracy(dTree)
title('Accuracy over original Tree')

% loading training data
 Xtrain = X(2:row+1,:);
 Ytrain = Y;

 %loading testing data 
 test = load('test.mat');
 test = test.w;
[row,col] = size(test);
 Ytest = test(:,1);
 Xtest = test(:,2:col);

 %loading validation data
[rowts,~] = size(X);
validation = load('validation.mat');
validation = validation.w;
Yv = validation(:,1);
Xv = validation(:,2:col);

disp('Accuracies over unpruned tree')
AccTrain = Accuracy(Xtrain,Ytrain,dTree,16)
AccTest = Accuracy(Xtest,Ytest,dTree,16)
AccVal = Accuracy(Xv,Yv,dTree,16)

AccTrain = zeros(1,10);
AccTest  = zeros(1,10);
AccVal   = zeros(1,10);
sizeNode = zeros(1,10);
%PRUNING
id = 0
while(1)
    [rowtree,coltree] = size(dTree);
    pruneNode = zeros(rowtree,coltree);
    indx = 0;
    Acc = Accuracy(Xv,Yv,dTree,16);
    %first building set of non leaf nodes
    for i = 1:rowtree
       if dTree(i,2) ~= -1 
            if isReachable(dTree,dTree(i,1),1)==1
               indx = indx + 1;
               pruneNode(indx,:) = dTree(i,:);
            else
               dTree(i,2) = -1;
            end
       end
    end

    pruneNode = pruneNode(1:indx,:);
   
    flag = -1;
    indx = -1;
    for i = 1:size(pruneNode);
        node = pruneNode(i,:);
        ind = node(1,1);
        newdtree = dTree;
        newdtree(ind,2) = -1;
        acc = Accuracy(Xv,Yv,newdtree,16);
        if acc > Acc ||( acc>=Acc && indx == -1 )
            Acc = acc;
            indx = i;
            flag = 1;
        end
    end
   
    if flag == -1
        break
    else
        pruneNodeidx = pruneNode(indx,1)
        dTree(pruneNodeidx,2)  = -1 ;
    end
    id = id + 1;
    [AccTrain(1,id),sizeNode(1,id)] = expandTree( dTree,50,Xtrain,Ytrain );
    AccTest(1,id) = Accuracy(Xtest,Ytest,dTree,16);
    AccVal(1,id) = Accuracy(Xv,Yv,dTree,16);
    
end

AccTrain= AccTrain(1,1:id);
AccTest = AccTest(1,1:id);
AccVal  = AccVal(1,1:id);
sizeNode= sizeNode(1,1:id);

figure;
plot(sizeNode,100*AccTrain,'b')
hold on
xlim([(min(sizeNode)-2) (max(sizeNode)+2)])
ylim([50 105])
plot(sizeNode,100*AccTest,'r')
plot(sizeNode,100*AccVal,'c')
title('Accuracy while pruning')
legend('Training accuracy','Testing accuracy','Validation Accuracy','Location','southeast')
xlabel('Number of nodes')
ylabel('Accuracy')

plotAccuracy(dTree)
title('Accuracy over pruned Tree')
disp('Accuracy over pruned Tree')
AccTrain = Accuracy(Xtrain,Ytrain,dTree,16)
AccTest = Accuracy(Xtest,Ytest,dTree,16)
AccVal = Accuracy(Xv,Yv,dTree,16)

dTree



