%% Definition des Verlaufs der Stromstaerke
Skalierung = 10;
omega = 0.03;
t_start = 700;
t_end = t_start + 3 * 2*pi/omega; 
% t_end = 1500;
I = @(t) ( heaviside(t-t_start)*heaviside(t_end-t)* (-0.5*cos(omega*(t-t_start)) + 0.5 ) + 0.2) * Skalierung;