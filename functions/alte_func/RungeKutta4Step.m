function [k_RK] = RungeKutta4Step(g,y,h,t)
%Funktion zur Berechnung des Schritts k_RK gemäß des Runge-Kutta-Verfahrens
%4. Ordnung
%   Beschreibung der Variablen:
    % k_RK  = Schritt
    % g     = Funktionshandle
    % y     = aktueller y-Wert
    % h     = Schrittweite
    % t     = Aktuelle Zeit
%% Initialisierung des Butcher Tableaus für Runge-Kutta-Verfahren 4. Ordnung
a_mat = zeros(4)    ; % Platzhalter für Butcher-Tableau für Runge-Kutta-Verfahren 4. Ordnung
a_mat = [0 , 0, 0, 0; 0.5, 0, 0, 0; 0,0.5, 0, 0; 0, 0, 1, 0]    ;
c_vec = [0;0.5;0.5;1]                                           ;
b_vec = [1/6,1/3,1/3,1/6]                                       ;
%% Berechnung des Schrittes k_RK
k_vec = zeros(4,1); % Initialisierung eines leeren Vektors

% Iterieren über die 4 Teilschritte des klassischen Runge-Kutta-Verfahrens
for u = 1:4    

    k(u) = h*g( t+c_vec(u)*h, y+ a_mat(u,:)*k_vec);
    k_vec(u) = k(u);   
end

k_RK = b_vec*k_vec; % Aufsummieren und Gewichten der einzelnen Teilschritte
dummy = nan ; 
end

