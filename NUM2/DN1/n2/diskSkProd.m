function vrednost = diskSkProd(f, g, a, b, N)
%Izracuna diskretni (semi)skalarni produkt funkcij f in g na intervalu
%[a,b] z n+1 enakomerno izbranimi tockami
% Pomembno je, da uporabimo for zanko, saj v primeru f = g = @(x) 1 spremeni
% vektor v 1 in ne dobimo N+1 teveč le 1.
x = linspace(a,b,N+1);
s = 0;
for i = 1: N+1
    s = s + f(x(i)).*g(x(i));
end
vrednost = (b-a)./(N+1) .* s;
end