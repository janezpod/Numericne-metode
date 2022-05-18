function vr = trap2d(f,a,b,c,d,n,m)
% Sestavljeno trapezno pravilo v 2D

x = linspace(a,b,n+1);
y = linspace(c,d,m+1);
h = (b-a)/n;
k = (d-c)/m;

alfa = ones(1,n+1).*2;
alfa(1) = 1;
alfa(n+1) = 1;

beta = ones(m+1,1).*2;
beta(1) = 1;
beta(m+1) = 1;

A = beta*alfa;

v=0;
for i = 1:m+1
    for j = 1:n+1
        v = v + A(i,j)*f(x(j),y(i));
    end
end

vr = h*k*v/4;