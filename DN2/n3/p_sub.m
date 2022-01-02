function [y] = p_sub(L,b)
% Izvede premo substitucijo

n = size(L,1);
y = b;
for i = 2:n
    for k = 1:i-1
        y(i) = y(i) - y(k)*L(i,k);
    end
end