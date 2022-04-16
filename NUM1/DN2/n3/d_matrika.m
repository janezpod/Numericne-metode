function [A] = d_matrika(A,v,d)
% Zapolni izbrano diagonalo matrike z ustrezno dolgim vektrojem,
% d ~ diagonlo izberemo: 1 prva vrsta nad diagonalo, -1 prva vrsta pod
% diagonalo.

n = size(A,1);
if sign(d) == 1
    for j = 1+d:n
        A(j-d,j) = v(j-d);
    end

elseif sign(d) == -1
    for j = 1:n+d
        A(j-d,j) = v(j);
    end

end