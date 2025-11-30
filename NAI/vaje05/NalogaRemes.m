%% Remezov postopek za f(x) = |x| sin(2 e^{3x/2} - 1)
clear; close all; clc;
format long;

%% Nastavitve intervala in funkcije
a = -1;  % levi rob
b = 1;   % desni rob

f = @(x) abs(x) .* sin(2 * exp(3 * x / 2) - 1);

tol = 1e-10;
maxIter = 100;

% Mreža za diskretno enakomerno normo (zahteva naloge: 1001 točk)
xErr = linspace(a, b, 1001);
fErr = f(xErr);

% Stopnje polinomov
stopnje = [2, 4, 6, 8];

% Točke za risanje grafov
x_plot = linspace(a, b, 500);

% Shranjevanje rezultatov za grafe
rezultati = struct();

for idx = 1:length(stopnje)
    n = stopnje(idx);
    
    fprintf('\n=============================================\n');
    fprintf('Stopnja n = %d, interval [%g, %g]\n', n, a, b);
    
    %% Začetni niz E0 iz naloge: {±1/(n+1), ±3/(n+1), ..., ±(n-1)/(n+1), ±1}
    odds = 1:2:(n+1);         % 1, 3, ..., n+1
    t = odds / (n + 1);       % (2k-1)/(n+1) na [-1,1]
    E0 = sort([-t, t]);       % simetričen niz v [-1,1]
    
    fprintf('Začetni niz E0:\n');
    fprintf('%.10f ', E0);
    fprintf('\n');
    
    %% Remezov postopek
    [koef, Efinal, mHist, errHist, diffHist] = ...
        remesovPostopek(f, a, b, n, tol, maxIter, E0);
    
    %% Izpis po korakih: korak | minimaks | razlika
    fprintf('\nkorak\t   minimaks m_k\t\t  | ||r||_inf - |m_k| |\n');
    for k = 1:numel(mHist)
        fprintf('%2d\t %.8e\t %.8e\n', k, mHist(k), diffHist(k));
    end
    
    %% Koeficienti polinoma
    fprintf('\nKoeficienti polinoma p_%d(x) = a0 + a1 x + ... + a%d x^%d:\n', n, n, n);
    fprintf('a = ');
    fprintf('%.8f ', koef);
    fprintf('\n');
    
    %% Napaka aproksimacije v diskretni enakomerni normi
    p = @(x) polyval(fliplr(koef), x);
    pErr = p(xErr);
    discErr = max(abs(fErr - pErr));
    
    fprintf('\nNapaka aproksimacije v diskretni enakomerni normi ');
    fprintf('na linspace(%g, %g, 1001):\n', a, b);
    fprintf('||f - p_%d||_inf,disc = %.15f\n', n, discErr);
    
    %% Končni alternirajoči niz
    fprintf('\nKončni alternirajoči niz E (dolžine n+2):\n');
    fprintf('%.6f ', Efinal);
    fprintf('\n');
    
    %% Shrani rezultate za grafe
    rezultati(idx).n = n;
    rezultati(idx).koef = koef;
    rezultati(idx).E = Efinal;
    rezultati(idx).napaka = discErr;
end

%% ========================================================================
%  TABELA NAPAK
%  ========================================================================

fprintf('\n=============================================\n');
fprintf('  PRIMERJAVA NAPAK\n');
fprintf('=============================================\n\n');

fprintf('%-10s %-25s\n', 'n', '||f - p_n||_inf');
fprintf('%-10s %-25s\n', '----------', '-------------------------');
for idx = 1:length(stopnje)
    fprintf('%-10d %.15f\n', rezultati(idx).n, rezultati(idx).napaka);
end
fprintf('\n');

%% ========================================================================
%  GRAFI APROKSIMACIJ
%  ========================================================================

figure('Name', 'Remesove aproksimacije', 'Position', [100, 100, 1400, 900]);

for idx = 1:length(stopnje)
    n = rezultati(idx).n;
    koef = rezultati(idx).koef;
    
    % Vrednosti funkcije in aproksimacije
    y_exact = f(x_plot);
    y_approx = polyval(fliplr(koef), x_plot);
    
    subplot(2, 2, idx);
    plot(x_plot, y_exact, 'b-', 'LineWidth', 2, 'DisplayName', 'f(x)');
    hold on;
    plot(x_plot, y_approx, 'r--', 'LineWidth', 1.5, 'DisplayName', sprintf('p_%d(x)', n));
    
    % Označi Remesove točke
    E = rezultati(idx).E;
    plot(E, f(E), 'ko', 'MarkerSize', 8, 'MarkerFaceColor', 'g', 'DisplayName', 'Remesove točke');
    
    grid on;
    xlabel('x', 'FontSize', 11);
    ylabel('y', 'FontSize', 11);
    title(sprintf('Remesova aproksimacija stopnje n = %d', n), 'FontSize', 12);
    legend('Location', 'best', 'FontSize', 9);
    set(gca, 'FontSize', 10);
end

sgtitle('Remesove aproksimacije za f(x) = |x| sin(2e^{3x/2} - 1)', 'FontSize', 14, 'FontWeight', 'bold');

%% ========================================================================
%  GRAFI RESIDUALOV
%  ========================================================================

figure('Name', 'Residuali Remesovih aproksimacij', 'Position', [150, 100, 1400, 900]);

for idx = 1:length(stopnje)
    n = rezultati(idx).n;
    koef = rezultati(idx).koef;
    napaka = rezultati(idx).napaka;
    E = rezultati(idx).E;
    
    % Residual
    r_values = f(x_plot) - polyval(fliplr(koef), x_plot);
    r_E = f(E) - polyval(fliplr(koef), E);
    
    subplot(2, 2, idx);
    plot(x_plot, r_values, 'b-', 'LineWidth', 1.5);
    hold on;
    plot(x_plot, napaka * ones(size(x_plot)), 'r--', 'LineWidth', 1);
    plot(x_plot, -napaka * ones(size(x_plot)), 'r--', 'LineWidth', 1);
    plot(E, r_E, 'ko', 'MarkerSize', 8, 'MarkerFaceColor', 'g');
    
    grid on;
    xlabel('x', 'FontSize', 11);
    ylabel('r(x) = f(x) - p_n(x)', 'FontSize', 11);
    title(sprintf('Residual za n = %d, ||r||_\\infty = %.2e', n, napaka), 'FontSize', 12);
    set(gca, 'FontSize', 10);
end

sgtitle('Residuali Remesovih aproksimacij (ekvioscilacija)', 'FontSize', 14, 'FontWeight', 'bold');

%% ========================================================================
%  GRAF NAPAK V ODVISNOSTI OD n
%  ========================================================================

figure('Name', 'Napake v odvisnosti od n', 'Position', [200, 100, 800, 500]);

napake = [rezultati.napaka];
semilogy(stopnje, napake, 'bo-', 'LineWidth', 2, 'MarkerSize', 10, 'MarkerFaceColor', 'b');
grid on;
xlabel('Stopnja polinoma n', 'FontSize', 12);
ylabel('Napaka ||f - p_n||_\infty (log skala)', 'FontSize', 12);
title('Konvergenca Remesovega postopka', 'FontSize', 14);
set(gca, 'FontSize', 11);
xticks(stopnje);

fprintf('=============================================\n');
fprintf('  KONEC\n');
fprintf('=============================================\n');
