% parametri
b = 3; t = 4; L = -4; U = 4;
% mantise
c = 0:b-1;
M = zeros(b^t,1);
i = 1;
for c1 = c
    for c2 = c
        for c3 = c
            for c4 = c
                M(i) = (b.^ -(1:t))*[c1; c2; c3; c4]; 
                % ce se spremeni t se spremeni velikost matrike
                i = i+1;
            end
        end
    end
end
% normalizirana števila
d = U-L+1;
bm = b^(t-1);
Xpn = zeros ((b-1)*bm , d);
for i = 0:d-1
    Xpn(:,i+1) = M(bm+1:end) * b^(L+i);
end
Xpn = Xpn(:);
Xn = [-Xpn(end: -1:1); Xpn];
% denormalizirana števila
Xpd = M(2:bm) * b^L;
Xd = [-Xpd(end: -1:1); Xpd];
% predstavljiva števila (brez 0, Inf , -Inf in NaN)
X = [Xn(1:end /2); Xd(1:end/2); Xpd; Xpn];

% 1. Kolikšen je delež denormaliziranih števil?
delez = length(Xd) / length(X);

% 2. Koliko normaliziranih števil je manjših od π?
manjsa_od_pi = Xn(logical(Xn < pi));
koliko_manjsih_od_pi = length(manjsa_od_pi);

vsota = sum(Xn < pi);

% DN koliko jih je manjsih od e - exp(1)

vsota_e = sum(Xn < exp(1));

% 3. Kakšen je povprečni razmik med zaporednimi predstavljivimi števili,
% ki se od π absolutno razlikujejo za manj kot 1?

manjsa_abs_pi = X(logical(abs(X - pi) < 1));
skupni_razmik = 0;
 
 for i = 1:(length(manjsa_abs_pi) - 1)
     zap_razmik = abs(manjsa_abs_pi(i) - manjsa_abs_pi(i + 1));
     skupni_razmik = skupni_razmik + zap_razmik;
 end
povp_razmik1 = skupni_razmik / (length(manjsa_abs_pi) - 1);

povp_razmik2 = mean(diff(manjsa_abs_pi));

% DN Kakšen je povprečni razmik med zaporednimi predstavljivimi stevili, ki
% se od e absolutno razlikujejo za manj kot 1

manjsa_abs_pi = X(logical(abs(X - exp(1)) < 1));
povp_razmik_e = mean(diff(manjsa_abs_e));

% 4. Katero je največje število v množici P(5,3,−5,5), ki je manjše od π,
% in katero je najmanjše število, ki je večje od π?
% Katero izmed teh dveh števil je fl(π)?
najvecje = max(manjsa_od_pi);
vecja_od_pi = Xn(logical(Xn > pi));
najmanjse = min(vecja_od_pi);

if (pi - najvecje) < (najmanjse - pi)
    flpi = najvecje;
else
    flpi = najmanjse;
end

% Katero stevilo v P je fl(e)?

vecja_od_e = Xn(logical(Xn > exp(1)));
manjsa_od_e = Xn(logical(Xn < exp(1)));
max_e = max(manjsa_od_e);
min_e = min(vecja_od_e);

if (exp(1) - max_e) < (min_e - exp(1))
    fle = max_e;
else
    fle = min_e;
end