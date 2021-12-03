N = 1000;
C = 50;
P = 1100;

f = @(x) C./(1+x) + C./(1+x).^2 + C./(1+x).^3 + C./(1+x).^4 + ...
    (C+N)./(1+x).^5 - P;
df = @(x) -C./(1+x).^2 -2*C./(1+x).^3 -3*C./(1+x).^4 - 4*C./(1+x).^5 - ...
    5*(C+N)./(1+x).^6;

a=0;
b=1;
tol = 1e-10;
st_korakov = ceil(log2((b-a)/tol));

[xb,Xb] = bisekcija(f,0,1,st_korakov);
[xt,Xt,kt] = tangentna(f,df,0,1e-15,100);
[xs,Xs,ks] = sekantna(f,0,1,1e-15,100);

% Xs', če želimo izpis v stolpcu.

x = fzero(f,0); 
% Vgrajena metoda ki pri računanju ničle kombinira biskecijo, sekantno metodo in inverzno
% kvadratično interpolacijo.