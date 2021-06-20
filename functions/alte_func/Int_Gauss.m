function [A] = Int_Gauss(f_x,x_1,x_2,n)
%Funktion zur numerischen Integration mittels Gauss-quadratur bis einschließlich 5. Grades 
% Variablen von Input und Output:
%   f_x   = function handle
%   x_1   = Integrationsgrenzen
%   x_2   = Integrationsgrenzen
%   A     = Integrale Fläche berrechnet mittels Gaus quadratur  
%   n     = Grad des Polynoms (1-5 zuläßig)

%% switch-Abfrage um Gewichte und Gaußpunkte der Gauß Legendre Integration zu extrahieren
switch n
    case 1 
        zi = 0; wi =2;
    case {2,3}
        zi = [ sqrt(1/3);-sqrt(1/3)] ; wi = [1;1];  
    case {5,4}
        zi = [-sqrt(3/5);0;sqrt(3/5)] ; wi = [5/9;8/9;5/9];
    otherwise
        error('not avaible' )
end

F_z =    @(z) f_x(((x_2-x_1)*z+(x_2+x_1))/2)        ; % Transformation der Integrationsgrenzen

A   =    ((x_2 -x_1)/2).*sum((wi.*F_z(zi)),'all')   ; % Integration der transformierten Funktion 
end
