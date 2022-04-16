function vrednost = zvSkalProd(f, g, a, b)
%Izracuna skalarni produkt funkcij f in g kot integral produkta na
%intervalu [a,b]

h = @(x) f(x).*g(x);
%vgrajena funkcija integral(f,a,b) izracuna
% priblizek za doloceni integral funkcije f na intervalu [a,b]
vrednost = integral(h,a,b); 
end