l = -2;
r = 2;
a = 1/(2.60);
f = @(x) (8.*a.^3) ./ (x.^2 + 4.*a.^2);

%% 1
x = linspace(l,r,3);
p = polyfit(x,f(x),2);

res1 = polyval(p,1);

%% 2 (Deljene diference)
% x = linspace(l,r,5);
% n = length(x);
% b = zeros(n,n);
% b(:,1) = f(x);
% 
% for j = 2:n
%     for i = 1:n-j+1
%         b(i,j) = (b(i+1,j-1) - b(i,j-1)) / (x(i+j-1) - x(i));
%     end
% end
% 
% res2 = b(1,n);

x = linspace(l,r,5);
d = deljeneDif(x,f(x));

res2 = d(5);

%% 3 (Horner)
% xx = linspace(l,r,100);
% xt = 1;
% y = b(1,1);
% for j = 1:n-1
%     xt = xt.*(xx-x(j));
%     y = y + b(1,j+1).*xt;
% end
% 
% res3 = mean(y);

res3 = mean(horner_alg(x,d,linspace(l,r,100)));
    
%% 4 (Hermitska interpolacija)
x = [-2,-1,0,1,2];
df = @(x) - (16.*a.^3.*x) / (x.^2 + 4.*a.^2).^2;
xx = 1.5;

[d,s] = hermit(x,f,df,xx);

res4 = s;