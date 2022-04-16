function baza = bazaBernstein(n)
%Vrne cell tabelo Bernsteinovih polinomov stopnje n

%Ukaz: A = cell(n,m) ... ustvari tabelo (matriko) velikosti n krat m, v katero lahko shranjujemo
%"stvari" (npr. vrednosti, matrike, funkcije, ...). Do shranjenih vrednosti
%dostopamo z npr. A{5,2} (zaviti oklepaji!), to vrne "stvar" na mestu (5,2)
%v tabeli (matriki)

%Naredimo prazen cell stolpec dolzine n+1:
baza = cell(n+1,1); 

%Gremo cez vse mozne i:
for i = 0:n
    %Pri vsakem i shranimo ustrezen bazni polinom B_i^n (na mesto i+1 v tabeli, ker se
    %v MatLabu indeksi zacnejo z 1)
    baza{i+1} = @(t)  nchoosek(n,i) * (1-t).^(n-i) .* t.^i;
end

end