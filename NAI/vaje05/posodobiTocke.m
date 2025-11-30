function Enew = posodobiTocke(r, E, xNew)
% posodobiTocke - Korak (c) prvega Remezovega postopka
%
% Uporaba:
%   Enew = posodobiTocke(r, E, xNew)
%
% Vhodni parametri:
%   r    - residual r(x) = f(x) - p(x)
%   E    - urejen seznam dolžine n+2, na katerem r alternirajoče menja predznak
%   xNew - nova točka, kjer ima |r(x)| (približno) maksimum
%
% Izhodni parameter:
%   Enew - nov urejen seznam dolžine n+2, ki vsebuje xNew (če prej ni bil)
%          in na katerem r spet alternirajoče menja predznak

% Zagotovimo vrstico in urejenost
E = sort(E(:).');

% Unija starih točk in nove točke
Z = sort([E, xNew]);
L = numel(Z);  % L = n+3

% Residual na vseh točkah
rZ = r(Z);

% Indeks xNew v Z (po urejanju; numerika -> vzamemo najbližjo)
[~, idxNew] = min(abs(Z - xNew));

% Je xNew že bil v E?
hadNewBefore = any(abs(E - xNew) < 1e-12);

% Poizkusimo odstranit vsako od L točk (razen xNew, če prej ni bil v E)
for j = 1:L
    % Če xNew ni bil v E, ga ne smemo odstraniti
    if ~hadNewBefore && (j == idxNew)
        continue;
    end
    
    Ecand = Z;
    Ecand(j) = [];  % odstranimo eno točko -> dolžina n+2
    
    if preveriAlternacijo(r, Ecand)
        Enew = Ecand;
        return;
    end
end

% Če res nič ne uspe (teoretično ne bi smelo), vrnemo staro E
warning('posodobiTocke: alternirajoč niz ni najden, E ostane nespremenjen.');
Enew = E;

end

function ok = preveriAlternacijo(r, xList)
% Preveri, ali vrednosti r alternirajoče spreminjajo predznak
    v = r(xList);
    s = sign(v);
    s(s == 0) = 1;  % če je natančno 0, vzemi +1
    ok = all(s(1:end-1) .* s(2:end) < 0);
end
