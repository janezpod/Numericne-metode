function [a, m] = izracunajPolinom(f, E, n)
% izracunajPolinom - Korak (a) prvega Remezovega postopka
%
% Uporaba:
%   [a, m] = izracunajPolinom(f, E, n)
%
% Vhodni parametri:
%   f - funkcija, ki jo aproksimiramo
%   E - urejen seznam točk dolžine n+2
%   n - stopnja polinoma
%
% Izhodni parametri:
%   a - koeficienti polinoma p(x) = a0 + a1*x + ... + an*x^n
%   m - konstanta alternacije, tako da na E velja
%       f(x_i) - p(x_i) = (-1)^(i-1) * m

E = E(:);  % stolpec
k = numel(E);

if k ~= n + 2
    error('izracunajPolinom: dolžina E mora biti n+2.');
end

% Zgradimo sistem A * u = b
% u = [a0; a1; ...; an; m]
% Za vsak i: sum_j a_j * x_i^j + (-1)^(i-1) * m = f(x_i)

A = zeros(k, n + 2);
for i = 1:k
    xi = E(i);
    % stolpci 1..(n+1): 1, x, x^2, ..., x^n
    A(i, 1:n+1) = xi.^(0:n);
    % zadnji stolpec: (-1)^(i-1)
    A(i, n+2) = (-1)^(i-1);
end

b = f(E);

% Rešitev sistema
u = A \ b;

a = u(1:n+1).';  % a0..an (vrnemo kot vrstico)
m = u(end);

end
