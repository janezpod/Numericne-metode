f = @(x,y) sin(10.*x.*y);
a=-1;
b=2;
c=0;
d=1;

%% 1
n=15;
m=5;

res1 = trap2d(f,a,b,c,d,n,m);

%% 2
n1 = 15;
m1 = 5;
h1 = (b-a)/n1;

h2 = h1/2;
n2 = (b-a)/h2;
m2 = (d-c)/h2;

integral = integral2(f,a,b,c,d);

napaka1 = integral - trap2d(f,a,b,c,d,n1,m1);
napaka2 = integral - trap2d(f,a,b,c,d,n2,m2);

res2 = log2(napaka1/napaka2);

%% 3
n = 10;
m = 4;

res3 = abs(integral2(f,a,b,c,d) - simpson2d(f,a,b,c,d,n,m));

%% 4
n1 = 18;
m1 = 6;
n2 = 36;
m2 = 12;

integral = integral2(f,a,b,c,d);
f1 = simpson2d(f,a,b,c,d,n1,m1);
f2 = simpson2d(f,a,b,c,d,n2,m2);


napaka1 = integral - f1;
napaka2 = integral - f2;

%p = log2(napaka1/napaka2);
p = 4;
I = (2^p * f2 - f1)/(2^p-1);

res4 = abs(I - integral);
