f = @(t,y)  -50*y + 100;
y0 = 10;

% tocna y (vemo iz vaj)
y_ex = @(t) (y0-2).*exp(-50*t) + 2;
t = linspace(0,10,1001);

figure
hold on
plot(t,y_ex(t),'k','linewidth',1.5)

%Eksplicitna Eulerjeva:
[t,y] = Euler(f, 0, 10, y0, 1/30); %za parametre h >= 1/25 se zacne divergenca od prave resitve
plot(t,y,'ro--','linewidth',2)

%Implicitna Eulerjeva:
[t,y] = Euler_imp(f, 0, 10, y0, 1/30);
plot(t,y,'bo--','linewidth',2)


