a=-3.5;
b=2;
F = @(x) cosh(x/2) - sin(x/2);

%% 1 
n=5;
[koef,m] = oscilirajociPolinom(F,a,b,n);
res1 = abs(m);

%% 2
N=1001;
res2 = resNorm(F,koef,a,b,N);

%% 3
% Pri prejsnjem je bil polinom stopnje n=5, torej smo imeli n+2=7 tock.
n = 2 * (n + 2) - 2;
[koef,m] = oscilirajociPolinom(F,a,b,n);
res3 = abs(m);