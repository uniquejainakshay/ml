function label = predictLabel(M,X,index,depth)
    
    while(1)
       node = M(index,:);
       if (node(1,2)==-1) %leaf node
          label = node(1,6);
          break
       else               %internal node
           if depth == 0 
              label = node(1,6);
              break
           end
           feature = node(1,2);
           val = X(1,feature);
           if val == 1
              index = node(1,3); 
           elseif val == 0 
              index = node(1,4);
           elseif val == -1
              index = node(1,5);
           end
       end
       depth = depth - 1;
    end

end

