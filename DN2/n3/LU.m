n = 20;

a = zeros(1,n);
b = zeros(1,n-1);
c = zeros(1,n-1);

for i = 1:n
    a(i) = -1;
end

for i = 1:n-1
    b(i) = 1/(2^i);
    c(i) = 1 - b(i);
end

% peta nadiagonala
d = 5*ones(1,n);
% sesta podiagonala
e = -6*ones(1,n);

A = diag(a);
B = d_matrika(A,b,-1);
B = d_matrika(B,c,1);
B = d_matrika(B,d,5); % peta nadiagonala
B = d_matrika(B,e,-6); % sesta podiagonala

[x,L,U] = lusolve(B,zeros(n),0);
[L2,U2] = lu(B);

%%% 1 %%%
normaU1 = norm(U,'fro');
normaU2 = norma(U,'fro');

%%% 2 %%%
b = ones(1,n);
y = p_sub(L,b);
normaY = norm(y,2);

%%% 3 %%%
[Lp,Up,Pp] = lu(B);
razmerje = norm(Up,"inf")/norm(U,'inf');

%%% 1.1 %%%

[Ln,Un] = lu_nopivot(B);
nU = norm(U,'fro');
