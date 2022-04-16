n = 20;

a = -1 * ones(1,n);

b = zeros(1,n-1);
c = zeros(1,n-1);

for i = 1:n-1
    b(i) = (1/2)^i;
    c(i) = 1 - b(i);
end

d = 5 * ones(1,n-5);
e = 6 * ones(1,n-6);

A = diag(a);
B = d_matrika(A,b,-1);
B = d_matrika(B,c,1);
B = d_matrika(B,d,5);
B = d_matrika(B,e,-6);

%%% 1 %%%

[x,L,U] = lusolve(B,zeros(n,1),0);

U_fro = norm(U,'fro');

%%% 2 %%%

% Z premo substitucijo
y = ones(n,1);
for i = 2:n
    for k = 1:i-1
        y(i) = y(i) - y(k)*L(i,k);
    end
end
y1 = norm(y,2);

% Z vgrajeno funkcijo
y = ones(n,1);
y = L\y;
y2 = norm(y,2);

%%% 3 %%%

[Lp,Up,P] = lu(B);

razmerje = max(max(abs(Up)))/max(max(abs(U)));
