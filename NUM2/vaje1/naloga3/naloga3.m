%(a)
n = 10;
baza = bazaBernstein(n);

figure
hold on %ohranjamo risbe (jih NE zbrisemo vsakic, ko se nekaj novega narise)
t=linspace(0,1);
for i=0:n
    %narisemo graf i-tega baznega polinoma
    plot(t,baza{i+1}(t))
end

%(b)
a = -1;
b = 3;
baza2 = bazaBernstein2(n,a,b);

figure
hold on
t=linspace(a,b);
for i=0:n
    plot(t,baza2{i+1}(t))
end

%(c)
a=-pi;
b=pi;
f = @(x) sin(x);

%Sproti belezimo trenuten n, zaceti zelimo z n=1 v zanki, zato je najprej n=0
n=0;

%Trik, da se while zanka vsaj enkrat izvede - nastavimo vrednost na
%neskoncno
norma = inf;
%Dokler je norma prevelika:
while norma >= 0.5
    n = n+1; %povecamo stopnjo
    Bf = bernsteinAprox(f,n,a,b); %izracunamo priblizek
    norma = zv2norma(@(t) f(t)-Bf(t),a,b); %izracunamo normo razlike z novim priblizkom
end
n

%(d)

% POZOR!
% f = @(t) 1;
% NI ENAKO KOT
% g = @(t) 1 + 0*t;
% Namrec: f([1,2,3]) = 1, medtem ko g([1,2,3]) = [1, 1, 1]
% Tipicno zelimo to drugo varianto.

Bf_1 = bernsteinAprox(@(t) 1+0*t,1,a,b);
Bf_x = bernsteinAprox(@(t) t,1,a,b);

%Uporabimo zv2norma iz Naloge 2
napaka_1 = zv2norma(@(t) 1 - Bf_1(t),a,b)
napaka_x = zv2norma(@(t) t - Bf_x(t),a,b)

