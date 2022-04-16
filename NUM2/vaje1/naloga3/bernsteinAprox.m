function Bf = bernsteinAprox(f,n,a,b)
%Vrne aproksimant B_n(f)

%Naredimo bazo Bernsteinovih baznih polinomov na [a,b]
baza = bazaBernstein2(n,a,b);
%Izracunamo vrednosti f v n+1 enakomerno izbranih tockah na [a,b]
fi = f(linspace(a,b,n+1));
%Zacnemo s funkcijo 0
Bf = @(t) 0;
%Sprehodimo se po vseh baznih polinomih
for i = 0:n
    %Nasi funkciji pristejemo clen z i-tim baznim polinomom
    Bf = @(t) Bf(t) + fi(i+1)*baza{i+1}(t); 
end
end