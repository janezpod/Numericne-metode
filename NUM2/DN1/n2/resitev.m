y = [547         639         916        1399        2062        2863        5494        6070        8124        9783       11871       16607       19693     23680       27409       30553       34075       36778       39790       42306       44327       46050.00       59832       66292       68347       70446      72364       74139       74546       74999      75472.00]/1000+300; 
stockFun_pp = spline(0:30,y); 
F = @(x) ppval(stockFun_pp,x); 
x = linspace(0,30,1001);  
% plot(x,F(x));

%% 1
a = -3.5;
b = 2;
N = 5;
f = @(x) x.^2/5;
g = @(x) exp(x./10);
res1 = diskSkProd(f, g, a, b, N);

%% 2
a = -3.5;
b = 2;
N = 100;
f = @(x) x.^2/5;
g = @(x) exp(x./10);
res2 = diskSkProd(f, g, a, b, N);

%% 3
a = 0;
b = 30;
N = 20;
baza = cell(1,7);
baza{1} = @(x) 1;
baza{2} = @(x) x;
baza{3} = @(x) x.^2;
baza{4} = @(x) cos(x);
baza{5} = @(x) sin(x);
baza{6} = @(x) cos(2.*x);
baza{7} = @(x) sin(2.*x);
baza = ortNormBaza(baza,a,b,N);
res3 = baza{5}(30);

%% 4
a = 0;
b = 30;
N = 100;
baza = ortNormBaza(baza,a,b,N);
koef = aproksimantMNK(F,baza,a,b,N);
res4 = mean(koef);

%% 5
p = @(x) koef(1) * baza{1}(x);
for i = 2 : length(baza)
    p = @(x) p(x) + koef(i) * baza{i}(x);
end
res5 = mean(p(x));
plot(x,F(x))
hold on 
plot(x,p(x))

%% 6
a = 0;
b = 30;
N = 100;
H = @(x) max(1-abs(x),0);
baza = cell(1,7);
for i = 1 : 7
    baza{i} = @(x) H((x - 5 * (i - 1)) / 5);
end
baza = ortNormBaza(baza,a,b,N);
koef = aproksimantMNK(F,baza,a,b,N);
p = @(x) koef(1) * baza{1}(x);
for i = 2 : length(baza)
    p = @(x) p(x) + koef(i) * baza{i}(x);
end
res6 = abs(F(10) - p(10));