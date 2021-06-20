function [y_vec,t_vec] = EulerEx(g,t_1,t_2,y_ini,N)
%Explizites Euler Verfahren
%   y_vec = y-Werte zu den Zeiten t_vec
%   t_vec = Zeitschritte (alle in einem Vektor)
%   g     = Funktionshandle
%   t_1   = Startzeit
%   t_2   = Endzeit
%   y_ini = y_Startwert zur Zeit t_1 (Anfangsbedingung)
%   N     = Anzahl an Zeitschritten

%% Initialisierung
h = (t_2 - t_1) / N             ; % Berechnung des Zeitschritts
t_vec = transpose([t_1:h:t_2])  ; % Erstellen des Zeitvektors
y_vec = zeros(N+1,1)            ; % Initialisieren des Lösungsvektors
y_vec(1) = y_ini                ; % Initialisieren des ersten Eintrags: y-Startwert zur Zeit t_1


%% Algorithmus zum expliziten Eulerverfahren
    for n = 1:N
        y_vec(n+1) = y_vec(n) + g(y_vec(n))*h;
    end




end

