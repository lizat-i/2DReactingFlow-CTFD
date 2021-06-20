function [A_trapez,i] = int_trapez(f_x,a,b)


%Funktion zur Integartion mit dem Trapezverfahren
%   f_x         = beliebige Funktion
%   a           = linke Integrationsgrenze
%   b           = rechte Integrationsgrenze
%   A_trapez    = Resultierende Fläche unter der Funktion
%   i           = Anzahl der Iterationen

%%
% Definition der Variablen:
i_min       = 5         ;   % Mindestanzahl an Iterationen
i_max       = 20        ;   % Maximale Anzahl an Iterationen
epsilon     = 10^(-6)   ;   % Epsilon: Maximale absolute noch zulässige Änderung zwischen zwei Iterationsschritten

i = 1                   ;   % Initialisierung der Laufvariable     
%%
% Berechnungen:
delta = b - a                           ;   % Iterationsspanne
A_new = (f_x(a) + f_x(b)) / 2 * delta   ;   % Trapezfläche zwischen den Integrationsgrenzen

while i <= i_max                            % Begrenzung der Iterationen

i       = i+1                           ;   % Inkrementieren der Iteration

A_old   = A_new                         ;   
n       = 2^(i - 1)                     ;   % Veränderliche Anzahl an Flächen abhängig vom Iterationsschritt
h       = (b-a) / n                     ;   % Berechnen der neuen Schrittweite


A_new   = 0.5*A_old + h*sum(  f_x(a+h : 2*h : b-h)  )  ;   % Berechnen der neuen Fläche gemäß der Trapezformel (Folie 27, Termin 3)

    if (   (abs(A_new - A_old) < epsilon) && (i >= i_min)   )   %   Abbruchkriterium
        break;
    end


end
%%
% Ausgabe der Funktion
A_trapez = A_new;
i = i;
end

