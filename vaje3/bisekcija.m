function [x,X] = bisekcija(f,a,b,N)
% Meotda bisekcija za funkcijo f na intervalu [a,b] z N koraki

if sign(f(a)) == sign(f(b))
    error("Funkcija ni nasprotno predznačena v a in b")
end

X = zeros(1,N);
s = b-a;
for i = 1:N
    s = s/2;
    c = a+s;
    X(i) = f(c);
    if sign(f(a)) == sign(f(c))
        a = c;
    end
x = X(N);
end

