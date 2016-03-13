clear all
clc
mainFile =  load('mnist_all.mat');

train1 = double(mainFile.train1)/255;
train2 = double(mainFile.train2)/255;
train3 = double(mainFile.train3)/255;
train4 = double(mainFile.train4)/255;
train5 = double(mainFile.train5)/255;
train6 = double(mainFile.train6)/255;
train7 = double(mainFile.train7)/255;
train8 = double(mainFile.train8)/255;
train9 = double(mainFile.train9)/255;
train10 = double(mainFile.train0)/255;

sz = zeros(10,1);

for i = 1:10
    str = sprintf('train%d',i);
    [row,col] = size(eval(str));
    sz(i,1) = row;    
end

%mixing data

totalRow = 54200;
trainIndex = ones(10,1);

trainSet = zeros(totalRow,col);
Y = zeros(totalRow,10);
index = 0;


while(index<totalRow)
    index = index + 1;
    flag = 1;  
    if mod(index,10) == 2 || flag == -1
        if trainIndex(2,1) < sz(2,1)
           Y(index,:) = [0 1 0 0 0 0 0 0 0 0];
           trainSet(index,:) = train2(trainIndex(2,1),:);
           trainIndex(2,1) = trainIndex(2,1) + 1;
           continue
        else
            flag = -1;
        end
    end
    
    if mod(index,10) == 3 || flag == -1
        if trainIndex(3,1) < sz(3,1)
           Y(index,:) = [0 0 1 0 0 0 0 0 0 0];
           trainSet(index,:) = train3(trainIndex(3,1),:);
           trainIndex(3,1) = trainIndex(3,1) + 1;
           continue
        else
            flag = -1;
        end
    end
    
    if mod(index,10) == 4 || flag == -1
        if trainIndex(4,1) < sz(4,1)
           Y(index,:) = [0 0 0 1 0 0 0 0 0 0];
           trainSet(index,:) = train4(trainIndex(4,1),:);
           trainIndex(4,1) = trainIndex(4,1) + 1;
           continue
        else
            flag = -1;
        end
    end
    
    if mod(index,10) == 5 || flag == -1
        if trainIndex(5,1) < sz(5,1)
          Y(index,:) = [0 0 0 0 1 0 0 0 0 0];
           trainSet(index,:) = train5(trainIndex(5,1),:);
           trainIndex(5,1) = trainIndex(5,1) + 1;
           continue
        else
            flag = -1;
        end
    end
    
    if mod(index,10) == 6 || flag == -1
        if trainIndex(6,1) < sz(6,1)
           Y(index,:) = [0 0 0 0 0 1 0 0 0 0];
           trainSet(index,:) = train6(trainIndex(6,1),:);
           trainIndex(6,1) = trainIndex(6,1) + 1;
           continue
        else
            flag = -1;
        end
    end
    
    if mod(index,10) == 7 || flag == -1
        if trainIndex(7,1) < sz(7,1)
           Y(index,:) = [0 0 0 0 0 0 1 0 0 0];
           trainSet(index,:) = train7(trainIndex(7,1),:);
           trainIndex(7,1) = trainIndex(7,1) + 1;
           continue
        else
            flag = -1;
        end
    end
    
    if mod(index,10) == 8 || flag == -1
        if trainIndex(8,1) < sz(8,1)
           Y(index,:) = [0 0 0 0 0 0 0 1 0 0];
           trainSet(index,:) = train8(trainIndex(8,1),:);
           trainIndex(8,1) = trainIndex(8,1) + 1;
           continue
        else
            flag = -1;
        end
    end
    
    if mod(index,10) == 9 || flag == -1
        if trainIndex(9,1) < sz(9,1)
           Y(index,:) = [0 0 0 0 0 0 0 0 1 0];
           trainSet(index,:) = train9(trainIndex(9,1),:);
           trainIndex(9,1) = trainIndex(9,1) + 1;
           continue
        else
            flag = -1;
        end
    end
    
    if mod(index,10) == 0 || flag == -1
        if trainIndex(10,1) < sz(10,1)
           Y(index,:) = [0 0 0 0 0 0 0 0 0 1];
           trainSet(index,:) = train10(trainIndex(10,1),:);
           trainIndex(10,1) = trainIndex(10,1) + 1;
           continue
        else
            flag = -1;
        end
    end
    
    if mod(index,10) == 1 || flag == -1
        if trainIndex(1,1) < sz(1,1)
           Y(index,:) = [1 0 0 0 0 0 0 0 0 0];
           trainSet(index,:) = train1(trainIndex(1,1),:);
           trainIndex(1,1) = trainIndex(1,1) + 1;
           continue
        else
            flag = -1;
        end
    end
    
   
