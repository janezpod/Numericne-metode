a=11;
P = [-22,5,7,a];

koef = poly(P);

vP = polyval(koef, 13/2);

koef_d = polyder(koef);

vp = polyval(koef_d, 13/2);

