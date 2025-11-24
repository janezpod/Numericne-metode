function y = kantorovicevaAproksimacija(F, a, b, n, x)
% kantorovicevaAproksimacija - Izračuna Kantorovičev aproksimacijski polinom
%
% Uporaba:
%   y = kantorovicevaAproksimacija(F, a, b, n, x)
%
% Vhodni parametri:
%   F - primitivna funkcija funkcije f, ki jo aproksimiramo (F' = f)
%   a - levi rob intervala
%   b - desni rob intervala  
%   n - stopnja Kantorovičevega polinoma
%   x - točke, v katerih računamo aproksimacijo
%
% Izhodni parameter:
%   y - vrednosti aproksimacije v točkah x
%
% Matematična formula:
%   Kantorovičev operator na [0,1]:
%       (K_n f)(t) = sum_{i=0}^{n} f_{n,i} * B_i^n(t)
%   
%   kjer je:
%       f_{n,i} = (n+1) * integral_{i/(n+1)}^{(i+1)/(n+1)} f(s) ds
%   
%   in B_i^n(t) = C(n,i) * t^i * (1-t)^(n-i) je Bernsteinov bazni polinom.
%   
%   Koeficient f_{n,i} predstavlja povprečno vrednost funkcije f na 
%   intervalu [i/(n+1), (i+1)/(n+1)].
%   
%   Zakaj (n+1) in ne n?
%   - Bernsteinov operator B_n vzorči v n+1 TOČKAH: 0, 1/n, 2/n, ..., n/n
%   - Kantorovičev operator K_n povpreča na n+1 INTERVALIH: [0,1/(n+1)], ..., [n/(n+1),1]
%   - Za n+1 intervalov potrebujemo delitev z (n+1), kar da n+2 delilnih točk
%   - Tako dobimo n+1 koeficientov, ki ustrezajo n+1 Bernsteinovim bazam B_i^n
%   
%   Reparametrizacija na [a,b]: t = (x-a)/(b-a), delilne točke x_i = a + i(b-a)/(n+1)
%   
%   Pomembna zveza (iz naloge 2a): (B_{n+1} F)' = K_n f
%   Odvod Bernsteinovega operatorja stopnje n+1 za F da Kantorovičev operator 
%   stopnje n za f. To razloži, zakaj Kantorovic uporablja (n+1): integral 
%   [F((i+1)/(n+1)) - F(i/(n+1))] = povprečje funkcije f na intervalu.

% Reparametrizacija: preslikava x iz [a,b] v t iz [0,1]
t = (x - a) / (b - a);

% Inicializacija rezultata
y = zeros(size(x));

% Kantorovičev operator: (K_n f)(x) = sum_{i=0}^{n} f_{n,i} * B_i^n(t)
for i = 0:n
    % Delilne točke z (n+1): x_i = a + i*(b-a)/(n+1)  (ustreza i/(n+1) na [0,1])
    % POZOR: Delimo z (n+1), ne z n! 
    % Razlog: potrebujemo n+1 INTERVALOV (ne točk), saj je koeficient vrednost
    % integrala, torej rabimo n+2 tock (i = 0,1,...,n)
   
    x_i = a + i * (b - a) / (n + 1);
    x_i1 = a + (i + 1) * (b - a) / (n + 1);
    
    % Koeficient: f_{n,i} = (n+1) * integral_{x_i}^{x_{i+1}} f(s) ds
    % 
    % Če je F primitivna funkcija f (torej F' = f), potem velja:
    %   integral_{x_i}^{x_{i+1}} f(s) ds = F(x_{i+1}) - F(x_i)
    % 
    % Reparametrizacija [0,1] → [a,b]:
    %   Transformacija: t = (x-a)/(b-a) ima odvod dt/dx = 1/(b-a)
    %   Substitucijsko pravilo: dt = dx/(b-a), torej:
    %   integral f(t) dt = integral f((x-a)/(b-a)) * (1/(b-a)) dx
    % 
    % Končna formula za f_{n,i} na [a,b]:
    %   f_{n,i} = (n+1)/(b-a) * [F(x_{i+1}) - F(x_i)]
    f_n_i = ((n + 1) / (b - a)) * (F(x_i1) - F(x_i));
    
    % Bernsteinov bazni polinom: B_i^n(t) = C(n,i) * t^i * (1-t)^(n-i)
    B_i_n = nchoosek(n, i) * t.^i .* (1 - t).^(n - i);
    
    % Vsota: sum f_{n,i} * B_i^n(t)
    y = y + f_n_i * B_i_n;
end

end