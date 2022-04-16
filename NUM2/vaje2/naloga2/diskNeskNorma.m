function vrednost = diskNeskNorma(f, a, b, n)
%Izracuna vrednost diskretne neskoncne norme funkcije f na intervalu [a,b]
%z n delilnimi tockami

x = linspace(a,b,n+1); %enakomerno izbranih n+1 tock na intervalu [a,b] (vkljucno z a in b)
vrednost = max(abs(f(x)));
end