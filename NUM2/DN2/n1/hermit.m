function [d,s] = hermit(x,f,df, xx)
% Hermitksa interpolacija za odvode.
% x so točke interpolacije; x = [-2,-1,0,1,2]
% f so vrednosti interpolacijskih točk
% df pa njenih odvodov. Če odvod ni podan vnesemo Inf.
% xx je točka v kateri izračunamo vrednost intepolacijskega polinoma.

n = length(x)-1;
q = zeros(2*n+2,2*n+2);

for i = 0:n      
  q(2*i+1,1) = f(x(i+1));
  q(2*i+2,2) = df(x(i+1));
end            
 
z = zeros(1,2*n+2);
for i = 0:n
   z(2*i+1) = x(i+1);
   z(2*i+2) = x(i+1);
   q(2*i+2,1) = q(2*i+1,1);
   if i ~= 0 
      q(2*i+1,2) = (q(2*i+1,1)-q(2*i,1))/(z(2*i+1)-z(2*i));
   end
end
k = 2*n+1;
for i = 2:k
   for j = 2:i
      q(i+1,j+1) = (q(i+1,j)-q(i,j))/(z(i+1)-z(i-j+1));
   end
end
d = diag(q);
s = q(k+1,k+1)*(xx-z(k));
for i = 2:k
   j = k-i+1;
   s = (s+q(j+1,j+1))*(xx-z(j));
end
s = s + q(1,1);
