function [alpha, G, b] = leastSquaresApprox(f, basis, innerProd)
% leastSquaresApprox - Metoda najmanjših kvadratov za aproksimacijo funkcije f
%
% Uporaba:
%   [alpha, G, b] = leastSquaresApprox(f, basis, innerProd)
%
% Vhodni parametri:
%   f         - funkcija, ki jo aproksimiramo
%   basis     - celica baznih funkcij {f0, f1, ..., fn}, vsaka @(x) ...
%   innerProd - funkcija za skalarni produkt: innerProd(g, h) vrne ⟨g, h⟩
%
% Izhodni parametri:
%   alpha - vektor koeficientov α_j, j = 0, ..., n
%           tako da p(x) = Σ α_j f_j(x) je element najboljše aproksimacije
%   G     - Gramova matrika G_{jk} = ⟨f_j, f_k⟩
%   b     - desni člen b_j = ⟨f, f_j⟩

m = numel(basis);  % m = n+1

G = zeros(m, m);
b = zeros(m, 1);

% Gramova matrika in desni člen
for j = 1:m
    fj = basis{j};
    b(j) = innerProd(f, fj);
    for k = j:m
        fk = basis{k};
        G(j, k) = innerProd(fj, fk);
        G(k, j) = G(j, k);  % simetričnost
    end
end

% Rešimo normalni sistem G * alpha = b
alpha = G \ b;

end
