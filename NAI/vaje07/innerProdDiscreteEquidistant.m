function val = innerProdDiscreteEquidistant(g, h, a, b, N)
% innerProdDiscreteEquidistant - Diskretni skalarni produkt na enakomerni mreži
%
% Uporaba:
%   val = innerProdDiscreteEquidistant(g, h, a, b, N)
%
% Vhodni parametri:
%   g, h - funkciji (function handle)
%   a, b - interval [a, b]
%   N    - število podintervalov (skupaj N+1 točk)
%
% Izhodni parameter:
%   val - vrednost ⟨g, h⟩_N = (1/(N+1)) Σᵢ₌₀^N g(xᵢ) h(xᵢ)
%         kjer xᵢ = a + i*(b-a)/N
%
% Formula iz naloge:
%   ⟨g, h⟩_N = (1/(N+1)) Σᵢ₌₀^N g(2πi/N) h(2πi/N), N = 50

x = a + (0:N) * (b - a) / N;
vals = g(x) .* h(x);
val = mean(vals);  % 1/(N+1) * sum(vals)

end
