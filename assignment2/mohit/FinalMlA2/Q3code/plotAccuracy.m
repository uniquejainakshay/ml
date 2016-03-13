function [] = plotAccuracy( dTree)
%UNTITLED4 Summary of this function goes here
%   Detailed explanation goes here

nodes = 30;

%plot for training
train = load('train.mat');
train = train.w;
Ytrain = train(:,1);
Xtrain = train(:,2:end);
sizeNodetr = zeros(1,nodes+1);
Accuracytr = zeros(1,nodes+1);
[Accuracytr(1,1),sizeNodetr(1,1)] = expandTree(dTree,0,Xtrain,Ytrain);
for i = 2:nodes+1
    [Accuracytr(1,i),sizeNodetr(1,i) ] = expandTree(dTree,i-1,Xtrain,Ytrain);
end
figure;
plot(sizeNodetr,100*Accuracytr,'b')
hold on
xlim([0 max(sizeNodetr)])
ylim([50 105])

%plot for testing
test = load('test.mat');
test = test.w;
Ytest = test(:,1);
Xtest = test(:,2:end);
sizeNodets = zeros(1,nodes+1);
Accuracyts = zeros(1,nodes+1);
[Accuracyts(1,1),sizeNodets(1,1)] = expandTree(dTree,0,Xtest,Ytest);
for i = 2:nodes+1
    [Accuracyts(1,i),sizeNodets(1,i)] = expandTree(dTree,i-1,Xtest,Ytest);
end
plot(sizeNodets,100*Accuracyts,'r')

%plot for validation
validation = load('validation.mat');
validation = validation.w;
Yv = validation(:,1);
Xv = validation(:,2:end);
sizeNodev = zeros(1,nodes+1);
Accuracyv = zeros(1,nodes+1);
[Accuracyv(1,1),sizeNodev(1,1)] = expandTree(dTree,0,Xv,Yv);
for i = 2:nodes+1
    [Accuracyv(1,i),sizeNodev(1,i)] = expandTree(dTree,i-1,Xv,Yv);
end
%figure 3
plot(sizeNodev,100*Accuracyv,'c')
legend('Training accuracy','Testing accuracy','Validation Accuracy','Location','southeast')
xlabel('Size of Tree')
ylabel('Accuracy')

end

