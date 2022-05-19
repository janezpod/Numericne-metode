function [x,y] = Euler_imp(f, a, b, y0, h)
% Implicitna Eulerjeva metoda za resevanje (sistemov) NDE prvega reda: y' = f(x,y)
% Vhodni podatki: funkcija f(x,y); interval [a,b], na katerem iscemo resitev;
% zacetni pogoj y0 (vektor); korak h
% Izhodni podatki: diskretna resitev podana kot vektorja x in y




x = a:h:b;
y=zeros(length(y0),length(x));
y(:,1) = y0;
for i = 2:length(x)
   % nelin. enacbo yn = y(i-1) + h*fun(x(i),yn prevedemo na iskanje nicle funkcije fun2
   fun = @(yn) yn - y(i-1)-h*f(x(i), yn); 
   y(:,i) = fsolve(fun, y(:,i-1)); %v primeru, da je y0 stevilo (in ne vektor), deluje tudi fzero namesto fsolve
end