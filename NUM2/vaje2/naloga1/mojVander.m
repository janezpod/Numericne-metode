function V = mojVander(vecx)
%Vrne Vandermondovo matriko za vektor vrednosti vecx = [x_1,...,x_n]
n = length(vecx);

%Naredimo prazno matriko velikosti n x n
V = zeros(n,n);

%Napolnimo stolpce z vektorji oblike [x_1^i, x_2^i, ..., x_n ^i]
for i = 1:n
    V(:,i) = vecx.^(i-1);
end

end