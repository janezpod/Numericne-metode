function y = odsekomaLinearnaAproksimacija(f, a, b, n, x)
% odsekomaLinearnaAproksimacija - Izračuna odsekoma linearno aproksimacijo
%
% Uporaba:
%   y = odsekomaLinearnaAproksimacija(f, a, b, n, x)
%
% Vhodni parametri:
%   f - funkcija, ki jo aproksimiramo
%   a - levi rob intervala
%   b - desni rob intervala  
%   n - število intervalov delitve
%   x - točke, v katerih računamo aproksimacijo
%
% Izhodni parameter:
%   y - vrednosti aproksimacije v točkah x
%
% Matematična formula:
%   Odsekoma linearen interpolant (operator I_{1,x}):
%       (I_{1,x} f)(x) = sum_{i=0}^{n} f(x_i) * H_i(x)
%   
%   kjer so x_i = a + i*(b-a)/n delilne točke, i = 0, 1, ..., n,
%   in H_i(x) funkcije "hat" (klobučne funkcije), ki tvorijo bazo 
%   prostora S_{1,x} zveznih odsekoma linearnih funkcij.
%   
%   Funkcija na intervalu [x_{i-1}, x_i] ustreza linearni interpolaciji
%   med točkama (x_{i-1}, f(x_{i-1})) in (x_i, f(x_i)).

% Delilne točke: x_i = a + i*(b-a)/n, i = 0, 1, ..., n
x_interp = a + (0:n) * (b - a) / n;

% Vrednosti funkcije f v delilnih točkah: f(x_i)
y_interp = arrayfun(f, x_interp);

% Odsekoma linearna interpolacija: I_{1,x} f
% Na vsakem intervalu [x_{i-1}, x_i] je funkcija linearna
y = interp1(x_interp, y_interp, x, 'linear', 'extrap');

end