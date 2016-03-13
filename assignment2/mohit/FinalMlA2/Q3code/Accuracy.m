function  Acc  = Accuracy( X,Y,dTree,depth )
    co = 0;
    for i = 1:size(X,1)
       Yi = Y(i,1); 
       Xi = X(i,:);
       O = predictLabel(dTree,Xi,1,depth);
       if O==Yi
          co = co  +1;
       end
    end
    Acc = co/size(X,1); 
end

