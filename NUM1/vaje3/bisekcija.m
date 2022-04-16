function [x,X] = bisekcija(f,a,b,N)
% Metoda bisekcije na intervalu [a,b] za funkcijo f z N koraki.
% Funkcija vrne približek x in vektor vmesnih približkov X

% Da se podatki ne računajo vendo znova.
fa = f(a);
fb = f(b); 
X = zeros(N,1);

if sign(fa) == sign(fb)
    error('Funkcija je enakega predznaka v krajiščih intervala')
end

s = b-a;
for i = 1:N
    s = s/2;
    x = a + s;
    fx = f(x);
    X(i) = x;
    if sign(fx) == sign(fa)
        a = x;
        fa = fx;
    end
end