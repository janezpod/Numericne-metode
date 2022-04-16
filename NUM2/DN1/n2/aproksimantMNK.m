function koef = aproksimantMNK(F,baza,a,b,N)
% Aproksimacija po metodi najmanjših kvadratov za ortonormirano bazo

k = length(baza);
% baza = ortNormBaza(baza,a,b,N);
koef = zeros(1,k);
for i = 1 : k
    koef(i) = diskSkProd(F,baza{i},a,b,N);
end
