function [x,y] = Trapezno(f, a, b, y0, h)
% Vrne priblizek za resitev NDE Y' = f(x,Y), Y(0) = y0, na intervalu [a,b]
% s korakom h

% y0 ... vektor

x = a:h:b;
y=zeros(length(y0),length(x));
y(:,1) = y0;
for i = 2:length(x)
    fun = @(yn) yn - (y(:, i -1)+h/2*(f(x(i - 1), y(:, i - 1)) + f(x(i), yn)));
    yn = fsolve(fun,y(:,i-1)); %tu fzero ne bo delal, ker vstavljamo vektor
    y(:,i)=yn;
end