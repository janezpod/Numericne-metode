%% Naloga 3 – Metoda najmanjših kvadratov za P4 in T2
clear; close all; clc;
format long;

fprintf('========================================================\n');
fprintf('  METODA NAJMANJŠIH KVADRATOV\n');
fprintf('========================================================\n\n');

%% Osnovne nastavitve
a = 0;
b = 2 * pi;
N = 50;  % za diskretni skalarni produkt

% Aproksimand
f = @(x) exp(sin(x.^2 / 10));

% Skalarni produkti
ip_cont = @(g, h) innerProdContinuous(g, h, a, b);
ip_disc = @(g, h) innerProdDiscreteEquidistant(g, h, a, b, N);

fprintf('Funkcija: f(x) = exp(sin(x^2/10))\n');
fprintf('Interval: [0, 2π]\n');
fprintf('Skalarni produkt zvezni: ⟨g,h⟩ = ∫₀^{2π} g(x)h(x) dx\n');
fprintf('Skalarni produkt diskretni: ⟨g,h⟩_N, N = %d\n\n', N);

%% Baza za P4 (potenčna baza)
% p(x) = c0 + c1*x + c2*x^2 + c3*x^3 + c4*x^4
basisP = {
    @(x) ones(size(x));   % x^0
    @(x) x;               % x^1
    @(x) x.^2;            % x^2
    @(x) x.^3;            % x^3
    @(x) x.^4             % x^4
};

%% Baza za T2 (trigonometrična baza)
% {1/√(2π), cos(x)/√π, sin(x)/√π, cos(2x)/√π, sin(2x)/√π}
basisT = {
    @(x) ones(size(x)) / sqrt(2*pi);
    @(x) cos(x) / sqrt(pi);
    @(x) sin(x) / sqrt(pi);
    @(x) cos(2*x) / sqrt(pi);
    @(x) sin(2*x) / sqrt(pi)
};

%% 1) Aproksimacija v P4 z zveznim skalarnim produktom
[alphaP_cont, ~, ~] = leastSquaresApprox(f, basisP, ip_cont);
pP_cont = buildApproxFunction(alphaP_cont, basisP);

%% 2) Aproksimacija v P4 z diskretnim skalarnim produktom
[alphaP_disc, ~, ~] = leastSquaresApprox(f, basisP, ip_disc);
pP_disc = buildApproxFunction(alphaP_disc, basisP);

%% 3) Aproksimacija v T2 z zveznim skalarnim produktom
[alphaT_cont, ~, ~] = leastSquaresApprox(f, basisT, ip_cont);
pT_cont = buildApproxFunction(alphaT_cont, basisT);

%% 4) Aproksimacija v T2 z diskretnim skalarnim produktom
[alphaT_disc, ~, ~] = leastSquaresApprox(f, basisT, ip_disc);
pT_disc = buildApproxFunction(alphaT_disc, basisT);

%% Izpis koeficientov

fprintf('--------------------------------------------------------\n');
fprintf('  KOEFICIENTI\n');
fprintf('--------------------------------------------------------\n\n');

fprintf('--- Koeficienti za P4 (potenčna baza) ---\n');
fprintf('Zvezni skalarni produkt:\n');
fprintf('  alphaP_cont = [');
fprintf('%.10f ', alphaP_cont);
fprintf(']\n\n');

fprintf('Diskretni skalarni produkt:\n');
fprintf('  alphaP_disc = [');
fprintf('%.10f ', alphaP_disc);
fprintf(']\n\n');

fprintf('--- Koeficienti za T2 (trigonometrična baza) ---\n');
fprintf('Zvezni skalarni produkt:\n');
fprintf('  alphaT_cont = [');
fprintf('%.10f ', alphaT_cont);
fprintf(']\n\n');

fprintf('Diskretni skalarni produkt:\n');
fprintf('  alphaT_disc = [');
fprintf('%.10f ', alphaT_disc);
fprintf(']\n\n');

%% Norme napak v normi, inducirani z zveznim skalarnim produktom

errP_cont_fun = @(x) f(x) - pP_cont(x);
errP_disc_fun = @(x) f(x) - pP_disc(x);
errT_cont_fun = @(x) f(x) - pT_cont(x);
errT_disc_fun = @(x) f(x) - pT_disc(x);

