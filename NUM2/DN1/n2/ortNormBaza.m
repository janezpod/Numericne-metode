function baza = ortNormBaza(baza,a,b,N)
% Ortonormalizacija izbrane baze z modificiranim Gram-Schmidtovim postopkom

k = length(baza);
for i = 1 : k
    norma = sqrt(diskSkProd(baza{i},baza{i},a,b,N));
    baza{i} = @(x) baza{i}(x) / norma;
    for j = i+1 : k
        p = diskSkProd(baza{i},baza{j},a,b,N);
        baza{j} = @(x) baza{j}(x) - p*(baza{i}(x));
    end
end