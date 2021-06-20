function f_x1 = LinInterpolation(x_vec,f_x,x1)
%UNTITLED Funktion zur linearen Interpolation zwischen Datenpunkten
% Variablen von Input und Output:
%   x_vec = Vektor mit den x-Koordinaten der (gegebenen) Messpunkte
%   f_x   = Vektor mit den y-Koordinaten der (gegebenen) Messpunkte
%   x1    = Stelle, an der Interpoliert werden soll
%   f_x1  = Interpolierter y-Wert an der Stelle gewünschten Stelle x1


% Breakout-Kriterium, falls der gewünschte x-Wert außerhalb der Messpunkte
% liegt (sonst würde es sich um Extrapolation handeln):
if any((x1>max(x_vec))| (x1<min(x_vec))), error('x1 ist außerhalb des zuläßigen Werteberreichs'),end
   

% Code zum finden der Benachbarten Werte aus der Matlabhilfe
% https://de.mathworks.com/matlabcentral/answers/38092-how-to-find-the-two-nearest-values-related-to-a-constant#comment_539409

    f_x1 = nan(size(x1))              ;
    
            for i = 1 : length(x1)                                          % Länge der Schleife entsprechend der Anzahl der gewünschten Interpolationsstellen
            d=abs(x1(i)-x_vec);                                             % Berechnung des Abstandes zwischen gewünschter Interpolationsstelle und benachbarten Messtellen
                if(d(1) == d(2))                                            % Absicherung für den Fall, dass der gewünschte Wert gleich einer Messtelle ist
                  vals          = find(abs(x1(i)-x_vec)==d(1))      ;
                  lowest        = vals(1)                           ;       % linker Nachbar der gewünschten Stelle
                  second_lowest = vals(2)                           ;       % rechter Nachbar der gewünschten Stelle
                else
                  d             =   sort(abs(x1(i)-x_vec))          ;   
                  lowest        =   find(abs(x1(i)-x_vec)==d(1))    ;       % linker Nachbar der gewünschten Stelle
                  sec_lowest    =   find(abs(x1(i)-x_vec)==d(2))    ;       % rechter Nachbar der gewünschten Stelle
                end
         
                f_x1(i)    =  f_x(lowest) + ((f_x(sec_lowest)-f_x(lowest))/((x_vec(sec_lowest)-x_vec(lowest))))*(x1(i)-x_vec(lowest));  % Formel der linearen Interpolation aus dem GNTFD-Skript
            end
end

