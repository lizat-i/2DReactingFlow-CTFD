function [y_vec,t_vec,h,error]=RungeKutta45_adaptive(g,t_1,t_2,y_ini,varargin)
% g = g(t,y)

if nargin < 5 || isempty(varargin{1}) , varargin{1}= 1e-6 ;end
if nargin < 6 || isempty(varargin{2}) , varargin{2}= 1e-6 ;end


%% Definieren der Variablen

eps_a        = varargin{1};
eps_r        = varargin{2};
S 		= 	 0.9	 ; %% Noch Ausstehend

% Initialisieren der Vektoren

t_vec 				= nan(500,1      ) 		;
y_vec 				= nan(size(t_vec))  		;
 
verlaengerungsArray = nan( 500,1     )		;

% Allokation

t_vec(1) = t_1 		;
y_vec(1) = y_ini 	;

%

h       		= 50 	;
error   		= 50 	;

%loop über die Zeit

i       =   1 ;

% Integrationsschleife, läuft bis t == t2
while t_vec(i)<t_2
    
    error_max 		= 	eps_r*abs(y_vec(i)) + eps_a                   ;
    [krk,error]     = 	RungeKutta45Step(g,y_vec(i),h,t_vec(i)) 	;

    %% automatisierte Zeitschrittanpassung 			;

    while error  > error_max
        h_neu 		= 	S*((error_max/error)^(1/5))*h 			;
        
        h    		= 	min(h_neu,	5*h		) 					;
        h    		= 	max(h_neu,	0.1*h	)					;
        [krk,error] 	= 	RungeKutta45Step(g,y_vec(i),h ,t_vec(i)) 			;
    end
 
    y_vec(i+1) =    y_vec(i ) + krk ; 	
    t_vec(i+1) = 	t_vec(i ) + h 	;
    i = i + 1 						;
    
    %% Verlängerung der Arrays falls nötig ;
    
    if numel(t_vec) < i
        t_vec 	= vertcat(t_vec, verlaengerungsArray) 		;
        y_vec 	= vertcat(y_vec, verlaengerungsArray)   	;
        h 		= vertcat(h	   , verlaengerungsArray) 		;
        error	= vertcat(error, verlaengerungsArray) 		;
    end
    
 
end
%% Letzte Iteration anpassen ;

if 	t_vec(i)>t_2
    
    differenz 		= 	t_2-t_vec(i ) 									;
    [krk,error] 	= 	RungeKutta45Step(g,y_vec(i-1),differenz,t_vec(i)) ;
    
    h          =  differenz 			;
    y_vec(i+1) =  y_vec(i) + krk  ;
    t_vec(i+1) = 	t_vec(i) + h 	;
end

%% Kürzen der Arrays aufs notwendige
% dummy = nan ; 
 
y_vec    =  y_vec(~isnan(y_vec))            ;
t_vec    = 	t_vec(~isnan(t_vec))            ;


end


function [k_rk,error]=RungeKutta45Step(g,y,h,t)
%% Butcher Tableau für die Cash-Karp-Methode (ähnlich Fehlberg)
c_vec   = [0,0.2,3/10,3/5,1,7/8].';
a_mat   = [zeros(1,6); 0.2,zeros(1,5); 3/40,9/40,zeros(1,4); 3/10,-9/10,6/5,zeros(1,3); -11/54,5/2,-70/27,35/27,0,0; 1631/55296,175/512,575/13824,44275/110592,253/4096,0];
b_vec5  = [37/378,0,250/621,125/594,0,512/1771];
b_vec4  = [2825/27648,0,18575/48384,13525/55296,277/14336,1/4];
 
%% Berechnung der k-Werte

k_vec = zeros(size(a_mat,1),1); % Initialisierung eines leeren Vektors

% Iterieren über die 4 Teilschritte des klassischen Runge-Kutta-Verfahrens

for u = 1:6   
    k(u) = h*g( t+c_vec(u)*h, y+ a_mat(u,:)*k_vec)          ;
    k_vec(u) = k(u)                                         ;   
end

k_RK4 =  (k_vec.')*b_vec4.'								;	
k_RK5 =  (k_vec.')*b_vec5.'			                            ;	

%% Bestimmung des Runge-Kutta-Schrits dy und des Fehlers error

k_rk   	= k_RK5 													;	% erster K-Wert
error  	= abs( k_RK4 - k_RK5) 										;	% alle folgendenen k-Werte

end