function [koef,m] = oscilirajociPolinom(F,a,b,n)
% Prvi korak Ramazesovega algortima

%  Ce je polinom p, stopnje n, taksen, da residual r = F - p doseze svojo neskoncno
% normo alternirajoce v vsaj n+2 tockah, potem je polinom p polinom
% najboljse enakomerne aprkismacije.

%  Za vsaki i, kjer je i izbrana tocka od 1 do n+2 resujemo enacbo oblike
% f(xi)-p(xi) = (-1)^i * m, kjer so neznanke koeficienti polinoma p in m.
% Preoblikujemo v p(xi) + (-1)^i * m = F(xi). To je Vandermondova
% matrika izbranih n+2 tock, ki ji odstranimo prvi stolpec in zadnjega
% nadomestimo z alternirajocim stolpecm enic.

E = linspace(a,b,n+2); % ekvidistancne tocke
v = zeros(n+2,1); % alternarijajoce enice
f = zeros(n+2,1); % vrednosti funkcije F

for i = 1:n+2
    v(i) = (-1)^i;
    f(i) = F(E(i));
end

A = vander(E);
A(:,1) = []; % izbrisemo prvi stolpec
A = [A,v]; % dodamo stolpec alternirajocic enic

K = linsolve(A,f); % resimo sistem enacb
koef = K(1:end-1);
m = K(end);


%% PRIMER
% a=0;b=1;n=1;
% F = @(x) exp(x);
% 
%% Ekvidistancne tocke
% E = linspace(a,b,n+2);
% 
%% preurjenea Vandermondova matrika
% A = vander(E);
% A(:,n) = []; % izbrisemo prvi stolpec
% v = zeros(n+2,1);
% for i = 1:n+2
%     v(i) = (-1)^i;
% end
% A = [A,v];
% 
%% Resimo Ax = f
% f = zeros(n+2,1);
% for i = 1:n+2
%     f(i) = F(E(i));
% end
% K = linsolve(A,f);





