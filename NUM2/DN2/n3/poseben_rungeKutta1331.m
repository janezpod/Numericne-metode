function [x,y] = poseben_rungeKutta1331(f, a, b, y0, h)
% f je DE y′ = f(x,y), [a,b] interval resevanja,
% y0 zacetna vrednost, h korak za x.

x = a:h:b;
y = length(length(x));  
y(1) = y0; 

for i=1:(length(x)-1)                             
    k1 = h*f(x(i),y(i));
    k2 = h*f(x(i)+(1/3)*h,y(i)+(1/3)*k1);
    k3 = h*f(x(i)+(2/3)*h,y(i)-(1/3)*k1 + 1*k2);
    k4 = h*f(x(i)+1*h,y(i)+1*k1 - 1*k2 + k3);
    y(i+1) = y(i) + (1/8)*k1 + (3/8)*k2 + (3/8)*k3 + (1/8)*k4; 
end









end