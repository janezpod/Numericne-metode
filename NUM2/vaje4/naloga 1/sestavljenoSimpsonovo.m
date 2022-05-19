function vr = sestavljenoSimpsonovo(f,a,b,m)
% function vr = sestavljenoSimpsonovo(f,a,b,m)
%
% Metoda vrne priblizek za dolocen integral funkcije f na [a,b] preko
% sestavljenega Simpsonovega pravila.
%
% f je anonimna funkcija
% [a,b] je interval integriranja
% m je stevilo osnovnih delitev intervala
%
% vr je priblizek za vrednost integrala.
%

x = linspace(a,b,2*m+1);
y = f(x);
%Razdalja med delilnimi tockami:
h = (b-a)/(2*m);

vr = h/3 * (y(1) + y(end) + 4*sum(y(2:2:end-1)) + 2*sum(y(3:2:end-2)));