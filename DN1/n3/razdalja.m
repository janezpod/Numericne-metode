function razdalja = razdalja(matrika)
% funkcija, ki za matriko 2xn tock vrne vektor razadalj

T = length(matrika);
razdalja = zeros(1, T);

for i = 1:T
    x = matrika(1,i);
    y = matrika(2,i);
    r = sqrt(x^2 + y^2);
    razdalja(i) = r;
end
end

