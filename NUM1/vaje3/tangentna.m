function [x,X,k] = tangentna(f,df,x0,tol,N)
% Funkcija izvede tangentno metodo na funkciji f z začetnim pribložkom x0.
% Nastavimo zgornjo varovalko največjega števila dovoljenih korakov N.
% Funkcija nam vrne približek x, vektor vmesnih približkov X in število
% korakov iteracije.

X = x0;
k = 0;

while k < N 
    k = k+1;
    X(k+1) = X(k) - f(X(k))/df(X(k));
    if abs(X(k+1)-X(k)) < tol
        break
    end
end
x = X(end);
end