end


 clear train1;train2;train3;train4;train5;train6;train7;train8;train9;train10;

thetaL1 = 0.1*randn(100,785);
thetaL2 = 0.1*randn(10,100);

[row,col] = size(trainSet);
lastJ = 100;
threshold = 50;

i = 1;
t = 1;
sumchnge = 0;
lastsum = 0;
tic
while(1)
    
    
    x = [1 trainSet(i,:)];
    [OjL1,OjL2] = OutputOn([1 trainSet(i,:)],thetaL1,thetaL2) ;
    Yi = Y(i,:)';
    diff = Y(i,:) - OjL2;
    J = 0.5 * (diff * diff');
   
    %checking for convergence
    chnge = abs(J-lastJ);
    sumchnge = sumchnge + chnge;
     
    n = 1/sqrt(t);
   
   delJnetL2 = zeros(10,1);
   for j = 1:10
      delJnetL2(j,1) = (Yi(j,1)-OjL2(1,j))*(-1) * OjL2(1,j) * (1-OjL2(1,j)); 
      delJQ1 = delJnetL2(j,1) * OjL1;
      thetaL2(j,:) = thetaL2(j,:) - n*(delJQ1);
   end
  
   delJnetI = zeros(1,100);
   for j  = 1:10
       delJnetI = delJnetI + delJnetL2(j,1)*(thetaL2(j,:).*(OjL1.*(1-OjL1)));
   end
   
   for j = 1:100
      delJQI = delJnetI(1,j) * x;
      thetaL1(j,:) = thetaL1(j,:) - n*(delJQI);
   end
 
   lastJ = J;
   i = i+1;
   
   if i == row
       t = t+1
       i=1;
       if abs(sumchnge - lastsum) < threshold
          break
       end
       lastsum = sumchnge
       sumchnge = 0;
   end
end
trainingTime = toc


%finding accuracy
co = 0;
for i = 1:row
   [OjL1,OjL2] = OutputOj([1 trainSet(i,:)],thetaL1,thetaL2) ; 
   index = find(OjL2==max(OjL2));
   if (Y(i,index)==1)
       co = co + 1;
   end
end
trAcc = co/row

test1 = double(mainFile.test1)/255;
test2 = double(mainFile.test2)/255;
test3 = double(mainFile.test3)/255;
test4 = double(mainFile.test4)/255;
test5 = double(mainFile.test5)/255;
test6 = double(mainFile.test6)/255;
test7 = double(mainFile.test7)/255;
test8 = double(mainFile.test8)/255;
test9 = double(mainFile.test9)/255;
test10 = double(mainFile.test0)/255;

[row1,col] = size(test1);
co1 = 0;
for i = 1:row1
     
    [OjL1,OjL2] = OutputOn([1 test1(i,:)],thetaL1,thetaL2) ;
    index = find(OjL2==max(OjL2));
    if index == 1
        co1 = co1 +1;
    end
end
A1=co1/row1

[row2,col] = size(test2);
co2 = 0;
for i = 1:row2
     
    [OjL1,OjL2] = OutputOn([1 test2(i,:)],thetaL1,thetaL2) ;
    index = find(OjL2==max(OjL2));
    if index == 2
        co2 = co2 +1;
    end
end
A2=co2/row2

[row3,col] = size(test3);
co3 = 0;
for i = 1:row3
     
    [OjL1,OjL2] = OutputOn([1 test3(i,:)],thetaL1,thetaL2) ;
    index = find(OjL2==max(OjL2));
    if index == 3
        co3 = co3 +1;
    end
end
A3=co3/row3


[row4,col] = size(test4);
co4 = 0;
for i = 1:row4
     
    [OjL1,OjL2] = OutputOn([1 test4(i,:)],thetaL1,thetaL2) ;
    index = find(OjL2==max(OjL2));
    if index == 4
        co4 = co4 +1;
    end
end
A4=co4/row4

[row5,col] = size(test5);
co5 = 0;
for i = 1:row5
     
    [OjL1,OjL2] = OutputOn([1 test5(i,:)],thetaL1,thetaL2) ;
    index = find(OjL2==max(OjL2));
    if index == 5
        co5 = co5 +1;
    end
end
A5=co5/row5


[row6,col] = size(test6);
co6 = 0;
for i = 1:row6
     
    [OjL1,OjL2] = OutputOn([1 test6(i,:)],thetaL1,thetaL2) ;
    index = find(OjL2==max(OjL2));
    if index == 6
        co6 = co6 +1;
    end
end
A6=co6/row6

[row7,col] = size(test7);
co7 = 0;
for i = 1:row7
     
    [OjL1,OjL2] = OutputOn([1 test7(i,:)],thetaL1,thetaL2) ;
    index = find(OjL2==max(OjL2));
    if index == 7
        co7 = co7 +1;
    end
end
A7=co7/row7


[row8,col] = size(test8);
co8 = 0;
for i = 1:row8
     
    [OjL1,OjL2] = OutputOn([1 test8(i,:)],thetaL1,thetaL2) ;
    index = find(OjL2==max(OjL2));
    if index == 8
        co8 = co8 +1;
    end
end
A8=co8/row8

[row9,col] = size(test9);
co9 = 0;
for i = 1:row9
     
    [OjL1,OjL2] = OutputOn([1 test9(i,:)],thetaL1,thetaL2) ;
    index = find(OjL2==max(OjL2));
    if index == 9
        co9 = co9 +1;
    end
end
A9=co9/row9

[row0,col] = size(test10);
co0 = 0;
for i = 1:row0
    [OjL1,OjL2] = OutputOn([1 test10(i,:)],thetaL1,thetaL2) ;
    index = find(OjL2==max(OjL2));
    if index == 10
        co0 = co0 +1;
    end
end
A10=co0/row0


cumulativeAccuracy = (co0+co1+co2+co3 +co4 +co5+co6+co7+co8+co9)/(row0+row1+row2+row3+row4+row5+row6+row7+row8+row9)
% 
% co = 0;
% for i = 1:row
%     
%     [OjL1,OjL2] = OutputOj([1 trainSet(i,:)],thetaL1,thetaL2) ;
%     if OjL2(1,1) > OjL2(1,2)
%        class = 1;
%     else
%         class = 0 ;
%     end
%     
%     if Y(i,1) == class
%         co = co + 1;
%     end
% end
% 
% trainA=co/row
% 
% test3 = double(mainFile.test3)/255;
% [row,col] = size(test3);
% co = 0;
% for i = 1:row
%      
%     [OjL1,OjL2] = OutputOj([1 test3(i,:)],thetaL1,thetaL2) ;
%     if OjL2(1,1)>OjL2(1,2)
%        co = co+1; 
%     end
% end
% A3=co/row
% 
% test8 = double(mainFile.test8)/255;
% [row,col] = size(test8);
% co = 0;
% for i = 1:row
%      
%     [OjL1,OjL2] = OutputOj([1 test8(i,:)],thetaL1,thetaL2) ;
%     if OjL2(1,1)<OjL2(1,2)
%        co = co+1; 
%     end
% end
% A8=co/row
% 
% 
