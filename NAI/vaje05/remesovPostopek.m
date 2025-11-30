function [koef, E, mHist, errHist, diffHist] = remesovPostopek(f, a, b, n, tol, maxIter, E0)
% remesovPostopek - Glavni Remezov postopek (prvi algoritem)
%
% Uporaba:
%   [koef, E, mHist, errHist, diffHist] = remesovPostopek(f, a, b, n, tol, maxIter, E0)
%
% Vhodni parametri:
%   f       - funkcija, ki jo aproksimiramo
%   a, b    - interval [a, b]
%   n       - stopnja polinoma P_n
%   tol     - toleranca (npr. 1e-10)
%   maxIter - največje število iteracij
%   E0      - začetni alternirajoči niz (dolžine n+2)
%
% Izhodni parametri:
%   koef    - koeficienti p(x) = a0 + a1*x + ... + an*x^n
%   E       - končni alternirajoči niz
%   mHist   - minimaksi m_k po korakih
%   errHist - ocene ||r||_inf po korakih
%   diffHist - | ||r||_inf - |m_k| | po korakih

if nargin < 7
    E = linspace(a, b, n + 2);
else
    E = sort(E0(:).');
end

Ngrid = 1000;  % kot v navodilih
mHist = zeros(maxIter, 1);
errHist = zeros(maxIter, 1);
diffHist = zeros(maxIter, 1);

for k = 1:maxIter
    % (a) polinom, ki na E da alternirajoči residual ±m
    [koef, m] = izracunajPolinom(f, E, n);
    g = @(x) polyval(fliplr(koef), x);
    r = @(x) f(x) - g(x);
    
    % (b) največja absolutna napaka na mreži
    [xMax, rMax] = najdiMaksimum(r, a, b, Ngrid);
    errInf = abs(rMax);
    
    mHist(k) = m;
    errHist(k) = errInf;
    diffHist(k) = abs(errInf - abs(m));
    
    % Kriterij ustavitve
    if diffHist(k) < tol
        mHist = mHist(1:k);
        errHist = errHist(1:k);
        diffHist = diffHist(1:k);
        return;
    end
    
    % (c) posodobitev niza E z novo ekstremno točko
    E = posodobiTocke(r, E, xMax);
end

mHist = mHist(1:maxIter);
errHist = errHist(1:maxIter);
diffHist = diffHist(1:maxIter);
warning('remesovPostopek: dosežena maxIter brez konvergence.');

end
