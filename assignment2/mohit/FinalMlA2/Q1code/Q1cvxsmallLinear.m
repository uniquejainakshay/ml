 clc
 clear all

rawData=load('fsmall.mat');
featureVector = double(rawData.X);
label = double((rawData.Y)');
loadvalue = 1;

if loadvalue ~= 1
    [rowFV,colFv] = size(featureVector);
    stdDev = zeros(1,colFv);
    meanC = zeros(1,colFv);

    M1 = (label * label') .* (featureVector * featureVector') ;
    disp('M1 found')
    
    b = ones(1,rowFV);
    C = 1;
    y = label;
    cvx_begin
            variable alphaOb(rowFV)
            maximize((-1/2)*(alphaOb'*M1*alphaOb) + b*alphaOb )
            subject to
                alphaOb'*y == 0
                0 <= alphaOb <= C 
    cvx_end
    (-1/2)*alphaOb'*M1*alphaOb + b*alphaOb + C
    alphaOb
    %save alphasmallNormal alphaOb
else
    load('alphaSmallLinear.mat');
end
[rowL,colL] = size(alphaOb);


Yi = (alphaOb.*label);
W =  featureVector'*Yi;


min = 100;
for i = 1:rowL
    if label(i,1)==1
        temp = W' * featureVector(i,:)';
        if temp < min
            min = temp;
        end
    end
end

max = -100;
for i = 1:rowL
    if label(i,1)==-1
        temp = W' * featureVector(i,:)';
        if temp > max
            max = temp;
        end
    end
end

 b = (min + max)*(-1/2);
model = svmtrain(label, featureVector, '-c 1 -t 0');
wsvm = model.SVs' *model.sv_coef ;

 %finding accuracy
 
rawData=load('testsmall.mat');
featureVector = double(rawData.X);
label = double((rawData.Y)');

[row,col] = size(featureVector);




co =0;
for i = 1:row
   temp = label(i,1) * (W' * featureVector(i,:)' + b );
   if temp > 0
       co = co + 1;
   end
end
co/row

[predict_label, accuracy, prob_estimates] = svmpredict(label, featureVector, model);


sv = find(alphaOb>1e-4 & alphaOb<0.9999)
noSv = size(sv,1)


