function alpha=GetAlpha_platte_Erzwungen(u_infty,L)
    % Zur Bestimmung von alpha: Laengs angestroemte ebene Platte (Polifke S. 189)
    % Luft bei ca. 5°C, laminar
    eta     = 17.47e-6;   % [Pa s]
    rho     = 1.269;     % [kg/m^3]
    c       = 1006;      % [J/(kg K)] 
    lambda  = 0.024;     % [W/(m K)]
    
    g       = 9.81;      % [m/s^2]
    
    ny      = eta./rho;
    a       = lambda./(rho.*c);
    
    % Tabelle f(PR):
    f_Pr_tab = [0.72,0.91,0.99,1,1.012,1.027,1.058];
    Pr_tab = [0.01,0.1,0.7,1,10,100,1000];

    Pr      = ny./a;
    % lineare Interpolation in der Tabelle f(PR)
    f_Pr    = interp1(Pr_tab,f_Pr_tab,Pr);
    
    Re_L    = u_infty .* L ./ ny;
    Nu_L    = 0.664 .* Re_L.^0.5 .* Pr.^(1./3) .* f_Pr;

    alpha   = Nu_L.*lambda./L;
end