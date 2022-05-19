% naloga 3

f = @(t,y)  6*t + y*sin(t);
Y0 = [1;3];

% Y = [y; y']
F = @(t,Y) [Y(2); f(t,Y(1))];

figure
hold on
t = linspace(0,5,1001);

% Vgrajena metoda ode45 (predpisemo toleranco racunanja)
[~,Y] = ode45(F, t,Y0,odeset('RelTol',10^(-10),'AbsTol',10^(-10)));
plot(t,Y(:,1),'k','linewidth',2)

%Trapezna metoda
[t,Y] = Trapezno(F, 0, 5, Y0, 1/2);
plot(t,Y(1,:),'ro--','linewidth',2)



