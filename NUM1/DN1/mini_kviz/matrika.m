d = 11/7;
A = magic(6);
x = [d, d+1, d+2, d+3, d+4, d+5];

B = A - diag(diag(A) - diag(d));
B(1,6) = B(1,6) + 3;

povprecje = mean(B(2,:));

vsota = sum(sum(B));

y = B*(transpose(x));
dolz = norm(x);
najmanjsi = min(y);
