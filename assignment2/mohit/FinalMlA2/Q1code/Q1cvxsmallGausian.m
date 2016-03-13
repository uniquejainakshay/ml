 clc
 clear all

 rawData=load('fsmall.mat');
 featureVector = double(rawData.X);
 label = double((rawData.Y)');
 gamma = 0.00025;
 loadvalue = 1;
 
 if loadvalue~=1
    disp('running cvx')
    [rowFV,colFv] = size(featureVector);
    G = zeros(rowFV,rowFV);
    gamma = 0.00025;
    for i = 1:rowFV
       G(i,i) = 1;
       for j = i+1 : rowFV
           xny = featureVector(i,:)-featureVector(j,:);
           Normxny = xny*xny';
           G(i,j) = exp(-Normxny*gamma);
           G(j,i) = G(i,j);
       end
    end

    M1 = (label * label') .* G;
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

 else
    disp('loading values')
    t = load('alphaSmallGausian.mat');
    alphaOb = double(t.alphaOb);
 end

[rowL,colL] = size(alphaOb);

labelSv = label;
featureVectorSv = featureVector;
alphaObSv = alphaOb;

[rowL,colL] = size(featureVectorSv);

 indx = find(alphaObSv==max(alphaObSv(find(alphaObSv>1e-4 & alphaObSv<0.9999)))) 
 
 ySample = labelSv(indx,1)
 x = featureVectorSv(indx,:);
 a = alphaObSv(indx,1);
 sum = 0;
 for j = 1:rowL
    sum = sum + labelSv(j,1) * alphaObSv(j,1) * GausianO(x,featureVectorSv(j,:),gamma); 
 end
 temp = sum;
 b = ySample - sum 
 
 
 %finding accuracy
 
rawData=load('testsmall.mat');
featureVectortest = double(rawData.X);
labeltest = double((rawData.Y)');

[row,col] = size(featureVectortest);

co =0;
for i = 1:row
   x = featureVectortest(i,:);
   sum = 0;
   for j = 1:rowL
       sum = sum + labelSv(j,1) * alphaObSv(j,1) * GausianO(x,featureVectorSv(j,:),gamma); 
   end
   if (sum+b)*labeltest(i,1) > 0
       co = co + 1;
       labeltest(i,1);
   end
end
co/row

%
sv = find(alphaOb>1e-4 & alphaOb<0.9999);
Nosv = size(sv,1)

model = svmtrain(label, featureVector, '-c 1 -t 2 -g 0.00025');
[predict_label, accuracy, prob_estimates] = svmpredict(labeltest, featureVectortest, model);

sv = model.sv_indices;

