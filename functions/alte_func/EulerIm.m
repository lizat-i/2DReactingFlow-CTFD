function [y_vec,t_vec] = EulerIm(g,t1,t2,y_ini,N)
%Funktion zur numerischen Integration mittels Gauss-quadratur bis einschließlich 5. Grades 
% Variablen von Input und Output:
%   g           = function handle
%   t_1 t_2     = Start und Endzeit     
%   y_ini       = Startwert zur Zeit t_1 Anfangsbedinung 
%   N           = Anzahl an Zeitschritten

%% Initialization:

stepSize    = (t2-t1)/N             ;
t_vec       = linspace(t1,t2,N)     ;
y_vec       = zeros(numel(t_vec),numel(y_ini))     ;
y_vec(1,:)  = y_ini                 ;
options = optimoptions('fsolve','Display','none'); % optimizationoptions Anzeige ausgeschaltet;


for i = 2 :numel(t_vec)
    
    % funktion welche mittels fsolve gelöst wird, wird hier definiert(ändert sich in jedem Zeitschritt)
    
        func = @(y_nextTimeStep)  y_nextTimeStep -stepSize*g(y_nextTimeStep,t_vec(i))-y_vec(i-1)            ;
        
    % Lösen des nichtlinearen Gleichungsystem mittels fsolve, mit dem   
        y_vec(i,:)  = fsolve(func,y_vec(i-1,:),options); 
        %y_vec(i,:)  = fsolve(func,y_vec(i-1,:));        
end
