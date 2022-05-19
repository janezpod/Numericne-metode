f = @(x) cos(5 * 1./(x+1));
df = @(x) 5*sin(5./(1 + x))./(1 + x).^2;

% Parameter za risanje funkcije
x = linspace(0,3,1001);

% primer1: kubicni polinom, kjer premikamo 1 interpolacijsko tocko
figure
plot(x,f(x), 'b', 'LineWidth', 1);
hold on
% Nastavimo fiksne meje za obmocje, ki bo prikazano na sliki (zato, da slika ne skace):
% axis([spodnja_x, zgornja_x, spodnja_y, zgornja_y])
axis([0 3 -2 2])

% Pripravimo si pomozno spremenljivko, ki bo hranila trenutno narisan
% interpolant
temp = [];
% Sprehodimo x2 po intervalu [1/3, 29/10]
for x2 = linspace(1/3,29/10,200)
    %Z risbe izbrisemo prej shranjen graf interpolacijskega polinoma
    delete(temp);
    
    % Koordinate interpolacijskih tock, pri konkretnem x2
    interpX = [0 1/4 x2 3];
    interpY = f(interpX);
    
    % Izracunamo koeficiente interpolacijskega polinoma v Newtonovi obliki
    % (namesto polyfit)
    d = deljeneDif(interpX,interpY);
    % Vrednost interpolanta izracunamo preko prilagojenega Hornerjevega
    % algoritma za Newtonovo obliko (namesto polyval).
    % Graf polinoma shranimo v pomozno spremenljivko, da ga lahko zbrisemo na
    % zacetku naslednje iteracije. Tako dobimo animacijo.
    temp = plot(x,horner_alg(interpX,d,x), 'r', interpX, interpY, 'ro','LineWidth', 1);
    % Po izvedeni zanki naredimo zamik, da se animacija ne izvede prehitro
    pause(.03)
    
end

% primer2: kubicni polinom, kjer premikamo vse 4 interpolacijske tocke
figure
plot(x,f(x), 'b', 'LineWidth', 1);
hold on
axis([0 3 -2 2])

% Sprehodimo x0 po intervalu [0,2]
for x0 = linspace(0,2,200)
    delete(temp);
    
    % Koordinate interpolacijskih tock in vrednosti odvoda pri njih -
    % vzamemo samo 2, ker imamo samo 2 razlicni (temu prilagodimo metodo za
    % deljene diference)
    interpX = [x0 x0+1];
    interpY = f(interpX);
    interpDY = df(interpX);
    
    % Lokalna "spremenljivka" za risanje grafa polinoma
    xLoc = linspace(x0,x0+1);
    
    % Izracunamo koeficiente interpolacijskega polinoma v Newtonovi obliki
    % (namesto polyfit). Tu moramo uporabiti prilagojeno metodo, saj
    % deljeneDif ne funkcionirajo, ce je vec tock enakih.
    d = deljeneDif_P3_2xInterp(interpX,interpY,interpDY);

    % Vrednost interpolanta izracunamo preko prilagojenega Hornerjevega
    % algoritma za Newtonovo obliko (namesto polyval).
    temp = plot(xLoc,horner_alg([x0 x0 x0+1 x0+1],d,xLoc), 'r', interpX, interpY, 'ro','LineWidth', 1);

    % Po izvedeni zanki naredimo zamik, da se animacija ne izvede prehitro
    pause(.03)
    
end
