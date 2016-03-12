load('mnist_all.mat')

[m,n] = size(train3);
[p,q] = size(train8);
assert(n==q);
s = zeros(m,1);
t = zeros(p,1);
for i = 1:m
    s(i) = 3;
end

for i = 1:p
    t(i) = 8;
end

Y = [s;t];
X_all   = [train3 ; train8];

%for test data
[m,n] = size(test3);
[p,q] = size(test8);

clear s t;
s = zeros(m,1);
t = zeros(p,1);

for i = 1:m
    s(i) = 3;
end

for i = 1:p
    t(i) = 8;
end

Y_tests = [s;t];
X_tests   = [test3 ; test8];
save 'mnist3_8.mat' X_all Y X_tests Y_tests;
