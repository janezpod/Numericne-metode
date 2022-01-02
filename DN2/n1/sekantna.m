function [x,X,k] = sekantna(f,x0,x1,tol,N)
% Sekantna metoda na funkciji f z začetnima približkoma x0 in x1.
% Nastavimo zgornjo varovalko največjega števila dovoljenih korakov N.
% Funkcija nam vrne približek x, vektor vmesnih približkov X in število
% korakov iteracije.

X = [x0,x1];
k = 0;

while k < N 
    k = k+1;
    X(k+2) = X(k+1) - f(X(k+1)) * (X(k+1) - X(k)) / (f(X(k+1)) - f(X(k)));
    if abs(X(k+2)-X(k+1)) < tol
        break
    end
end
x = X(end);
end