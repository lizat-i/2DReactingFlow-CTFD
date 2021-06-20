function [x_out,n,err] = newton_raphson(f,x1,varargin)
%% Funktion zur numerischen Nullstellensuche mit dem Newton-Raphson-Verfahrens 
% Variablen von Input und Output:
%   f     = function handle
%   x1,x2 = Startwerte
%   xout  = Nullstellen
%   n     = Anzahl der Iterationen
% optionaler Input:
%   eps 1  = grenzwert
%   eps 2  = grenzwert
%   n_max  = max_Iterationen

% default Werte und Variablen zuordnen
if nargin < 4 || isempty(varargin{1}) , varargin{1}= 1e-15 ;end
if nargin < 5 || isempty(varargin{2}) , varargin{2}= 1e-15 ;end
if nargin < 6 || isempty(varargin{3}) , varargin{3}= 1e4   ;end

eps1        = varargin{1};
eps2        = varargin{2};
max_iter    = varargin{3};
 
% Initialisieren der Werte
n       =  0    ;
AK      =  0    ; 
x2      =  x1   ; 
    while (AK~=1)   
			
			% Neubelegung der Variablen 
            x1      = x2        ;
            y1      = f(x1)     ;

            %numerisch die Ableitung mittels zentraler Differenzen Methode berrechnen
            derivative = central_difference(x1.*[0.999, 1, 1.001],f(x1.*[0.999, 1, 1.001]))     ;
            derivative = derivative(~isnan(derivative))                                         ;

            if derivative == 0, error('Ableitung == 0, wähle anderen Startpunkt '), end % Fehlermeldung falls die Ableitung an einem Extrempunkt gebildet werden soll.

            %Gleichungssystem für neuen Funktionswert lösen
            x2 = x1 - (y1/derivative)               ; % Schnttpunkt der Tangente mit der Funktion
            n = n +1                       	 		; % Anzahl der Iterationen  
            y2 = f(x2)                      		; % Initalisierung des neuen Funktionswerts	

            %% Abbruchkriterien

             if n>  max_iter 
				disp('Anzahl der Maximal zulässigen Iterationen überschritten')
				break;
			 end

            AK = (abs(f(x2))   >eps1 ) && (abs(x1-x2)>eps2) ;  %  Abbruchkritererien     
              
    end
x_out = x2;