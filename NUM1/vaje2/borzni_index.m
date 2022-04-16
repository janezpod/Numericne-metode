load("marketcap.csv")

% sum(,2) sešteva po vrsticah 
C = sum(marketcap(:,4:end),2); 

n = length(marketcap(:,1));
I = zeros(1,n);
I(1) = 1000;

for d = 2:n
    r = C(d) / C(d-1);
    I(d) = r*I(d-1);
end

plot(1:n,I)
clf;
% postopek z zaokrozevanjem

I_gor = I;
I_dol = I;
I_round = I;

for d = 2:n
    r = (C(d) /C (d-1));
    I(d) = r*I(d-1);
    I_gor(d) = zaokrozi(r,3,"navzgor")*I_gor(d-1);
    I_dol(d) = zaokrozi(r,3,"navzdol")*I_dol(d-1);
    I_round(d) = zaokrozi(r,3)*I_round(d-1);
end

plot(1:n,I)
hold on
plot(1:n,I_gor)
hold on
plot(1:n,I_dol)
hold on
plot(1:n,I_round)
hold off
