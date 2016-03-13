function [val] = gaus_kern(x, z , gam) 
    diff = x - z; 
    diff = diff' * diff; 
    val = exp(- diff * gam ); 
end