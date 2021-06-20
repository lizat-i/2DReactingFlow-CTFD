function alpha=GetAlpha_Zylinder(T,T_inf,D)
    % Zur Bestimmung von alpha: Freie Konvektion an Zylinder (Polifke S. 240)
    % Luft bei ca. 25°C
    eta     = 17.1e-6;   % [Pa s]
    rho     = 1.184;     % [kg/m^3]
    c       = 1005;      % [J/(kg K)] 
    lambda  = 0.026;     % [W/(m K)]
    g       = 9.81;      % [m/s^2]
    
    ny      = eta/rho;
    a       = lambda/(rho*c);
    beta    = 1/T;
    
    Ra      = g*beta*abs(T-T_inf)*D^3/(ny*a);
    Pr      = ny/a;
    f_Pr    = (1+(2*Pr)^(-9/16))^(-4/9);
    Nu      = 0.36 + 0.668*0.8*f_Pr*Ra^0.25;

    alpha   = Nu*lambda/D;
end