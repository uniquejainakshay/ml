function y=CheckIfNumber(s)
%[varargout]=CheckIfNumber(s)
% s is a string
% varargout is the converted number or row vector

num=str2num(s);

if (isempty(num)==0)

    y = true;
else
    y = false;

end