function [attr] = bestAttributeEntropy( Y,X )

[row,col] = size(X);
f = X(1,:);
X = X(2:row,:);
value = [-1,0,1];
sizeVal = 3;
totentropy = zeros(1,col);

totrow = size(Y,1);

[~,sizef] = size(f);

     for i = 1:sizef
       feature = X(:,i);
       entropy = zeros(1,sizeVal);
       for j = 1:sizeVal
            v = sum(feature==value(1,j));
            newY = Y(find(feature==value(1,j)));
            if size(newY,1) ~= 0 
                pEx = sum(newY==1);
                nEx = sum(newY==0);
                p = pEx/size(newY,1);
                n = nEx/size(newY,1);
                if pEx~=0
                    pterm = p*log2(p);
                else
                    pterm = 0;
                end
                if nEx~=0
                    nterm = n*log2(n);
                else
                    nterm = 0;
                end
                
                H = -( pterm+ nterm);
                e = H*(v/totrow);
                entropy(1,j) = e;
            else
                entropy(1,j) = 100;
            end
       end
       totentropy(1,i) =  round(sum(entropy),4);
       if totrow == 0
           totentropy(1,i) = 0;
       end
     
     end
    [~,attr] = min(totentropy);
end




