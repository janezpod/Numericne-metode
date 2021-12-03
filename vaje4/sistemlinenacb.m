T = load("cryptomarket.csv");

c = transpose(sum(T,2));

c_1 = norm(c,1);
c_2 = norm(c,2);
c_inf = norm(c,inf);

A = T(1:10,1:10);

A_1 = norm(A,1);
a_1 = norma(A,1);

A_2 = norm(A,2);
a_2 = norma(A,2);

A_inf = norm(A,'inf');
a_inf = norma(A,'inf');

A_fro = norm(A,'fro');
a_fro = norma(A,'fro');

%%%%%%%%%%%%% OCENE %%%%%%%%%%%%%

max_element = max(max(A));

% Spodnje ocene
s1 = 1/sqrt(10) * A_fro;
s2 = 1/sqrt(10) * A_1;
s3 = 1/sqrt(10) * A_inf;
s4 = max_element;

s = [s1 s2 s3 s4];
naj_spo_ocena = max(s);

% Zgornje ocene
z1 = A_fro;
z2 = sqrt(10) * A_1;
z3 = sqrt(10) * A_inf;
z4 = 10 * max_element;
z5 = sqrt(A_1 * A_inf);

z = [z1 z2 z3 z4 z5];
naj_zgo_ocena = min(z);
 
% Ocene veljajo
os = s <= A_2;
oz = A_2 <= z;

K = [0 0 1; 1 1 1; 4 2 1];
koeficenti = zeros(10,3);

for j = 1:10
    z = T(1:3,j);
    koeficenti(j,1:3) = [linsolve(K,z)];
end


