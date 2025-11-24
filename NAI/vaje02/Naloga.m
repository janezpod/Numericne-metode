%% PRIMERJAVA APROKSIMACIJSKIH OPERATORJEV
% Računalniška naloga - Numerična aproksimacija in interpolacija
%
% Naloga: Izračunajte aproksimacije funkcij cos(2x) in |x|cos(x²) 
% na intervalu [-1, 1] z vsemi tremi metodami za parametre n = [2, 4, 6, ..., 50].
% Narišite grafe aproksimacij. Primerjajte napake aproksimacij v enakomerni normi,
% ki jih ocenite tako, da izračunate maksimalno absolutno napako v točkah 
% (j − 100)/100, j = 0, 1, ..., 200. Narišite grafe napak v odvisnosti od 
% parametra n v logaritemski skali.

clear; close all; clc;
format long;

fprintf('========================================================\n');
fprintf('  PRIMERJAVA APROKSIMACIJSKIH OPERATORJEV\n');
fprintf('========================================================\n\n');

%% ========================================================================
%  DEFINICIJE FUNKCIJ IN PARAMETROV
%  ========================================================================

% Funkcija 1: cos(2x)
f1 = @(x) cos(2*x);
% Primitivna funkcija
F1 = @(x) sin(2*x) / 2;

% Funkcija 2: |x|cos(x²)
f2 = @(x) abs(x) .* cos(x.^2);
% Primitivna funkcija F(x) = x*sin(x²)/(2|x|) = sgn(x)*sin(x²)/2
F2 = @(x) (x .* sin(x.^2)) ./ (2 * abs(x));

% Interval
a = -1;
b = 1;

% Parametri n
n_values = 2:2:50;

% Točke za oceno napake (j-100)/100, j = 0, 1, ..., 200)
% To je 201 točk: -1.00, -0.99, -0.98, ..., 0.00, ..., 0.98, 0.99, 1.00
x_test = (-100:100) / 100;  % Ekvivalentno: linspace(-1, 1, 201)

% Točke za risanje gladkih krivulj
x_plot = linspace(a, b, 500);

% Izbrane vrednosti n za prikaz grafov aproksimacij
n_examples = [2, 6, 10, 20];

fprintf('Funkcija 1: f(x) = cos(2x)\n');
fprintf('Funkcija 2: f(x) = |x|cos(x^2)\n');
fprintf('Interval: [%d, %d]\n', a, b);
fprintf('Parametri: n = [%d, %d, %d, ..., %d]\n', n_values(1), n_values(2), n_values(3), n_values(end));
fprintf('Točke za oceno napake: %d točk\n', length(x_test));
fprintf('Število testov: %d vrednosti n × 3 metode × 2 funkciji\n\n', length(n_values));

%% ========================================================================
%  FUNKCIJA 1: cos(2x)
%  ========================================================================

fprintf('========================================================\n');
fprintf('  FUNKCIJA 1: f(x) = cos(2x)\n');
fprintf('========================================================\n\n');

%% Izračun napak za različne n

fprintf('Računam napake za različne vrednosti n...\n');

% Točne vrednosti v testnih točkah
y_exact_f1 = f1(x_test);

% Shranjevanje napak
errors_f1_bern = zeros(length(n_values), 1);
errors_f1_kant = zeros(length(n_values), 1);
errors_f1_pwlin = zeros(length(n_values), 1);

% Računanje napak za vsak n
for i = 1:length(n_values)
    n = n_values(i);
    
    % Bernsteinova aproksimacija
    y_bern = bernsteinovaAproksimacija(f1, a, b, n, x_test);
    errors_f1_bern(i) = max(abs(y_bern - y_exact_f1));
    
    % Kantorovičeva aproksimacija
    y_kant = kantorovicevaAproksimacija(F1, a, b, n, x_test);
    errors_f1_kant(i) = max(abs(y_kant - y_exact_f1));
    
    % Odsekoma linearna aproksimacija
    y_pwlin = odsekomaLinearnaAproksimacija(f1, a, b, n, x_test);
    errors_f1_pwlin(i) = max(abs(y_pwlin - y_exact_f1));
end

fprintf('Končano!\n\n');

%% Izpis tabele napak

fprintf('%-37s ', 'n');
for n = n_values
    fprintf('%-14d', n);
end
fprintf('\n');

fprintf('%-37s ', 'Bernsteinova aproksimacija:');
for i = 1:length(n_values)
    fprintf('%-14.10f', errors_f1_bern(i));
end
fprintf('\n');

fprintf('%-37s ', 'Kantoroviceva aproksimacija:');
for i = 1:length(n_values)
    fprintf('%-14.10f', errors_f1_kant(i));
end
fprintf('\n');

fprintf('%-37s ', 'Odsekoma linearna aproksimacija:');
for i = 1:length(n_values)
    fprintf('%-14.10f', errors_f1_pwlin(i));
end
fprintf('\n\n');

%% Izpis končnih napak (tj. n = 50)

