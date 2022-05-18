function vr = simpson2d(f,a,b,c,d,n,m)
% Sestavljeno simpsonovo pravilo v 2D

x = linspace(a,b,2*n+1);
y = linspace(c,d,2*m+1);
h = (b-a)/(2*n);
k = (d-c)/(2*m);

alfa = zeros(1,2*n+1);
alfa(1) = 1;
for i = 2:2:2*n+1
    alfa(i) = 4;
    alfa(i+1) = 2;
end
alfa(2*n+1) = 1;

beta = zeros(2*m+1,1);
beta(1) = 1;
for i = 2:2:2*m+1
    beta(i) = 4;
    beta(i+1) = 2;
end
beta(2*m+1) = 1;

A = beta*alfa;

v=0;
for i = 1:2*m+1
    for j = 1:2*n+1
        v = v + A(i,j)*f(x(j),y(i));
    end
end

vr = h*k*v/9;