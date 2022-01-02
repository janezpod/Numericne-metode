function [x,L,U,P] = lusolve(A,b,pivot)
% Opis:
% lusolve izračuna rešitev sistema A*x = b z uporabo LU
% razcepa ter premih in obratnih substitucij
%
% Definicija:
% [x,L,U] = lusolve(A,b)
%
% Vhodna podatka:
% A matrika sistema ,
% b vektor sistema
%
% Izhodni podatki:
% x vektor , ki je rešitev sistema A*x = b,
% L,U matriki iz LU razcepa matrike A

n = size(A,1);

if pivot == 0 %LU razcep brez pivotiranja
    for j = 1:n-1
        for i = j+1:n
            A(i,j) = A(i,j)/A(j,j);
            for k=j+1:n
                A(i,k) = A(i,k) - A(i,j)*A(j,k);
            end
        end
    end
    U = triu(A);
    L = tril(A,-1) + eye(n);

elseif pivot == 1 %LU razcep z delnim pivotiranjem
    p = 1:n; %vektor, kjer si zapomnimo, katere vrstice smo zamenjali
    for j = 1:n-1
        [~,v]=max(abs(A(j:n,j)));
        v = v+j-1;
        A([j v],:) = A([v j],:);
        p([j v]) = p([v j]);

        for i = j+1:n
            A(i,j) = A(i,j)/A(j,j);
            for k=j+1:n
                A(i,k) = A(i,k) - A(i,j)*A(j,k);
            end
        end
    end
    U = triu(A);
    L = tril(A,-1) + eye(n);
    P = eye(n);
    P = P(p,:);
    b = b(p);
end

%Kako postopamo pri reševanju z LU razcepom:
%A = LU; Ax = b; LUx = b; Ly = b; Ux = y

%preme substitucije Ly = b
y = b;
for i = 2:n
    for k = 1:i-1
        y(i) = y(i) - y(k)*L(i,k);
    end
end

%obratna substitucija Ux = y
x = y;
for i = n:-1:1
    for k = n:-1:i+1
        x(i) = x(i) - U(i,k)*x(k);
    end
    x(i) = x(i)/U(i,i);
end

end