function vrednost = diskSkalProd(f, g, a, b, n)
%Izracuna diskretni (semi)skalarni produkt funkcij f in g na intervalu
%[a,b] z n+1 enakomerno izbranimi tockami
x = linspace(a,b,n+1);
vrednost = (b-a)/(n+1) * (f(x)*g(x)');
end