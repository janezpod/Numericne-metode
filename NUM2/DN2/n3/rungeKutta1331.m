function [x,Y] = rungeKutta1331(F, a, b, Y0, h)
% F je DE y′ = f(x,y), [a,b] interval resevanja,
% Y0 zacetna vrednost, h korak za x.
% Resi tudi sistem dveh DE enacb.

x = a:h:b;
Y = zeros(length(Y0),length(x));
Y(:,1) = Y0; 

for i=2:length(x)                             
    k1 = h*F(x(i-1),Y(:,(i-1)));
    k2 = h*F(x(i-1)+(1/3)*h,Y(:,i-1)+(1/3)*k1);
    k3 = h*F(x(i-1)+(2/3)*h,Y(:,i-1)-(1/3)*k1 + 1*k2);
    k4 = h*F(x(i-1)+1*h,Y(:,i-1)+1*k1 - 1*k2 + k3);
    Y(:,i) = Y(:,i-1) + (1/8)*k1 + (3/8)*k2 + (3/8)*k3 + (1/8)*k4; 
end


end