T = load("cryptomarket.csv");

A = T(11:20,:);

%%% 1 %%%
norme = norma(A,1) + norma(A,2) + norma(A,'inf') + norma(A,'fro');

%%% 2 %%%
c = [41839;41672;41368;41401;41283;41294;41708;41899;41910;41787];

x = linsolve(A,c);

normax1 = norma(x,1);
normax2 = norm(x,1);

%%% 3 %%%

T = load("cryptomarket.csv");
m = size(T,2); % st kriptovalut oz. stolpcev

n = 1; %stopnja polinoma
A = vander(0:n);

t = zeros(size(T));
t(1:n+1,:) = T(1:n+1,:);
for j = 1:m %zanka po kriptovalutah (oz. stolpcih)
    for i=21 %zanka po urah, kjer napovedujemo vrednosti kriptovalut
        p = A\T(19 : 20 ,j); %reševanje sistema  A * p = T(..)
        t(i,j) = polyval(p,n+1);
    end
end

c = T*x;
c_napovedan = t*x;

% plot(1:24, c, 1:24, c_napovedan)
% legend('Dejanska vrednost', 'Napovedana vrednost')

napaka = c- c_napovedan;

% plot(1:24, abs(napaka))
% legend('Napaka napovedi')

napaka(21)
