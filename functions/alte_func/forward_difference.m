function df_dx = forward_difference(x_vec,f_x)
%Funktion zur numerischen Differentiation mittels Vorwärtsdifferenz 
% Variablen von Input und Output:
%   x_vec = Vektor mit den x-Koordinaten der (gegebenen) Messpunkte
%   f_x   = Vektor mit den y-Koordinaten der (gegebenen) Messpunkte
%   df_dx = Numerische Ableitung mittels Vorwärtsdifferenz 
 
df_dx    =  (f_x(2:end)-f_x(1:end-1))./(x_vec(2:end)-x_vec(1:end-1))   ;    % Berrechnung der Vorwärtsdifferenz 
df_dx    =   [df_dx(:);nan]                                            ;     
end