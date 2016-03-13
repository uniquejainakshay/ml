clear all
clc
tic
mainFile =  load('mnist_all.mat');

train3 = double(mainFile.train3)/255;
train8 = double(mainFile.train8)/255;

thetaL1 = 0.1*randn(100,785);
thetaL2 = 0.1*randn(2,100);


%mixing data

[row3,col] = size(train3);
[row8,col] = size(train8);
train3Index = 1;
train8Index = 1;
trainSet = zeros(row3+row8,col);
Y = zeros(row3+row8,1);
index = 0;
while(train3Index <= row3 && train8Index <=row8 )
   index = index + 1;
   if mod(index,2) == 1
       Y(index,1) = 1;     
       trainSet(index,:) = train3(train3Index,:);
       train3Index = train3Index + 1;
   else
       Y(index,1) = 0;   
       trainSet(index,:) = train8(train8Index,:);
       train8Index = train8Index + 1;
   end  
end

while(train3Index<=row3)
    index = index + 1;
    Y(index,1) = 1;
    trainSet(index,:) = train3(train3Index,:);
    train3Index = train3Index + 1;
end

 clear train3,train8;

[row,col] = size(trainSet);
lastJ = 100;
threshold = 0.1;
i = 1;
t = 1;
sumchnge = 0;
lastsum = 0;
while(1)
    
    x = [1 trainSet(i,:)];
    [OjL1,OjL2] = OutputOj([1 trainSet(i,:)],thetaL1,thetaL2) ;
    
    if Y(i,1) == 1
      Y1 = 1;
      Y2 = 0;
    else
      Y1 = 0;
      Y2 = 1;
    end
    
    J = 0.5*((Y1-OjL2(1,1))^2 + (Y1-OjL2(1,1))^2);
    
    %checking for convergence
    chnge = abs(J-lastJ);
    sumchnge = sumchnge + chnge;
%     if chnge < threshold
%         break
%     end
%      
    n = 1/sqrt(t);
      
   %updating theta values for layer 2
   delJnet1 = (Y1 - OjL2(1,1))*(-1)*OjL2(1,1)*(1-OjL2(1,1));
   delJQ1 = delJnet1 * OjL1;
   thetaL2(1,:) = thetaL2(1,:) - n*(delJQ1);
   
   delJnet2 = (Y2 - OjL2(1,2))*(-1)*OjL2(1,2)*(1-OjL2(1,2));
   delJQ2 = delJnet2 * OjL1;
   thetaL2(2,:) = thetaL2(2,:) - n*(delJQ2);
   
   %updating theta values for layer 1
   
   delJnetI = delJnet1*(thetaL2(1,:).*(OjL1.*(1-OjL1)))+delJnet2*(thetaL2(2,:).*(OjL1.*(1-OjL1)));
   
   for j = 1:100
      delJQI = delJnetI(1,j) * x;
      thetaL1(j,:) = thetaL1(j,:) - n*(delJQI);
   end
 
   lastJ = J;
   i = i+1;
   
   if i == row
       i = 1;
       t = t+1
       if abs(sumchnge - lastsum) < threshold
          break
       end
       lastsum = sumchnge
       sumchnge = 0;
       
   end
end

trainingTime = toc

co = 0;
for i = 1:row
    
    [OjL1,OjL2] = OutputOj([1 trainSet(i,:)],thetaL1,thetaL2) ;
    if OjL2(1,1) > OjL2(1,2)
       class = 1;
    else
        class = 0 ;
    end
    
    if Y(i,1) == class
        co = co + 1;
    end
end

trainA=co/row

test3 = double(mainFile.test3)/255;
[row3,col] = size(test3);
co3 = 0;
for i = 1:row3
     
    [OjL1,OjL2] = OutputOj([1 test3(i,:)],thetaL1,thetaL2) ;
    if OjL2(1,1)>OjL2(1,2)
       co3 = co3+1; 
    end
end
A3=co3/row3

test8 = double(mainFile.test8)/255;
[row8,col] = size(test8);
co8 = 0;
for i = 1:row8
     
    [OjL1,OjL2] = OutputOj([1 test8(i,:)],thetaL1,thetaL2) ;
    if OjL2(1,1)<OjL2(1,2)
       co8 = co8+1; 
    end
end
A8=co8/row8

cumulativeAccuracy = (co3+co8)/(row3+row8)
toc


