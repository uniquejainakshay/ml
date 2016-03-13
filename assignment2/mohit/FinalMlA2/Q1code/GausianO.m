function G = GausianO( x,y,gamma )
%UNTITLED Summary of this function goes here
%   Detailed explanation goes here
       xny = x - y ;
       Normxny = xny*xny';
       G = exp(-Normxny*gamma);

end

