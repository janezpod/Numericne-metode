function [xMax, rMax] = najdiMaksimum(r, a, b, N)
% najdiMaksimum - Korak (b) prvega Remezovega postopka
%
% Uporaba:
%   [xMax, rMax] = najdiMaksimum(r, a, b, N)
%
% Vhodni parametri:
%   r   - funkcija (residual r(x) = f(x) - p(x))
%   a,b - interval [a,b]
%   N   - število podintervalov (privzeto 1000), mreža ima N+1 točk
%
% Izhodni parametri:
%   xMax - točka iz mreže, kjer je |r| maksimalen
%   rMax - vrednost residuala v tej točki (r(xMax))

if nargin < 4
    N = 1000;
end

xGrid = a + (0:N) * (b - a) / N;
vals = r(xGrid);
[~, idx] = max(abs(vals));
xMax = xGrid(idx);
rMax = vals(idx);

end
