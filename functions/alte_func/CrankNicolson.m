function [y_vec,t_vec] = CrankNicolson(g,t_1,t_2,y_ini,N)
%Implizites Crank Nicolson Verfahren
%   y_vec = y-Werte zu den Zeiten t_vec
%   t_vec = Zeitschritte (alle in einem Vektor)
%   g     = Funktionshandle
%   t_1   = Startzeit
%   t_2   = Endzeit
%   y_ini = y_Startwert zur Zeit t_1 (Anfangsbedingung)
%   N     = Anzahl an Zeitschritten

%% Initialisierung
h = (t_2 - t_1) / N             ; % Berechnung des Zeitschritts
t_vec = [t_1:h:t_2]'            ; % Erstellen des Zeitvektors
y_vec = zeros(N+1,1)            ; % Initialisieren des Lösungsvektors
y_vec(1) = y_ini                ; % Initialisieren des ersten Eintrags: y-Startwert zur Zeit t_1


%% Algorithmus zum Crank Nicolson Verfahren
    for n = 1:N
        y_vec(n+1) = Newton_Neu ( @(T) (T-y_vec(n) - h./2.*(g(y_vec(n)) +g(T))) , y_vec(n)); 
    end




end

