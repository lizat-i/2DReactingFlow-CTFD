%% Hauptprogramm
% Hier werden die Unterprogramme aufgerufen und die finale Gleichung gelöst
%clc
format
clear all
close all

%% Hinzufügen der benötigten Ordner
addpath('functions')
addpath('functions/alte_func')
addpath('data')
addpath('figures')
addpath('figures/GIFs')
addpath('ode_function')

%% Eingabe der Simulationsparameter 

N          =  5                    ; % Anzahl der räumlichen Diskretisierungsschritte
M          =  5                    ;
t_sim      =  0.01                 ; % Simulationsdauer in Sekunden
%t_sim      =  10000                ; % Simulationsdauer in Sekunden

% Befüllungszustand des Reaktors zu Beginn:       
        zustand = 'leer'           ; % Reaktor ist leer
        %zustand = 'voll'            ; % Reaktor ist mit allen Komponenten befüllt
        %zustand = 'vollmitLM'      ; % Reaktor ist nur mit Lösungsmittel befüllt
        
% Findet chemische Reaktion statt?
    reaktion = false                ; % Reaktion findet statt (Fall in der Realität)
    %reaktion = true                ; % Reaktion findet nicht statt (Testfall)

run('Parameter.m')                  ; % Ausführen des Skripts mit den Parameter-Definitionen
run('Koeffizientenmatrix_2D.m')     ; % Ausführen des Skripts zur Erstellung und Zusammensetuzung der  Koeffizientenmatrizen

u0 = startWerte(startWerteParameter,N,M,zustand)          ;

% Verpacken des Inputs SolverIputs  als struct
input_ode = struct                                          ;
input_ode.mass_balance_Amatrix  =  mass_balance_Amatrix     ;
input_ode.mass_balance_bvektor  =  mass_balance_bvektor     ;

%input_ode.energy_balance_Amatrix = energy_balance_Amatrix   ;
input_ode.energy_balance_Amatrix1 = energy_balance_Amatrix1   ;
input_ode.energy_balance_Amatrix2 = energy_balance_Amatrix2   ;
input_ode.energy_balance_bvektor1 = energy_balance_bvektor1   ;
input_ode.energy_balance_bvektor2 = energy_balance_bvektor2   ;
input_ode.N = N                                             ;
input_ode.M = M                                             ;
input_ode.zustand  = zustand                                ;
input_ode.reaktion = reaktion                               ;

%% Lösen der Funktion mit der MATLAB-internen Funktion ode15s bzw. ode45
 options = odeset('RelTol',1e-5,'AbsTol',1e-5);
    [t_vec , u]       =   ode15s( @(t,u)  DGL(u,input_ode),[0 t_sim], u0(:),options) ;
%	 [t_vec , u]       =   ode45 ( @(t,u)  DGL(u,input_ode),[0 t_sim], u0(:),options) ;

% timeSteps         =     5000*10                             ;
% t_vec             =     linspace(0,t_sim*10,timeSteps)     ;
% u                 =     ones(numel(u0),numel(t_vec))    ;
% u(:,1)            =     u0                              ;
% dt                =     t_vec(2)-t_vec(1)               ;
% 
% func = @(u) DGL(u,input_ode);
% 
% % Explizites Euler-Verfahren in Matrix-Vektor-Schreibweise 
% for i = 2:1:timeSteps
%     u(:,i)    =   u(:,i-1) + dt .* func(u(:,i-1));     
% end
%  u = u.';
 
 

%% Speichern der Simulationsergebnisse
%save('data/long_run_1.mat')

%% Plotten der Ergebnisrun('Plot_Ergebnis')se

run('Plot_Ergebnis.m')   ; % Ausführen des Skripts zum Plotten der Ergebnisse
