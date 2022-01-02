function [x,X] = tangentna_koraki(f,df,x0,st_korakov)
% Funkcija izvede tangentno metodo na funkciji f z začetnim pribložkom x0.
% Nastavimo zgornjo varovalko največjega števila dovoljenih korakov N.
% Funkcija nam vrne približek x, vektor vmesnih približkov X in število
% korakov iteracije.

X = x0;
k = 0;

while k < st_korakov 
    k = k+1;
    X(k+1) = X(k) - f(X(k))/df(X(k));
end
x = X(end);
end