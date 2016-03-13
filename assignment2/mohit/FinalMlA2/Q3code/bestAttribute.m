function [attr] = bestAttribute( Y,X )

[row,col] = size(X)
f = X(1,:);
X = X(2:row,:);
attr = -1;
value = [-1,0,1];
sizeVal = 3;
toterror = zeros(1,col);
[~,sizef] = size(f)
     for i = 1:sizef
       feature = X(:,i);
       count = zeros(1,sizeVal);
       error = zeros(1,sizeVal);
       for j = 1:sizeVal
          indxs = find(feature==value(1,j));
          Yi=Y(indxs);
          [count(j),~] = size(indxs);
          if count(j)~=0
              [pEx,~] = size(find(Yi==1));
              [nEx,~] = size(find(Yi==0));
              if pEx > nEx
                  error(1,j) = nEx/(pEx+nEx);
              else
                  error(1,j) = pEx/(pEx+nEx);
              end
          else
              error(1,j) = 0;
          end
          
       end
       toterror(1,i) = round((error*count')/sum(count),4);
     [~,attr] = min(toterror);
     end
     toterror
    
end




