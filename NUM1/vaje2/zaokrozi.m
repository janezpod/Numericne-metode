function y = zaokrozi(x,k,nacin)
% funkcija, ki x zaokrozi na k decimalk na izbran nacin

if nargin < 3
    nacin = "";
end

if nacin == "navzgor"
    y = ceil(x*10^k)/10^k;
    
elseif nacin == "navzdol"
    y = floor(x*10^k)/10^k;
    
else
    y = round(x,k);
    
end