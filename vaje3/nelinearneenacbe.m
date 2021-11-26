N = 1000;
C = 50;
P = 1100;
syms k x
F = @(x) symsum(C/((1 + x)^k),k,1,5) + N/((1 + x)^5) - P;
f = @(x) -symsum(k*C/((1 + x)^(k + 1)),k,1,5) - 5 *N/((1 + x) ^ 6);

a = 0;
b = 1;
toleranca = 1e-10; % deset decimalk
st_korakov = ceil(log2((b-a)/toleranca));
[x,X] = bisekcija(F,a,b,st_korakov);
