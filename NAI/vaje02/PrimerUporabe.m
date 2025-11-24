% Definiraj funkcijo
f = @(x) 3*x.^2 + 2;
F = @(x) x.^3 + 2*x;

% Definiraj interval
a = -1;
b = 1;

% Stopnja aproksimacije
n = 5;

% Točke, kjer želiš izračunati aproksimacijo
x = linspace(-1, 1, 100);  % 100 točk med -1 in 1

% Klic funkcije
y_ber = bernsteinovaAproksimacija(f,a,b,n,x);
y_kan = kantorovicevaAproksimacija(F,a,b,n,x);
y_ods = odsekomaLinearnaAproksimacija(f,a,b,n,x);

% Nariši
plot(x, y_ber, 'b-', 'LineWidth', 2);
hold on;
plot(x, y_kan, 'g-', 'LineWidth', 2);
plot(x, y_ods, 'm-', 'LineWidth', 2);
plot(x, f(x), 'r--', 'LineWidth', 2);
legend('Bernsteinova', 'Kantorovičeva', 'Odsekoma linearna', 'Originalna funkcija');
grid on;
hold off;