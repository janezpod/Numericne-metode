% primer

f = @(x) 2*x.^4 - x + 4;

n = 10;

E = 0:n+1;

[a, m] = izracunajPolinom(f, E, n);


