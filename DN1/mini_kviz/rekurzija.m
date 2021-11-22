b = 4/23;
y = zeros(1,15);
y(1) = 1;
y(2) = 1;

for i = 3:15
    y(i) = y(i-1) + y(i-2)^(-1);
end


v = (y(15) + b)^(-1);

a1 = 1;
a2 = 1;
i = 2;

while a2 < 10
    c = a2 + a1^(-1);
    a1 = a2;
    a2 = c;
    i = i + 1;
end