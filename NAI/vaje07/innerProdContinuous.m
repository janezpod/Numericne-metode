function val = innerProdContinuous(g, h, a, b)
% innerProdContinuous - Zvezni skalarni produkt na [a, b]
%
% Uporaba:
%   val = innerProdContinuous(g, h, a, b)
%
% Vhodni parametri:
%   g, h - funkciji (function handle)
%   a, b - interval [a, b]
%
% Izhodni parameter:
%   val - vrednost ⟨g, h⟩ = ∫_a^b g(x) h(x) dx

integrand = @(x) g(x) .* h(x);

val = integral(integrand, a, b, ...
               'AbsTol', 1e-14, 'RelTol', 1e-14, ...
               'ArrayValued', true);

end
