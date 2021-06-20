function [y_vec, t_vec] = RungeKutta4(g,t_1,t_2,y_ini,N)
%Klassisches Runge-Kutta-Verfahren 4. Ordnung
%   Beschreibung der Variablen:
    % y_vec = Vektor mit y-Werten zu den Zeiten t_vec
    % t_vec = Vektor mit allen Zeitschritten
    % g     = Funktionshandle
    % t_1   = Startzeit
    % t_2   = Endzeit
    % y_ini = y-Startwert zur Zeit t_1 (Anfangsbedingung)
    % N     = Anzahl an Zeitschritten
t_vec = zeros(N+1,1)    ;
y_vec = zeros(N+1,1)    ;
%%
h = (t_2-t_1)/N     ; % Berechnung der Zeitschrittweite
t_vec(1) = t_1          ;
y_vec(1) = y_ini        ;

% Iteration über die Anzahl der Zeitschritte
for i = 1:N
    
    % Eintragen der bereits bekannten Werte für y und t in den
    % Lösungsvektor
    %y_vec(i) =y(i)      ; % Eintragen des Funktionswerts in den Lösungsvektor
    %t_vec(i) =t(i)      ; % Eintragen des Zeitpunkts in den Lösungsvektor
    
    % Berechnung der nächsten Werte für y und t:
    k_RK = RungeKutta4Step(g,y_vec(i),h,t_vec(i));      
    y_vec(i+1) = y_vec(i)+k_RK  ; % Berechnung des neuen Funktionswertes
    t_vec(i+1) = t_vec(i)+h    ; % Berechnung des nächsten Zeitpunkts für die folgende Iteration
end

