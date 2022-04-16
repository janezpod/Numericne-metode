vecx = [1,2,3,5];
%Vandermondova matrika po nasi metodi:
V = mojVander(vecx)
%Vandermondova matrika po vgrajeni metodi:
V2 = fliplr(vander(vecx))

%Vzamemo poljuben vektor desne strani, npr. vrednost cos v teh tockah
%(vecx transponiramo, ker vgrajeno reševanje sistema A\b zahteva, da je b stolpec)
d = cos(vecx'); 
koef = V \ d; % -> stolpec koeficientov [a_0,a_1,...a_(n-1)] interpolacijskega polinoma v potencni bazi

figure
hold on
x = linspace(1,5);
%Narisemo funkcijo, katero interpoliramo:
plot(x,cos(x),'r','linewidth',2)

% polyval(v,x) vzame vektor koeficientov v=[b_n,...,b_1,b_0] polinoma p in
% izracuna vrednost p(x).
% Opazimo, da je nas vektor 'koef' ravno narobe obrnjen (zacne se z a_0
% namesto a_(n-1), zato ga najprej se obrnemo z ukazom: flip(v)

%Izracunamo vrednosti p na intervalu [1,5]:
y = polyval(flip(koef),x);
%Narisemo:
plot(x,y,'b--','linewidth',1)
