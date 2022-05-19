f = @(x) sqrt(abs(x)+1);

x = -3:3;
%Funkcija polyfit(x,y,n) sprejme x-koordinate, y-koordinate tock, ki jih
%zelimo interpolirati, ter n, ki predstavlja stopnjo interpolacijskega
%polinoma. Vrne koeficiente interpolacijskega polinoma (v potencni bazi) skozi dane tocke.
% Za stopnjo vzamemo n = stevilo tock - 1
p = polyfit(x, f(x), 6);

figure
hold on
t = linspace(-3,3);
%Funkcija polyval(p,x) sprejme p - koeficiente polinoma, ter x - parametre,
%in vrne vrednost polinoma, ki ga predstavljajo koeficienti p, pri
%parametrih x
plot(t, polyval(p,t));
plot(t,f(t));

x1 = -3:0;
x2 = 0:3;
p1 = polyfit(x1,f(x1),4);
p2 = polyfit(x2,f(x2),4);

figure
t1 = linspace(-3,0);
t2 = linspace(0,3);
hold on
plot(t1,polyval(p1,t1));
plot(t2,polyval(p2,t2));
plot(t,f(t));


