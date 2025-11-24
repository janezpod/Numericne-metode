%% Aproksimacija funkcij - Primer 1 in Primer 2
% Skripta izračuna in izpiše aproksimacije dveh testnih funkcij

clear; close all; clc;
format long;

%% ========================================================================
%  PRIMER 1: Aproksimacija funkcije @(x)cos(2*x)
%  ========================================================================

fprintf('Aproksimacija funkcij\n\n');
fprintf('Primer 1: Aproksimacija funkcije @(x)cos(2*x)\n\n');

% Definicija funkcije 1
f1 = @(x) cos(2*x);
F1 = @(x) sin(2*x) / 2;  % primitivna funkcija

% Interval
a = -1;
b = 1;

% Točke za izpis vrednosti
x_vrednosti = linspace(-1, 1, 11);

% Točke za izračun napak
x_napake = linspace(-1, 1, 201);

% Parametri n za izpis vrednosti aproksimacij
n_vrednosti = [2, 4, 6, 8];

% Parametri n za izračun napak aproksimacij
n_napake = 2:2:20;

%% Izpis vrednosti aproksimacij v točkah

fprintf('Vrednosti aproksimacij v tockah linspace(-1,1,11):\n\n');

% Bernsteinova aproksimacija
fprintf('Bernsteinova aproksimacija:\n');
for n = n_vrednosti
    y = bernsteinovaAproksimacija(f1, a, b, n, x_vrednosti);
    fprintf('n = %d: ', n);
    fprintf('%15.10f ', y);
    fprintf('\n');
end
fprintf('\n');

% Kantorovičeva aproksimacija
fprintf('Kantoroviceva aproksimacija:\n');
for n = n_vrednosti
    y = kantorovicevaAproksimacija(F1, a, b, n, x_vrednosti);
    fprintf('n = %d: ', n);
    fprintf('%15.10f ', y);
    fprintf('\n');
end
fprintf('\n');

% Odsekoma linearna aproksimacija
fprintf('Odsekoma linearna aproksimacija:\n');
for n = n_vrednosti
    y = odsekomaLinearnaAproksimacija(f1, a, b, n, x_vrednosti);
    fprintf('n = %d: ', n);
    fprintf('%15.10f ', y);
    fprintf('\n');
end
fprintf('\n');

%% Ocene napak v enakomerni normi

fprintf('Ocene za napake v enakomerni normi (maksimalne absolutne napake v tockah linspace(-1,1,201)):\n');

% Točne vrednosti
y_exact = f1(x_napake);

% Shranjevanje napak
errors_bern = zeros(1, length(n_napake));
errors_kant = zeros(1, length(n_napake));
errors_pwlin = zeros(1, length(n_napake));

% Izračun napak
for i = 1:length(n_napake)
    n = n_napake(i);
    
    y_bern = bernsteinovaAproksimacija(f1, a, b, n, x_napake);
    errors_bern(i) = max(abs(y_bern - y_exact));
    
    y_kant = kantorovicevaAproksimacija(F1, a, b, n, x_napake);
    errors_kant(i) = max(abs(y_kant - y_exact));
    
    y_pwlin = odsekomaLinearnaAproksimacija(f1, a, b, n, x_napake);
    errors_pwlin(i) = max(abs(y_pwlin - y_exact));
end

% Izpis napak
fprintf('%-37s ', 'n');
for n = n_napake
    fprintf('%-14d', n);
end
fprintf('\n');

fprintf('%-37s ', 'Bernsteinova aproksimacija:');
for i = 1:length(n_napake)
    fprintf('%-14.10f', errors_bern(i));
end
fprintf('\n');

fprintf('%-37s ', 'Kantoroviceva aproksimacija:');
for i = 1:length(n_napake)
    fprintf('%-14.10f', errors_kant(i));
end
fprintf('\n');

fprintf('%-37s ', 'Odsekoma linearna aproksimacija:');
for i = 1:length(n_napake)
    fprintf('%-14.10f', errors_pwlin(i));
end
fprintf('\n');

%% ========================================================================
%  PRIMER 2: Aproksimacija funkcije @(x) abs(x).*cos(x.^2)
%  ========================================================================

fprintf('\n\n');
fprintf('Primer 2: Aproksimacija funkcije @(x) abs(x).*cos(x.^2)\n\n');

% Definicija funkcije 2
f2 = @(x) abs(x) .* cos(x.^2);

% Primitivna funkcija
F2 = @(x) (x .* sin(x.^2)) ./ (2 * abs(x));

% Ostale spremenljivke so iste (a, b, x_vrednosti, x_napake, n_vrednosti, n_napake)

%% Izpis vrednosti aproksimacij v točkah

fprintf('Vrednosti aproksimacij v tockah linspace(-1,1,11):\n\n');

% Bernsteinova aproksimacija
fprintf('Bernsteinova aproksimacija:\n');
for n = n_vrednosti
    y = bernsteinovaAproksimacija(f2, a, b, n, x_vrednosti);
    fprintf('n = %d: ', n);
    fprintf('%15.10f ', y);
    fprintf('\n');
end
fprintf('\n');

% Kantorovičeva aproksimacija
fprintf('Kantoroviceva aproksimacija:\n');
for n = n_vrednosti
    y = kantorovicevaAproksimacija(F2, a, b, n, x_vrednosti);
    fprintf('n = %d: ', n);
    fprintf('%15.10f ', y);
    fprintf('\n');
end
fprintf('\n');

% Odsekoma linearna aproksimacija
fprintf('Odsekoma linearna aproksimacija:\n');
for n = n_vrednosti
    y = odsekomaLinearnaAproksimacija(f2, a, b, n, x_vrednosti);
    fprintf('n = %d: ', n);
    fprintf('%15.10f ', y);
    fprintf('\n');
end
fprintf('\n');

%% Ocene napak v enakomerni normi

fprintf('Ocene za napake v enakomerni normi (maksimalne absolutne napake v tockah linspace(-1,1,201)):\n');

% Točne vrednosti
y_exact = f2(x_napake);

% Shranjevanje napak
errors_bern = zeros(1, length(n_napake));
errors_kant = zeros(1, length(n_napake));
errors_pwlin = zeros(1, length(n_napake));

% Izračun napak
for i = 1:length(n_napake)
    n = n_napake(i);
    
    y_bern = bernsteinovaAproksimacija(f2, a, b, n, x_napake);
    errors_bern(i) = max(abs(y_bern - y_exact));
    
    y_kant = kantorovicevaAproksimacija(F2, a, b, n, x_napake);
    errors_kant(i) = max(abs(y_kant - y_exact));
    
    y_pwlin = odsekomaLinearnaAproksimacija(f2, a, b, n, x_napake);
    errors_pwlin(i) = max(abs(y_pwlin - y_exact));
end

% Izpis napak
fprintf('%-37s ', 'n');
for n = n_napake
    fprintf('%-14d', n);
end
fprintf('\n');

fprintf('%-37s ', 'Bernsteinova aproksimacija:');
for i = 1:length(n_napake)
    fprintf('%-14.10f', errors_bern(i));
end
fprintf('\n');

fprintf('%-37s ', 'Kantoroviceva aproksimacija:');
for i = 1:length(n_napake)
    fprintf('%-14.10f', errors_kant(i));
end
fprintf('\n');

fprintf('%-37s ', 'Odsekoma linearna aproksimacija:');
for i = 1:length(n_napake)
    fprintf('%-14.10f', errors_pwlin(i));
end
fprintf('\n');

%% Konec
fprintf('\n');