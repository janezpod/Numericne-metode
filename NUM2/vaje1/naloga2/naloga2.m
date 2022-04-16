f = @(x) x.^3-2*x+4;
g = @(x) cos(x);
a = -1;
b = 3;

%(a)
f_inf = diskNeskNorma(f, a, b, 10)
g_inf = diskNeskNorma(g, a, b, 10)

%(b)
f_zv2 = zv2norma(f,a,b)
g_zv2 =  zv2norma(g,a,b)

%(c)
%diskretni semi-skalarni produkt se priblizuje zveznemu
fg_disk_10 = diskSkalProd(f, g, a, b, 10)
fg_disk_100 = diskSkalProd(f, g, a, b, 100)
fg_disk_1000 = diskSkalProd(f, g, a, b, 1000)
fg_disk_10000 = diskSkalProd(f, g, a, b, 10000)
fg_zv = zvSkalProd(f,g,a,b)

%diskretna 2 semi-norma se priblizuje zvezni 2 normi
g_disk2_100 = disk2norma(g,a,b,100)
g_disk2_1000 = disk2norma(g,a,b,1000)
g_disk2_10000 = disk2norma(g,a,b,10000)
g_zv2 =  zv2norma(g,a,b)
