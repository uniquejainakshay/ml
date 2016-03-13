function [ acc,sizeTree ] = expandTree( dTree,number,X,Y )

if number == 0 
   sizeTree = 1;
   acc = Accuracy(X,Y,dTree,0);
   return
else % number of expandable nodes more than one
    index = 1;
    nodes = [1];
        if(number > 0)
             leftChild = dTree(index,3);
             midChild  = dTree(index,4);
             rightChild= dTree(index,5);
             nodes = horzcat(nodes,[leftChild midChild rightChild]);
             index = 2;   
             number = number -1;
             while(number>0)
                [matrix,flag] = child(dTree,nodes(index));
                if flag ~= -1
                    nodes = horzcat(nodes,matrix);
                    number = number - 1; 
                end
                index = index + 1;
                if index > size(nodes,2)
                    break
                end
             end
         end
end

% Till this point all nodes which is going to be part of tree is found
sizeTree = size(nodes,2);
nodes = nodes(1,1:index-1);

for i = 1:size(dTree,1)
   index = dTree(i,1);
   flag = -1;
   for j = 1:size(nodes,2)
      if index == nodes(j)
        flag = 1;
        break
      end
   end   
   if flag == -1
      dTree(i,2) = -1; 
   end
end


%dTree updated testing for accuracy
acc = Accuracy(X,Y,dTree,16);


end

