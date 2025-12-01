function p = buildApproxFunction(alpha, basis)
% buildApproxFunction - Iz koeficientov in baze sestavi aproksimant p(x)
%
% Uporaba:
%   p = buildApproxFunction(alpha, basis)
%
% Vhodni parametri:
%   alpha - vektor koeficientov α_j
%   basis - celica baznih funkcij {f0, ..., fn}
%
% Izhodni parameter:
%   p - function handle p(x) = Σ α_j f_j(x)

m = numel(alpha);
if m ~= numel(basis)
    error('buildApproxFunction: dimenzija alpha in basis se ne ujema.');
end

p = @(x) localEval(x, alpha, basis);

end

function y = localEval(x, alpha, basis)
    m = numel(alpha);
    y = zeros(size(x));
    for j = 1:m
        y = y + alpha(j) * basis{j}(x);
    end
end
