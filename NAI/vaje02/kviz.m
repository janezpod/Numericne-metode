%% Prvi del
% Izračun Kantorovičevega polinoma stopnje 4 za funkcijo f(x) = k*sin(k*x) + 5
% na intervalu [0, 2] v točki x = 1
%
% Kantorovičev operator potrebuje primitivno funkcijo F, kjer F' = f

clear; clc;
format long;

%% Definicija funkcije in primitivne funkcije
k = 214/101;
f = @(x) k*sin(k*x) + 5;
F = @(x) -cos(k*x) + 5*x;  % F'(x) = k*sin(k*x) + 5 = f(x)

%% Interval
a = 0;
b = 2;

%% Stopnja aproksimacije
n = 4;

%% Točka, kjer računamo aproksimacijo
x = 1;

%% Kantorovičeva aproksimacija
y_kan = kantorovicevaAproksimacija(F, a, b, n, x);

%% Izpis rezultata
fprintf('K f(1) = %.15f\n', y_kan);

%% Drugi del
% Izračun napake ||f - Jf||_{inf,x}
%
% Jf = sum_{i=0}^{4} c_i * H_i(x)
% kjer je c_i = (1/4)*f(i/2 - 1/2) + (1/2)*f(i/2) + (1/4)*f(i/2 + 1/2)
% in H_i so klobučne funkcije nad delitvijo 0 < 1/2 < 1 < 3/2 < 2

%% Definicija funkcije
k = 214/101;
f = @(x) k*sin(k*x) + 5;

%% Interval in delilne točke
a = 0;
b = 2;
n = 4;  % 5 delilnih točk: 0, 0.5, 1, 1.5, 2

% Delilne točke: x_i = i/2 za i = 0, 1, 2, 3, 4
x_nodes = (0:0.5:2);  % [0, 0.5, 1, 1.5, 2]

%% Izračun koeficientov c_i za aproksimacijo Jf
% c_i = (1/4)*f(i/2 - 1/2) + (1/2)*f(i/2) + (1/4)*f(i/2 + 1/2)
c = zeros(1, n+1);
for i = 0:n
    xi = i/2;
    c(i+1) = (1/4)*f(xi - 1/2) + (1/2)*f(xi) + (1/4)*f(xi + 1/2);
end

%% Testne točke x = k/500, k = 0, 1, ..., 1000
x_test = (0:1000) / 500;  % od 0 do 2

%% Izračun Jf v testnih točkah
% Jf(x) = sum_{i=0}^{n} c_i * H_i(x)
% To je odsekoma linearna funkcija, ki v vozliščih x_i zavzame vrednost c_i
Jf_values = interp1(x_nodes, c, x_test, 'linear');

%% Točne vrednosti funkcije f
f_values = f(x_test);

%% Napaka v enakomerni normi
error_values = abs(f_values - Jf_values);
max_error = max(error_values);

fprintf('Maksimalna napaka ||f - Jf||_inf = %.15f\n', max_error);