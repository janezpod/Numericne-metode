function d = deljeneDif_P3_2xInterp(X,Y,DY)
% function d = deljeneDif_P3_2xInterp(X,Y,DY)
% Trikotna shema za kubicni polinom za interpolacijske tocke x0=x1<x2=x3.
% X = [x0 x3],    interpolacijske tocke
% Y = [y0 y3],    interpolacija vrednosti
% DY = [dy0 dy3], interpolacija odvodov

% Pripravimo prazno matriko, izpolnimo "na roke", po stoplcih:
M = zeros(4);
M(:,1) = [Y(1);                      Y(1);  Y(2);                        Y(2)];
M(:,2) = [0;                         DY(1); (Y(2)-Y(1))/(X(2)-X(1));     DY(2)];
M(:,3) = [0;                         0;     (M(3,2)-M(2,2))/(X(2)-X(1)); (M(4,2)-M(3,2))/(X(2)-X(1))];
M(4,4) = (M(4,3)-M(3,3))/(X(2)-X(1));
d = diag(M);