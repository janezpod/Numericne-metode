function v = Horner(X,d,t)
% function v = Horner(X,d,t)
% Hornerjev algoritem za izracun polinoma p v tockah, zapisanega v Newtonovi obliki.
% X so interpolacijske tocke [x0 x1 x2 .... xn], d so koeficienti polinoma p (deljene diference),
% t so tocke, v katerih izracunamo vrednost polinoma.
% Metoda vrne v, v = p(t).

n = length(X)-1;
v = d(n+1);
for i = n:-1:1
    v = d(i)+(t-X(i)).*v;
end
    
    