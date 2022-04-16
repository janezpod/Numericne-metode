function vr = resNorm(F,koef,a,b,N)
% Diskretni približek za neskončno normo residuala na N ekvidistancnih tockah.

E = linspace(a,b,N);
r = zeros(1,N); % residual v tockah
for i = 1:N
    r(i) = abs(F(E(i)) - polyval(koef,E(i)));
end

vr = max(r);