fprintf('Končne napake (n = %d):\n', n_values(end));
fprintf('  Bernsteinova:        %.10f\n', errors_f1_bern(end));
fprintf('  Kantorovičeva:       %.10f\n', errors_f1_kant(end));
fprintf('  Odsekoma linearna:   %.10f\n\n', errors_f1_pwlin(end));

%% Graf napak v logaritemski skali

figure('Name', 'Funkcija 1: Napake v odvisnosti od n', 'Position', [100, 100, 1000, 600]);
semilogy(n_values, errors_f1_bern, 'o-', 'LineWidth', 2, 'MarkerSize', 6, 'DisplayName', 'Bernsteinova');
hold on;
semilogy(n_values, errors_f1_kant, 's-', 'LineWidth', 2, 'MarkerSize', 6, 'DisplayName', 'Kantorovičeva');
semilogy(n_values, errors_f1_pwlin, '^-', 'LineWidth', 2, 'MarkerSize', 6, 'DisplayName', 'Odsekoma linearna');
grid on;
xlabel('n', 'FontSize', 12);
ylabel('Maksimalna napaka (logaritemska skala)', 'FontSize', 12);
title('Napake aproksimacij za f(x) = cos(2x)', 'FontSize', 14);
legend('Location', 'best', 'FontSize', 11);
set(gca, 'FontSize', 11);

%% Grafi aproksimacij za izbrane vrednosti n

figure('Name', 'Funkcija 1: Primeri aproksimacij', 'Position', [150, 150, 1400, 900]);

for idx = 1:length(n_examples)
    n = n_examples(idx);
    
    % Izračun aproksimacij
    y_bern = bernsteinovaAproksimacija(f1, a, b, n, x_plot);
    y_kant = kantorovicevaAproksimacija(F1, a, b, n, x_plot);
    y_pwlin = odsekomaLinearnaAproksimacija(f1, a, b, n, x_plot);
    y_exact = f1(x_plot);
    
    % Prikaz
    subplot(2, 2, idx);
    plot(x_plot, y_exact, 'k-', 'LineWidth', 2.5, 'DisplayName', 'Točna');
    hold on;
    plot(x_plot, y_bern, '--', 'LineWidth', 1.8, 'DisplayName', 'Bernsteinova');
    plot(x_plot, y_kant, '-.', 'LineWidth', 1.8, 'DisplayName', 'Kantorovičeva');
    plot(x_plot, y_pwlin, ':', 'LineWidth', 1.8, 'DisplayName', 'Odsekoma lin.');
    grid on;
    xlabel('x', 'FontSize', 11);
    ylabel('y', 'FontSize', 11);
    title(sprintf('Aproksimacije za n = %d', n), 'FontSize', 12);
    legend('Location', 'best', 'FontSize', 9);
    set(gca, 'FontSize', 10);
end

sgtitle('Primeri aproksimacij za f(x) = cos(2x)', 'FontSize', 15, 'FontWeight', 'bold');

%% ========================================================================
%  FUNKCIJA 2: |x|cos(x²)
%  ========================================================================

fprintf('========================================================\n');
fprintf('  FUNKCIJA 2: f(x) = |x|cos(x^2)\n');
fprintf('========================================================\n\n');

%% Izračun napak za različne n

fprintf('Računam napake za različne vrednosti n...\n');

% Točne vrednosti v testnih točkah
y_exact_f2 = f2(x_test);

% Shranjevanje napak
errors_f2_bern = zeros(length(n_values), 1);
errors_f2_kant = zeros(length(n_values), 1);
errors_f2_pwlin = zeros(length(n_values), 1);

% Računanje napak za vsak n
for i = 1:length(n_values)
    n = n_values(i);
        
    % Bernsteinova aproksimacija
    y_bern = bernsteinovaAproksimacija(f2, a, b, n, x_test);
    errors_f2_bern(i) = max(abs(y_bern - y_exact_f2));
    
    % Kantorovičeva aproksimacija (lahko traja dlje)
    y_kant = kantorovicevaAproksimacija(F2, a, b, n, x_test);
    errors_f2_kant(i) = max(abs(y_kant - y_exact_f2));
    
    % Odsekoma linearna aproksimacija
    y_pwlin = odsekomaLinearnaAproksimacija(f2, a, b, n, x_test);
    errors_f2_pwlin(i) = max(abs(y_pwlin - y_exact_f2));
end

fprintf('Končano!\n\n');

%% Izpis tabele napak

fprintf('%-37s ', 'n');
for n = n_values
    fprintf('%-14d', n);
end
fprintf('\n');

fprintf('%-37s ', 'Bernsteinova aproksimacija:');
for i = 1:length(n_values)
    fprintf('%-14.10f', errors_f2_bern(i));
end
fprintf('\n');

fprintf('%-37s ', 'Kantoroviceva aproksimacija:');
for i = 1:length(n_values)
    fprintf('%-14.10f', errors_f2_kant(i));
end
fprintf('\n');

fprintf('%-37s ', 'Odsekoma linearna aproksimacija:');
for i = 1:length(n_values)
    fprintf('%-14.10f', errors_f2_pwlin(i));
end
fprintf('\n\n');

%% Izpis končnih napak

