%% 1
f = @(x,y) 1 + (x-y).^2 - 3.*x;
y0 = 1;
a = 3;
b = 4;
h = 1/8;
[x,y] = rungeKutta1331(f,a,b,y0,h);

res1 = y(end);

%% 2
F = @(x,Y) [Y(2); (1-Y(1)^2)*Y(2) - Y(1)];
Y0 = [1;1];
a = 0;
b = 10;
h = 1/3;
[x,Y] = rungeKutta1331(F,a,b,Y0,h);

c = linspace(0,10,1001);
% Vgrajena metoda ode45 (predpisemo toleranco racunanja)
[x45,Y45] = ode45(F,c,Y0,odeset('RelTol',10^(-10),'AbsTol',10^(-10)));

res2 = abs(Y(1,end)-Y45(end,1));

%% 3
h1 = 1/3;
h2 = 1/6;

[x1,Y1] = rungeKutta1331(F,a,b,Y0,h1);
[x2,Y2] = rungeKutta1331(F,a,b,Y0,h2);
razlika1 = abs(Y1(1,end)-Y45(end,1));
razlika2 = abs(Y2(1,end)-Y45(end,1));

res3 = razlika1/razlika2;