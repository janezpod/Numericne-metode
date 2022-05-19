f1 = @(x) cos(x);
f2 = @(x) sin(x);

n = 6;
%vzamemo n+1=7 tock, ker vrednosti funkcij pri -pi in pi (zacetek in konec) sovpadata
t = linspace(-pi, pi, n+1);
p1 = polyfit(t, f1(t),n);
p2 = polyfit(t, f2(t),n);

figure
hold on
x = linspace(-pi, pi);
plot(polyval(p1,x),polyval(p2,x));
plot(f1(x),f2(x),'r');
axis equal % da je kroznica bolj okrogla
