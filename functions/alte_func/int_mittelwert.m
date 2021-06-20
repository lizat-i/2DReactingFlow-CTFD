function cpm = int_mittelwert(func,T,T0,n)
% Funktion zur Bestimmung der mittleren Wärmekapazität
%   func    = Funktion, die integriert werden soll
%   T       = Temperaturvektor, über den integriert werden soll
%   T0      = Bezugstemperatur
%   n       = Wahl des Integrationsalgorithmus (n kann Werte von 1-4 annehmen)

%%
cpm     =   nan(size(T(:)))         ;

switch n                                                            % Auswahl des Integrationsalgorithmus: Gauß-Quadratur, Matlab-Integrator, Trapez-Regel oder Simpson-Regel
    case 1
        for i = 1 : size(T(:),1)                                    % Gauß-Quadratur
            cpm(i) = Int_Gauss(func,T0,T(i),4)/(T(i)-T0);
        end
    case 2                                                          % Matlab-interner Integrationsalgorithmus
        for i = 1 : size(T(:),1)
            cpm(i) = integral(func,T0,T(i))/(T(i)-T0);
        end
        
    case 3                                                          % Trapez-Regel
        for i = 1 : size(T(:),1)
            cpm(i) = int_trapez(func,T0,T(i))/(T(i)-T0);
        end
        
    case 4                                                          % Simpson-Regel
        for i = 1 : size(T(:),1)
            cpm(i) = int_simpson(func,T0,T(i))/(T(i)-T0);
        end
    otherwise                                                       % Fehlermeldung, falls die eingegebene Zahl keine ganze Zahl zwischen 1 und 4 ist
            error('n muss eine ganze Zahl zwischen 1 und 4 sein !')
end

end

