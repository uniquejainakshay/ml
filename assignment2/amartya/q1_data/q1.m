clear
x = load('doc_term_mat.txt');
txt = textread('class_labels.txt','%s','delimiter','\n','whitespace','');
[m, n] = size(x);
y = zeros(m,1)
for i = 1:m
  if( strcmp(txt(i),'ham') == 0)
     y(i) = 1;
  else
     y(i) = 0;
  end
end

%find Q
%Q = -((x*x').*(y*y'));

%b = ones(m,1);

%cvx_begin
%variable alphas(m)
%alphas >= 0
%sum (alphas.*y) == 0

%maximize (alphas'*Q*alphas + b'*alphas)
%cvx_end
