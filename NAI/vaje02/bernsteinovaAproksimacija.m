function y = bernsteinovaAproksimacija(f, a, b, n, x)
% bernsteinovaAproksimacija - Izračuna Bernsteinov aproksimacijski polinom
%
% Uporaba:
%   y = bernsteinovaAproksimacija(f, a, b, n, x)
%
% Vhodni parametri:
%   f - funkcija, ki jo aproksimiramo
%   a - levi rob intervala
%   b - desni rob intervala  
%   n - stopnja Bernsteinovega polinoma
%   x - točke, v katerih računamo aproksimacijo
%
% Izhodni parameter:
%   y - vrednosti aproksimacije v točkah x
%
% Matematična formula:
%   Bernsteinov operator na [0,1]:
%       (B_n f)(t) = sum_{i=0}^{n} f(i/n) * B_i^n(t)
%   
%   kjer je B_i^n(t) = C(n,i) * t^i * (1-t)^(n-i) Bernsteinov bazni polinom.
%   
%   Reparametrizacija na [a,b]: t = (x-a)/(b-a), vzorčne točke x_i = a + i(b-a)/n

% Reparametrizacija: preslikava x iz [a,b] v t iz [0,1]
t = (x - a) / (b - a);

% Inicializacija rezultata
y = zeros(size(x));

% Bernsteinov operator: (B_n f)(x) = sum_{i=0}^{n} f(x_i) * B_i^n(t)
for i = 0:n
    % Vzorčna točka: x_i = a + i*(b-a)/n  (ustreza točki i/n na [0,1])
    x_i = a + i * (b - a) / n;
    
    % Bernsteinov bazni polinom: B_i^n(t) = C(n,i) * t^i * (1-t)^(n-i)
    B_i_n = nchoosek(n, i) * t.^i .* (1 - t).^(n - i);
    
    % Vsota: sum f(x_i) * B_i^n(t)
    y = y + f(x_i) * B_i_n;
end

end