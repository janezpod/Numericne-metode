T = load("cryptomarket.csv");
m = size(T,2);

n = 2; %stopnja polinoma
% A = [0 0 1; 1 1 1; 4 2 1];
A = vander(0:n);

t = zeros(size(T));
t(1:n+1,:) = T(1:n+1,:);
for j = 1:m %zanka po kriptovalutah (oz. stolpcih)
    for i=n+2:24 %zanka po urah, kjer napovedujemo vrednosti kriptovalut
        p = A\T(i-n-1 : i-1,j); %reševanje sistema  A * p = T(..)
        t(i,j) = polyval(p,n+1);
    end
end

x = ones(m,1);
c = T*x;
c_napovedan = t*x;

% plot(1:24, c, 1:24, c_napovedan)
% legend('Dejanska vrednost', 'Napovedana vrednost')

plot(1:24, abs(c- c_napovedan))
legend('Napaka napovedi')
