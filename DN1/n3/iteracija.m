v = 6;
f = @(t) 1/v + sin(2*t);
g = @(t) sin(3*t);
h = 1e-6;
T = 1:h:pi;

gamma = @(t) [f(t) ; g(t)];

f(pi/5)

tocke = gamma(T);

% neobvezni argument nam vrne tudi indeks seznama
[y1,t1] = min(tocke(2,:));

x1 = tocke(1,t1)

r = max(razdalja(tocke))


% razdalja med tockama
x = [0 0];
y = [2 1];
norm(x-y);