norm_errP_cont = sqrt(ip_cont(errP_cont_fun, errP_cont_fun));
norm_errP_disc = sqrt(ip_cont(errP_disc_fun, errP_disc_fun));
norm_errT_cont = sqrt(ip_cont(errT_cont_fun, errT_cont_fun));
norm_errT_disc = sqrt(ip_cont(errT_disc_fun, errT_disc_fun));

fprintf('--------------------------------------------------------\n');
fprintf('  NORME NAPAK (zvezna norma)\n');
fprintf('--------------------------------------------------------\n\n');

fprintf('P4, zvezni produkt      : ||f - p_P4^cont|| = %.12e\n', norm_errP_cont);
fprintf('P4, diskretni produkt   : ||f - p_P4^disc|| = %.12e\n', norm_errP_disc);
fprintf('T2, zvezni produkt      : ||f - p_T2^cont|| = %.12e\n', norm_errT_cont);
fprintf('T2, diskretni produkt   : ||f - p_T2^disc|| = %.12e\n', norm_errT_disc);
fprintf('\n');

%% Tabela primerjave

fprintf('========================================================\n');
fprintf('  PRIMERJAVA\n');
fprintf('========================================================\n\n');

fprintf('%-25s %-15s %-20s\n', 'Baza', 'Skalarni prod.', '||f - aproks||₂');
fprintf('%-25s %-15s %-20s\n', '-------------------------', '---------------', '--------------------');
fprintf('%-25s %-15s %.12e\n', 'P_4 (polinomska)', 'zvezni', norm_errP_cont);
fprintf('%-25s %-15s %.12e\n', 'P_4 (polinomska)', 'diskretni', norm_errP_disc);
fprintf('%-25s %-15s %.12e\n', 'T_2 (trigonometrična)', 'zvezni', norm_errT_cont);
fprintf('%-25s %-15s %.12e\n', 'T_2 (trigonometrična)', 'diskretni', norm_errT_disc);
fprintf('\n');

%% Grafi

x_plot = linspace(a, b, 500);

figure('Name', 'Aproksimacije', 'Position', [100, 100, 1400, 900]);

subplot(2, 2, 1);
plot(x_plot, f(x_plot), 'k-', 'LineWidth', 2, 'DisplayName', 'f(x)');
hold on;
plot(x_plot, pP_cont(x_plot), 'r--', 'LineWidth', 1.5, 'DisplayName', 'P_4 aproks');
grid on;
xlabel('x'); ylabel('y');
title('P_4, zvezni skalarni produkt');
legend('Location', 'best');

subplot(2, 2, 2);
plot(x_plot, f(x_plot), 'k-', 'LineWidth', 2, 'DisplayName', 'f(x)');
hold on;
plot(x_plot, pP_disc(x_plot), 'r--', 'LineWidth', 1.5, 'DisplayName', 'P_4 aproks');
grid on;
xlabel('x'); ylabel('y');
title('P_4, diskretni skalarni produkt');
legend('Location', 'best');

subplot(2, 2, 3);
plot(x_plot, f(x_plot), 'k-', 'LineWidth', 2, 'DisplayName', 'f(x)');
hold on;
plot(x_plot, pT_cont(x_plot), 'b--', 'LineWidth', 1.5, 'DisplayName', 'T_2 aproks');
grid on;
xlabel('x'); ylabel('y');
title('T_2, zvezni skalarni produkt');
legend('Location', 'best');

subplot(2, 2, 4);
plot(x_plot, f(x_plot), 'k-', 'LineWidth', 2, 'DisplayName', 'f(x)');
hold on;
plot(x_plot, pT_disc(x_plot), 'b--', 'LineWidth', 1.5, 'DisplayName', 'T_2 aproks');
grid on;
xlabel('x'); ylabel('y');
title('T_2, diskretni skalarni produkt');
legend('Location', 'best');

sgtitle('Aproksimacije za f(x) = e^{sin(x^2/10)}', 'FontSize', 14, 'FontWeight', 'bold');

fprintf('========================================================\n');
fprintf('  KONEC\n');
fprintf('========================================================\n');
