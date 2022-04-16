% UKAZI (preizkusite še na svojih primerih!):
%
% x = linspace(a,b,n) ... naredi vrstico x, ki vsebuje enakomerno
% razporejenih n vrednosti med vkljucno a in b (ce n-ja ne podamo, se privzame
% vrednost n = 100)
% PRIMER: linspace(0,1,5) = [0, 0.25, 0.5, 0.75, 1]
%
% figure ... ustvari novo okno, kamor potem lahko risemo grafe in podobno
%
% plot(x,y,...) ... narise in po vrsti poveze (2D) tocke s koordinatami
% podanimi v vektorju x (x koordinate) in y (y koordinate). Lahko dodamo
% tudi nekaj neobveznih parametrov, s katerimi spreminjamo nacin risanja -
% npr. da so tocke oznacene s krogcem, da so crte crtkane itd.
% PRIMER: plot([0,0,2,4,4],[0,5,3,5,0]) izrise crko M
%
% axis equal ... ce to dopisemo npr. za plot(...), bosta enoti na grafu v x in y smeri
% enako dolgi
%
% plot3(x,y,z,...) ... enako kot plot, le da so tocke zdaj v prostoru (3D).
% Tu so x, y in z vektorji x-, y- in z-koordinat.
% PRIMER: plot3([0,0,2,4,4],[0,5,3,5,0], [0,1,-1,1,0]) izrise popaceno
% crko M v prostoru
%
% [X,Y] = meshgrid(x,y) ... vzame dva vektorja x ter y in vrne dve matriki
% X in Y dimenzij length(y) x length(x). Matrika X vsebuje length(y)
% vrstic, ki so kopije vektorja x. Matrika Y vsebuje length(x) stolpcev, ki
% so kopije vektorja y. S tem efektivno tvorimo "kartezicni produkt
% vektorjev x in y" oz. mrezo v ravnini, pri cemer matrika X vsebuje x-koordinate in
% Y vsebuje y-koordinate tock na tej mrezi.
% PRIMER: (poskusite pognati pri sebi)
% [X,Y] = meshgrid([1;2;3],[4;5;6;7]) 
%
%
% surf(X,Y,Z) ... narise (priblizek za) ploskev skozi tocke nad mrezo v
% ravnini. V funkcijo podamo matrike X,Y in Z, ki predstavljajo x-,y- in
% z-koordinate tock na ploskvi (X in Y tipicno dobimo iz meshgrida).
% PRIMER: (poskusite pognati pri sebi)
% [X,Y] = meshgrid([1,2,3,4],[1,2,3,4])
% Z =[4,2,4,8;
%     2,1,2,4;
%     4,2,4,8;
%     8,4,8,16]
% surf(X,Y,Z)
%-------------------------------------------------------------------


%(a)
f = @(x) sin(x).*exp(sqrt(x));
x = linspace(1,3);
figure
plot(x,f(x));

%(b)
t = linspace(0, 2*pi);
figure
plot(cos(t),sin(t));
axis equal

%(c)

figure
plot3(cos(t),sin(t),t);

%(d)
k = @(x,y) (x.^2 + y.^2)./(1+x+y);
x = linspace(0,1);
y = linspace(0,1);
[X,Y] = meshgrid(x,y);
figure
surf(X,Y,k(X,Y));
shading interp %narise brez mreznih crt