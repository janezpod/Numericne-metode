function baza = bazaBernstein2(n,a,b)
%Vrne bazo Bernsteinovih polinomov stopnje n na intervalu [a,b]

%Naredimo tabelo klasicnih baznih polinomov (na intervalu [0,1]
baza = bazaBernstein(n);
for i=0:n
    %Vsakega komponiramo z linearno transformacijo t -> (t-a) / (b-a)
    baza{i+1} = @(t) baza{i+1}((t-a)/(b-a));
end
end