fprintf('Končne napake (n = %d):\n', n_values(end));
fprintf('  Bernsteinova:        %.10f\n', errors_f2_bern(end));
fprintf('  Kantorovičeva:       %.10f\n', errors_f2_kant(end));
fprintf('  Odsekoma linearna:   %.10f\n\n', errors_f2_pwlin(end));

%% Graf napak v logaritemski skali

figure('Name', 'Funkcija 2: Napake v odvisnosti od n', 'Position', [200, 100, 1000, 600]);
semilogy(n_values, errors_f2_bern, 'o-', 'LineWidth', 2, 'MarkerSize', 6, 'DisplayName', 'Bernsteinova');
hold on;
semilogy(n_values, errors_f2_kant, 's-', 'LineWidth', 2, 'MarkerSize', 6, 'DisplayName', 'Kantorovičeva');
semilogy(n_values, errors_f2_pwlin, '^-', 'LineWidth', 2, 'MarkerSize', 6, 'DisplayName', 'Odsekoma linearna');
grid on;
xlabel('n', 'FontSize', 12);
ylabel('Maksimalna napaka (logaritemska skala)', 'FontSize', 12);
title('Napake aproksimacij za f(x) = |x|cos(x^2)', 'FontSize', 14);
legend('Location', 'best', 'FontSize', 11);
set(gca, 'FontSize', 11);

%% Grafi aproksimacij za izbrane vrednosti n

figure('Name', 'Funkcija 2: Primeri aproksimacij', 'Position', [250, 150, 1400, 900]);

for idx = 1:length(n_examples)
    n = n_examples(idx);
    
    % Izračun aproksimacij
    y_bern = bernsteinovaAproksimacija(f2, a, b, n, x_plot);
    y_kant = kantorovicevaAproksimacija(F2, a, b, n, x_plot);
    y_pwlin = odsekomaLinearnaAproksimacija(f2, a, b, n, x_plot);
    y_exact = f2(x_plot);
    
    % Prikaz
    subplot(2, 2, idx);
    plot(x_plot, y_exact, 'k-', 'LineWidth', 2.5, 'DisplayName', 'Točna');
    hold on;
    plot(x_plot, y_bern, '--', 'LineWidth', 1.8, 'DisplayName', 'Bernsteinova');
    plot(x_plot, y_kant, '-.', 'LineWidth', 1.8, 'DisplayName', 'Kantorovičeva');
    plot(x_plot, y_pwlin, ':', 'LineWidth', 1.8, 'DisplayName', 'Odsekoma lin.');
    grid on;
    xlabel('x', 'FontSize', 11);
    ylabel('y', 'FontSize', 11);
    title(sprintf('Aproksimacije za n = %d', n), 'FontSize', 12);
    legend('Location', 'best', 'FontSize', 9);
    set(gca, 'FontSize', 10);
end

sgtitle('Primeri aproksimacij za f(x) = |x|cos(x^2)', 'FontSize', 15, 'FontWeight', 'bold');

%% ========================================================================
%  PRIMERJAVA OBEH FUNKCIJ
%  ========================================================================

fprintf('========================================================\n');
fprintf('  PRIMERJAVA OBEH FUNKCIJ\n');
fprintf('========================================================\n\n');

%% Primerjalni graf napak

figure('Name', 'Primerjava napak za obe funkciji', 'Position', [300, 100, 1400, 600]);

% Funkcija 1
subplot(1, 2, 1);
semilogy(n_values, errors_f1_bern, 'o-', 'LineWidth', 2, 'MarkerSize', 6, 'DisplayName', 'Bernsteinova');
hold on;
semilogy(n_values, errors_f1_kant, 's-', 'LineWidth', 2, 'MarkerSize', 6, 'DisplayName', 'Kantorovičeva');
semilogy(n_values, errors_f1_pwlin, '^-', 'LineWidth', 2, 'MarkerSize', 6, 'DisplayName', 'Odsekoma linearna');
grid on;
xlabel('n', 'FontSize', 12);
ylabel('Maksimalna napaka', 'FontSize', 12);
title('f(x) = cos(2x) (gladka)', 'FontSize', 13);
legend('Location', 'best', 'FontSize', 10);
set(gca, 'FontSize', 11);

% Funkcija 2
subplot(1, 2, 2);
semilogy(n_values, errors_f2_bern, 'o-', 'LineWidth', 2, 'MarkerSize', 6, 'DisplayName', 'Bernsteinova');
hold on;
semilogy(n_values, errors_f2_kant, 's-', 'LineWidth', 2, 'MarkerSize', 6, 'DisplayName', 'Kantorovičeva');
semilogy(n_values, errors_f2_pwlin, '^-', 'LineWidth', 2, 'MarkerSize', 6, 'DisplayName', 'Odsekoma linearna');
grid on;
xlabel('n', 'FontSize', 12);
ylabel('Maksimalna napaka', 'FontSize', 12);
title('f(x) = |x|cos(x^2) (negladka v x=0)', 'FontSize', 13);
legend('Location', 'best', 'FontSize', 10);
set(gca, 'FontSize', 11);

sgtitle('Primerjava konvergence za obe funkciji', 'FontSize', 15, 'FontWeight', 'bold');