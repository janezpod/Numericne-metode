%% Prvi del
% f(x) = x * sin(2*e^(bx) - 1) na intervalu [-1, 1]
% Začetne točke E = {-1, -7/10, 0, 3/10, 1}

clear; clc;
format long;

%% Definicija funkcije
b = 168/101;
f = @(x) x .* sin(2 * exp(b * x) - 1);

%% Interval
a = -1;
b_int = 1;

%% Stopnja polinoma (5 točk = n+2, torej n=3)
n = 3;

%% Začetne točke iz naloge
E0 = [-1, -7/10, 0, 3/10, 1];

%% Toleranca in maksimalno število iteracij
tol = 1e-10;
maxIter = 100;

%% ========================================================================
%  PRVI DEL: min_{p ∈ P_3} ||f - p||_{∞,E}
%  To je vrednost |m| v PRVEM koraku Remezovega postopka
%  (napaka na začetni množici E0)
%  ========================================================================

fprintf('Vprašanje 2\n\n');
fprintf('b = 168/101 = %.15f\n', 168/101);
fprintf('f(x) = x * sin(2*e^(bx) - 1)\n');
fprintf('Interval: [-1, 1]\n');
fprintf('Začetne točke E0 = [-1, -7/10, 0, 3/10, 1]\n');
fprintf('Stopnja polinoma: n = %d\n\n', n);

% Prvi korak: izračunaj polinom na E0
[koef_1, m_1] = izracunajPolinom(f, E0, n);

fprintf('========================================\n');
fprintf('KONČNI ODGOVORI:\n');
fprintf('========================================\n');
fprintf('Prvi del: min_{p ∈ P_3} ||f - p||_{∞,E} (napaka na E0)\n');
fprintf('|m| v prvem koraku = %.15f\n\n', abs(m_1));

%% ========================================================================
%  DRUGI DEL: p(0) za polinom iz tretjega koraka
%  ========================================================================

% Remezov postopek z maxIter = 3
[koef_3, E_3, mHist_3, errHist_3, diffHist_3] = ...
    remesovPostopek(f, a, b_int, n, tol, 3, E0);

% Polinom iz tretjega koraka
p_3 = @(x) polyval(fliplr(koef_3), x);

% Vrednost p(0) = a0
p_0 = koef_3(1);  % a0 je prvi koeficient

fprintf('Drugi del: p(0) za polinom iz tretjega koraka\n');
fprintf('Koeficienti (a0, a1, a2, a3): ');
fprintf('%.12f ', koef_3);
fprintf('\n');
fprintf('p(0) = a0 = %.15f\n\n', p_0);

%% ========================================================================
%  IZPIS PO KORAKIH
%  ========================================================================

% Polni Remezov postopek za prikaz
[koef_final, E_final, mHist, errHist, diffHist] = ...
    remesovPostopek(f, a, b_int, n, tol, maxIter, E0);

fprintf('Potek Remezovega postopka:\n');
fprintf('korak\t   |m_k|\t\t  ||r||_inf\t\t  diff\n');
for k = 1:numel(mHist)
    fprintf('%2d\t %.15f\t %.15f\t %.2e\n', k, abs(mHist(k)), errHist(k), diffHist(k));
end
fprintf('\n');

%% ========================================================================
%  KONČNI ODGOVORI
%  ========================================================================

fprintf('========================================\n');
fprintf('KONČNI ODGOVORI:\n');
fprintf('========================================\n');
fprintf('min_{p ∈ P_3} ||f - p||_{∞,E} = %.15f\n', abs(m_1));
fprintf('p(0) v tretjem koraku        = %.15f\n', p_0);