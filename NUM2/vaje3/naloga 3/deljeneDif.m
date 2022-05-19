function d = deljeneDif(X,Y)
% function d = deljeneDif(X,Y)
% Trikotna shema za izracun deljenih diferenc.
% X so paroma razlicne interpolacijske tocke [x0 x1 ... xn]
% Y so vrednosti interpolacijskih tock [y0 y1 ... yn]
% Metoda vrne koeficiente polinoma (deljene diference).

n = length(X)-1;
M = zeros(n+1);
M(:,1) = Y';
for j=2:n+1
    for i=j:n+1
        M(i,j) = (M(i,j-1)-M(i-1,j-1))/(X(i)-X(i-j+1));
    end
end
d=diag(M);