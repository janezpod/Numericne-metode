function [norma] = norma(A, tip)
% Funkcija, ki izračuna normo tipa = [1,2,'inf','fro']
absA= abs(A);
if tip == 1
    A = absA;
    c = sum(A,1);
    norma = max(c);
elseif tip == 2
    AT = transpose(A);
    C = A * AT;
    norma = sqrt(max(eig(C)));
elseif tip == 'inf'
    A = absA;
    c = sum(A,2);
    norma = max(c);
elseif tip == 'fro'
    A = A.^2;
    norma = sqrt(sum(sum(A)));
else
    error('Vnesite 1, 2, "inf", "fro"')
end

