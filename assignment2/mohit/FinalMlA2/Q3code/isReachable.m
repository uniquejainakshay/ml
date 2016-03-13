function  val  = isReachable( dTree,node,index )

    if dTree(index,2) == -1  % leaf node
        if dTree(index,1) == node
           val = 1;
           return;
        else
           val = -1;
           return;
        end
    else              %internal node
        if dTree(index,1) == node
           val = 1;
           return;
        else
           val1 = isReachable(dTree,node,dTree(index,3));
           val2 = isReachable(dTree,node,dTree(index,4));
           val3 = isReachable(dTree,node,dTree(index,5));
           if val1 == 1 || val2 == 1 || val3 ==1
              val = 1;
           else
              val = -1;
           end
            
        end
    end
        

end

