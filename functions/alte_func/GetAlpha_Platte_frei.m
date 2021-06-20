function alpha=GetAlpha_Platte_frei(T,T_inf,H)
    % Zur Bestimmung von alpha: Freie Konvektion an senkrechter Platte (Polifke S. 240)
    % Luft bei ca. 5°C, laminar
    eta     = 17.47e-6;   % [Pa s]
    rho     = 1.269;     % [kg/m^3]
    c       = 1006;      % [J/(kg K)] 
    lambda  = 0.024;     % [W/(m K)]
    g       = 9.81;      % [m/s^2]
    
    ny      = eta./rho;
    a       = lambda./(rho.*c);
    beta    = 1./T;
    
    Ra      = g.*beta.*abs(T-T_inf).*H.^3./(ny.*a);
    Pr      = ny./a;
    f_Pr    = (1+(2.*Pr).^(-9./16)).^(-4./9);
    Nu      = 0.68 + 0.668.*1.*f_Pr.*Ra.^0.25;

    alpha   = Nu.*lambda./H;
end