clc 
clear all

train = load('train.mat');
train = train.w;
[row,col] = size(train)

Y = train(:,1);
X = train(:,2:col);
X = [[1,2,3,4,5,6,7,8,9,10,11,12,13,14,15,16];X];

a = bestAttributeEntropy(Y,X);

[indx,dTree] = growTree(Y,X,16,1,1)
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
 
 %loading validation set
validation = load('validation.mat');
validation = validation.w;
Yv = validation(:,1);
Xv = validation(:,2:col);


AccTrain = Accuracy(Xtrain,Ytrain,dTree,1)
AccTest = Accuracy(Xtest,Ytest,dTree,1)
AccVal = Accuracy(Xv,Yv,dTree,1)



