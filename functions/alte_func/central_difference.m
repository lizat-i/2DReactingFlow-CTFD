function df_dx = central_difference(x_vec,f_x)
%Funktion zur numerischen Differentiation mittels zentraler Differenz 
% Variablen von Input und Output:
%   x_vec = Vektor mit den x-Koordinaten der (gegebenen) Messpunkte
%   f_x   = Vektor mit den y-Koordinaten der (gegebenen) Messpunkte
%   df_dx = Numerische Ableitung mittels zentrale Differenz 

df_dx    =  (f_x(3:end)-f_x(1:end-2))./(x_vec(3:end)-x_vec(1:end-2))    ; % Berrechnung der zentralen Differenzen
df_dx    =   [nan; df_dx(:) ; nan]                                      ;

end

