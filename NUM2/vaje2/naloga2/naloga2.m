F = @(x) sin(x);
N = 10;
a = 0;
b = 2*pi;

%(a)

%Naredimo bazo potencnih funkcij x^i (kasneje uporabljamo kose te baze)
baza = cell(11,1);
for i=0:10
    baza{i+1} = @(x) x.^(i);
end

[koef,gram,desna] = aproksimantMNK(F,baza,a,b,N);

% Zaradi zgradbe Gramove matrike, lahko omejitev baze prevedemo na omejitev
% matrike: zgornja leva kvadratna podmatrika velikosti k predstavlja ravno skalarne
% produkte prvih k baznih funkcij.
% Uporabimo vgrajeno funkcijo cond(A), ki vrne pogojenostno stevilo dane matrike
% A.
cond1 = cond(gram(1:3,1:3))
cond2 = cond(gram(1:6,1:6))
cond3 = cond(gram)

%(b)

x = linspace(a,b);
%Naredimo prazen vektor, kamor bomo shranili napake na vsakem koraku
napaka = zeros(4,1);
%Sprehodimo se cez ustrezne n
for n = 4:7
    %Izracunamo koeficiente
    [koef,gram,desna] = aproksimantMNK(F,baza(1:n+1),a,b,N);

    %Tvorimo aproksimant (natancneje - njegove vrednosti v tockah na [a,b]
    fx = 0;
    for i=1:n+1
        fx = fx + koef(i).*baza{i}(x);
    end
    %Shranimo neskoncno normo razlike med aproksimantom in dejansko
    %funkcijo na intervalu [a,b]
    napaka(n-3) = max(abs(fx-F(x)));
end
napaka

%(c)

n = 4;
%Pripravimo prazen vektor, za shranjevanje napak
napaka_c = zeros(3,1);

%Pripravimo indeks, ki bo sledil, na katero mesto v vektorju napak moramo
%shraniti ustrezno vrednost
index=1;

%Sprehodimo se cez ustrezne N
for N = [2,10,100]
    %Izracunamo koeficiente
    [koef,gram,desna] = aproksimantMNK(F,baza(1:n+1),a,b,N);

    %Tvorimo aproksimant (tokrat dejansko funkcijo)
    f = @(x) 0*x;
    for i=1:n+1
        f = @(x) f(x) + koef(i).*baza{i}(x);
    end
    razlika = @(x) F(x)-f(x);

    %Shranimo 2-normo razlike (500 je neka izbrana stevilka, ki
    %predstavlja stevilo tock, s katerimi se izracuna 2 norma - lahko bi
    %vzeli tudi kaj drugega)
    napaka_c(index) = disk2norma(razlika,a,b,500);

    %Povecamo indeks za naslednji korak
    index = index+1;
end
napaka_c

% (d)
n = 8;
h = (b-a)/n;

%Ekvidistancno delitev lahko tvorimo v obliki zacetek:korak:konec
xi = a:h:b;

%Definiramo funkcijo H*. Tu (1-abs(x)>0) vrne bodisi 1 (ce je to res)
%bodisi 0 (ce to ni res). S tem dosezemo, da je funkcija enaka 0 v tockah, kjer
%nek pogoj (v tem primeru 1-abs(x)>0 ) ni izpolnjen, sicer pa je enaka
%tistemu, s cimer je pomnozen ta pogoj.
Hstar= @(x) ((1- abs(x)).*(1-abs(x)>0));

%Pripravimo bazo za H_i
baza2 = cell(n+1,1);
for i = 0:n
    baza2{i+1} = @(x) Hstar((x-xi(i+1))/h);
end

%Narisemo funkcije H_i na intervalu [a,b]
figure
hold on
x = linspace(a,b,1000); %1000 spet neka poljubna stevilka
for i=0:n
    plot(x,baza2{i+1}(x))
end

%Izracunamo Gramovo matriko
[koef,gram,desna] = aproksimantMNK(F,baza2,a,b,200); %200 spet neka poljubna stevilka
gram

%Ta je tridiagonalna, saj se nenicelni del funkcije H_i prekrije z
%nenicelnim delom H_j natanko tedaj, ko sta i in j najvec za 1 narazen.
%Torej ima H_i skalarni produkt z vsemi ostalimi H_k enak 0.