function [x_out,n] = bisektionsverfahren(varargin)
%% Funktion zur numerischen Nullstellenberechnung nach dem Bisektionsverfahren 
% Variablen von Input und Output:
%   f     = function handle
%   x1,x2 = Startwerte
%   xout  = Nullstellen
%   n     = Anzahl der Iterationen
% optionaler Input:
%   eps 1  = grenzwert
%   eps 2  = grenzwert
%   n_max  = max_Iterationen

%% Überprüfung des Inputs
if nargin < 3; error('Zu wenig Inputs');end
% default Werte setzen
if nargin < 4 || isempty(varargin{4}) , varargin{4}= 1e-6 ;end
if nargin < 5 || isempty(varargin{5}) , varargin{5}= 1e-6 ;end
if nargin < 6 || isempty(varargin{6}) , varargin{6}= 1e3   ;end

% Variablen zuordnen:
f           = varargin{1};
x1          = varargin{2};
x2          = varargin{3};
eps1        = varargin{4};
eps2        = varargin{5};
n_max       = varargin{6};

% Initialisieren der Werte:

n = 0                       ; % Anzahl der bisher durchgeführten Iterationen
Abbruchkriterium = 0        ; % Abbruchkriterium initialisiert als FALSE

    while (n < n_max && Abbruchkriterium == 0)    % Überprüfung, ob das Abbruchkriterium TRUE ist
        

        x_neu = x1 + ((x2) - (x1)) / 2          ; % Berechnung des neuen x-Wertes zwischen den beiden Startwerten  
        
        
        
        if (( abs(x_neu-x1)< eps1 ) && ( abs(f(x_neu)) < eps2 ))
            Abbruchkriterium = 1                ;
        end
        
        
        
        if sign(f(x_neu).*f(x1)) > 0               % Überprüfung, ob sich das Vorzeichen des Funktionswertes seit der letzten Iteration geändert hat
            % Kein Vorzeichenwechsel seit der letzten Iteration:
            x1 = x_neu                          ;
            x2 = x2                             ;
        else                                      
            % Vorzeichenwechsel seit der letzten Iteration:
            x1 = x1                             ;
            x2 = x_neu                          ;
        end
                              
        x_out = x_neu                           ; % Ausgabe von x_neu als gefundene Nullstelle, sobald das Abbruchkriterium erreicht ist
                
        
        n = n+1                                 ; % Hochzählen des Iterationscounters
        
    end     % Ende der While-Schleife
        
end