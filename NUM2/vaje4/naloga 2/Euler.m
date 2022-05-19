function [x,y] = Euler(f, a, b, y0, h)
% Eulerjeva metoda za resevanje (sistemov) NDE prvega reda: y' = f(x,y)
% Vhodni podatki: funkcija f(x,y); interval [a,b], na katerem iscemo resitev;
% zacetni pogoj y0 (vektor); korak h
% Izhodni podatki: diskretna resitev podana kot vektorja x in y




x = a:h:b;
y=zeros(length(y0),length(x));
y(:,1) = y0;
for i = 2:length(x)
   y(i) = y(i-1)+h*f(x(i-1), y(i-1));
end