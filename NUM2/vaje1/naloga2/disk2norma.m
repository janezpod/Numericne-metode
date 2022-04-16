function vrednost = disk2norma(f,a,b,n)
%Izracuna (semi)normo porojeno iz diskretnega skalarnega produkta funkcij f in g
%na intervalu [a,b] z n+1 enakomerno izbranimi tockami
vrednost = sqrt(diskSkalProd(f,f,a,b,n));
end