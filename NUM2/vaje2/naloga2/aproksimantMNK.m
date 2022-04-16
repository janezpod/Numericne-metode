function [koef,gram,desna] = aproksimantMNK(F,baza,a,b,N)
%Izracuna aproksimant za funkcijo F po MNK v dani bazi za diskretni
%skalarni produkt na N+1 tockah na intervalu [a,b]

n = length(baza); %stevilo baznih funkcij
gram = zeros(n);
desna = zeros(n,1);
%Napolnimo Gramovo matriko
for i=1:n
    for j=1:n
        gram(i,j) = diskSkalProd(baza{i},baza{j},a,b,N);
    end
end

%Napolnimo desno stran
for i=1:n
    desna(i) = diskSkalProd(F,baza{i},a,b,N);
end

%Resimo sistem
koef = gram \ desna;

end