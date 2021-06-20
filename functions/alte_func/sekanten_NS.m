function [x_out,n] = sekanten_NS(f,x1,x2,varargin)
%% Funktion zur numerischen Nullstellensuche mit dem Sekanten-Verfahrens 
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
n  = 0       ;
AK = 0       ;
 
while (AK~=1)
    
	% Neubelegung der Funktionswerte
    y1      = f(x1)     ;
    y2      = f(x2)     ;
  
	
	
	
    x3      =    x1 - y1*((x2-x1)/(y2 - y1))    ;		; % Schnttpunkt der Sekante mit der Funktion	
    n       =    n +1                                  	; % Anzahl der Iterationen  
    x1      =    x2                                    	; % Neubelegung der x-Werte
    x2      =    x3                  					; % Neubelegung der x-Werte			
   
   %  Abbruchkritererien   
   
    if n>  max_iter 
        disp('Anzahl der Maximal zulässigen Iterationen überschritten')
        break;
    end
    AK = (abs(f(x3))   >eps1 ) && (abs(x1-x2)>eps2) ;    %  Abbruchkritererien  
end
x_out = x3;

