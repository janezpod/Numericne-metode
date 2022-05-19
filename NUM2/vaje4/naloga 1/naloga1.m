% naloga1

f = @(x) cos( cos(x) + 3*x) + atan(x);
a = 1;
b = 5;

figure
x = linspace(a,b);
plot(x,f(x))

% vrednost integrala preko vgrajene funckije
vr1 = integral(f,a,b);

% vrednosti sestavljenega Simpsonovega pravila
vr_sim1 = sestavljenoSimpsonovo(f,a,b,10);
vr_sim2 = sestavljenoSimpsonovo(f,a,b,20);

napaka1 = abs(vr1-vr_sim1);
napaka2 = abs(vr1-vr_sim2);

%Po formuli iz vaj, priblizek za red konvergence:
konvergenca = log(napaka1/napaka2)/log(20/10)


% Gauss na 5 tockah za [-1,1]
x1 = 1/3 * sqrt(5-2*sqrt(10/7));
x2 = 1/3 * sqrt(5+2*sqrt(10/7));

u1 = (322+13*sqrt(70))/900;
u2 = (322-13*sqrt(70))/900;

vozli = [-x2 -x1 0 x1 x2];
utezi = [u2 u1 128/225 u1 u2];

% vozli in utezi na [a,b]
noviVozli = (vozli +1) * (b-a)/2 + a;
noveUtezi = utezi * (b-a)/2;

vr_gauss = noveUtezi * f(noviVozli)'
