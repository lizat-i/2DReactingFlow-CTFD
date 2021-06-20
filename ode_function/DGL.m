function [dudt] = DGL(u,input_ode)
%% Funktion zum Erstellen der gewöhnlichen Differentialgleichungen
% Differentialgleichung für die Konzentration jeder Komponente
% Differentialgleichung für die Temperatur

%% Parameter Skript wird ausgeführt
run('Parameter');

N       = input_ode.N           ;
M       = input_ode.M           ;
zustand = input_ode.zustand     ;
reaktion= input_ode.reaktion    ;
% Reaktionsgesetzt
c_PropyleneOxid     = u(1:N*M)             ;
c_Wasser            = u(N*M+1:2*M*N)         ;
c_Methanol          = u(2*N*M+1:3*N*M)       ;
c_PropyleneGlycol   = u(3*N*M+1:4*N*M)       ;
T_Vektor            = u(4*N*M+1:5*N*M)       ;
T0_vec              = ones(size(c_PropyleneOxid)).*Tk0 ;



switch reaktion
    case true
        r_PropyleneOxid    =  (-k0.*exp((E./R).*((1./T0_vec)-(1./T_Vektor)))).* c_PropyleneOxid  ;  % Reaktionsrate 2eForm
    case false
        r_PropyleneOxid    =  zeros(size(c_PropyleneOxid))   ;
end

r_PropyleneOxid = reshape(r_PropyleneOxid,N,M);
r_PropyleneOxid(:,1)    = 0;
%r_PropyleneOxid(:,end)  = 0
%r_PropyleneOxid(end,:)  = 0
%r_PropyleneOxid(1,:)    = 0  
r_PropyleneOxid         = r_PropyleneOxid(:);
%r_PropyleneOxid    =  [0;r_PropyleneOxid(2:end-1);0]          ;   % Auf dem ersten Gridpoint gibt es keine Quelle
r_Wasser           =  r_PropyleneOxid                         ;
r_Methanol         =  zeros(size(r_PropyleneOxid))            ;
r_PropyleneGlycol  =  -r_PropyleneOxid                        ;

% Differentialgeleichungen für die Konzentrationen:
dc1_dt      = input_ode.mass_balance_Amatrix.c1 *c_PropyleneOxid   - (input_ode.mass_balance_bvektor.c1   + r_PropyleneOxid)   ;
dc2_dt      = input_ode.mass_balance_Amatrix.c2 *c_Wasser          - (input_ode.mass_balance_bvektor.c2   + r_Wasser)          ;
dc3_dt      = input_ode.mass_balance_Amatrix.c3 *c_Methanol        - (input_ode.mass_balance_bvektor.c3   + r_Methanol)        ;
dc4_dt      = input_ode.mass_balance_Amatrix.c4 *c_PropyleneGlycol - (input_ode.mass_balance_bvektor.c4   + r_PropyleneGlycol) ;

% figure(1)
% spy(input_ode.mass_balance_Amatrix.c4)
% figure(2)
% spy(input_ode.mass_balance_bvektor.c4)

dumy = nan ; 
% Differentialgleichung für die Temperatur
% dT_dt       =   input_ode.energy_balance_Amatrix* T_Vektor       + input_ode.energy_balance_bvektor  + (dhr*r_PropyleneOxid);

% Wahl von cp*c abhängig vom Befüllungszustand des Reaktors zu Beginn der
% Reaktion
switch lower(zustand)
    case 'leer'
        cp_c         =    3.515009308308688e+06;
        
    case 'vollmitlm'
        cp_c         =   c_PropyleneOxid.*cp_PropylenOxid+c_Wasser.*cp_Wasser+c_Methanol.*cp_Methanol + c_PropyleneGlycol.*cp_PropylenGlycol;
       
    case 'voll'
        cp_c         =   c_PropyleneOxid.*cp_PropylenOxid+c_Wasser.*cp_Wasser+c_Methanol.*cp_Methanol + c_PropyleneGlycol.*cp_PropylenGlycol; 
                
end

% Neu

dT_dt       =   (input_ode.energy_balance_Amatrix1 + input_ode.energy_balance_Amatrix2.*cp_c) *  T_Vektor       - (input_ode.energy_balance_bvektor1 + input_ode.energy_balance_bvektor2 *cp_c  + (dhr*r_PropyleneOxid));
 

dT_dt       =   dT_dt ./cp_c;
% Definieren des Zustandsvektors du_dt
dudt        =   [dc1_dt;dc2_dt;dc3_dt;dc4_dt;dT_dt];

dummy = nan ; 

end

