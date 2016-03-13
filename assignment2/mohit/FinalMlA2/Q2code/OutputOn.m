function [ OjL1,OjL2 ] = OutputOn(x,thetaL1,thetaL2)

%function for finding Oj and returning them also
% i = 1;
% x = train3(i,:);

OjL1 =  x * thetaL1';
for i = 1:100
    OjL1(1,i) = sigmoidFn(OjL1(1,i));
end

OjL2 = OjL1 * thetaL2';
for i = 1:10
    OjL2(1,i) = sigmoidFn(OjL2(1,i));
end

end
