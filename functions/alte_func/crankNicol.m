function [y_vec,t_vec] = crankNicol(g,t1,t2,y_ini,No)
%Funktion zur numerischen Integration mittels CrankNicholson
% Variablen von Input und Output:
%   g           = function handle
%   t_1 t_2     = Start und Endzeit     
%   y_ini       = Startwert zur Zeit t_1 Anfangsbedinung 
%   N           = Anzahl an Zeitschritten

%% Initialization:

stepSize    = (t2-t1)/No             ;
t_vec       = linspace(t1,t2,No)     ;
y_vec       = zeros(numel(t_vec),numel(y_ini))     ;
y_vec(1,:)  = y_ini                 ;
options = optimoptions('fsolve','Display','none'); % optimizationoptions Anzeige ausgeschaltet;


for i = 2 :numel(t_vec)    

    dummy = nan ;
    
    % funktion welche mittels fsolve gelöst wird, wird hier definiert(ändert sich in jedem Zeitschritt)
    
        func = @(y_nextTimeStep)  y_nextTimeStep -(stepSize/2)*(g(y_nextTimeStep,t_vec(i))+g(y_vec(i-1),t_vec(i-1)))-y_vec(i-1)            ;            
        
    % Lösen des nichtlinearen Gleichungsystem mittels fsolve, mit dem   
        y_vec(i,:)  = fsolve(func,y_vec(i-1,:),options)                                                       ;       
end
