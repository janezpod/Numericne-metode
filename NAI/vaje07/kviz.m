%% Metoda najmanjših kvadratov
% f(x) = e^(sin(x²/13))
% Diskretni skalarni produkt: ⟨g,h⟩ = (1/21) Σᵢ₌₀²⁰ g(xᵢ)h(xᵢ), xᵢ = (i/20)*c

clear; clc;
format long;

fprintf('========================================================\n');
fprintf('  REŠITEV VPRAŠANJA 3\n');
fprintf('========================================================\n\n');

%% Definicija funkcije in parametrov
c = 351/101;
f = @(x) exp(sin(x.^2 / 13));

% Diskretni skalarni produkt z N = 20 (21 točk)
N = 20;

fprintf('c = 351/101 = %.15f\n', c);
fprintf('f(x) = e^(sin(x²/13))\n');
fprintf('Skalarni produkt: ⟨g,h⟩ = (1/21) Σᵢ₌₀²⁰ g(xᵢ)h(xᵢ)\n');
fprintf('xᵢ = (i/20)*c, i = 0, 1, ..., 20\n\n');

%% Diskretni skalarni produkt
% xᵢ = (i/20) * c za i = 0, 1, ..., 20
ip_disc = @(g, h) diskretniProdukt(g, h, c, N);

%% ========================================================================
%  PRVI DEL: Bernsteinova baza B_i^4(x)
%  p(x) = Σᵢ₌₀⁴ αᵢ Bᵢ⁴(x)
%  Bᵢ⁴(x) = C(4,i) * xⁱ * (1-x)^(4-i)
%  ========================================================================

fprintf('--------------------------------------------------------\n');
fprintf('  PRVI DEL: Bernsteinova baza\n');
fprintf('--------------------------------------------------------\n\n');

% Bernsteinova baza stopnje 4
% B_i^4(x) = C(4,i) * x^i * (1-x)^(4-i)
basisB = {
    @(x) 1 * x.^0 .* (1-x).^4;    % B_0^4: C(4,0) = 1
    @(x) 4 * x.^1 .* (1-x).^3;    % B_1^4: C(4,1) = 4
    @(x) 6 * x.^2 .* (1-x).^2;    % B_2^4: C(4,2) = 6
    @(x) 4 * x.^3 .* (1-x).^1;    % B_3^4: C(4,3) = 4
    @(x) 1 * x.^4 .* (1-x).^0     % B_4^4: C(4,4) = 1
};

% Aproksimacija
[alphaB, ~, ~] = leastSquaresApprox(f, basisB, ip_disc);
pB = buildApproxFunction(alphaB, basisB);

fprintf('Koeficienti α:\n');
for i = 0:4
    fprintf('  α_%d = %.15f\n', i, alphaB(i+1));
end
fprintf('\n');

% Vsota koeficientov
vsota_alpha = sum(alphaB);
fprintf('Vsota α₀ + α₁ + α₂ + α₃ + α₄ = %.15f\n\n', vsota_alpha);

%% ========================================================================
%  DRUGI DEL: Trigonometrična baza T₂
%  q(x) = β₀/√(2π) + β₁*cos(x)/√π + β₂*sin(x)/√π + β₃*cos(2x)/√π + β₄*sin(2x)/√π
%  ========================================================================

fprintf('--------------------------------------------------------\n');
fprintf('  DRUGI DEL: Trigonometrična baza\n');
fprintf('--------------------------------------------------------\n\n');

% Trigonometrična baza T_2
basisT = {
    @(x) ones(size(x)) / sqrt(2*pi);
    @(x) cos(x) / sqrt(pi);
    @(x) sin(x) / sqrt(pi);
    @(x) cos(2*x) / sqrt(pi);
    @(x) sin(2*x) / sqrt(pi)
};

% Aproksimacija
[alphaT, ~, ~] = leastSquaresApprox(f, basisT, ip_disc);
pT = buildApproxFunction(alphaT, basisT);

fprintf('Koeficienti β:\n');
for i = 0:4
    fprintf('  β_%d = %.15f\n', i, alphaT(i+1));
end
fprintf('\n');

% Napaka ||f - p|| v diskretni normi (opomba: v nalogi piše p, mislijo pa q)
errT_fun = @(x) f(x) - pT(x);
norm_errT = sqrt(ip_disc(errT_fun, errT_fun));

fprintf('Napaka ||f - p|| = %.15f\n\n', norm_errT);

%% ========================================================================
%  KONČNI ODGOVORI
%  ========================================================================

fprintf('========================================================\n');
fprintf('  KONČNI ODGOVORI\n');
fprintf('========================================================\n');
fprintf('α₀ + α₁ + ... + α₄ = %.15f\n', vsota_alpha);
fprintf('||f - p||          = %.15f\n', norm_errT);

%% Pomožna funkcija za diskretni skalarni produkt

function val = diskretniProdukt(g, h, c, N)
% Diskretni skalarni produkt: ⟨g,h⟩ = (1/(N+1)) Σᵢ₌₀^N g(xᵢ)h(xᵢ)
% kjer xᵢ = (i/N) * c
    i_vals = 0:N;
    x_vals = (i_vals / N) * c;
    vals = g(x_vals) .* h(x_vals);
    val = mean(vals);  % = 1/(N+1) * sum(vals)
end