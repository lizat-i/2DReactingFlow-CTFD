%% Skript zur Definition der Parameter
% Hier werden Stoffwerte und geometrische Daten initialisiert

% L 	= 1                 ; % Länge in Metern
% D     = 0.2               ; % Durchmesser in Metern

% %%%%%%% DEBUGGINGMODE%%%%%%%%
 
 L	= 	1;
 D 	= 	2;
 
% %%%%%%% DEBUGGINGMODE%%%%%%%%

T_0 = 300               ; % Temperatur am Einlass in Kelvin
ke  = 0.599             ; % Wärmeleitfähigkeit in W / K*m
R   = 8.31446261815324  ; % Allgemeine Gaskonstante in J / mol*K
De  = 1e-9              ; % Effektive Diffusion in m^2 / s
k0  = 1.28/3600         ; % Reaktionskonstante 1/s
Tk0 = 300               ; % Bezugstemperatur in Kelvin

E           = 75362.4           ; % in J / mol
Arheniusk   = 16.96e12          ; % in 1/h
Arheniusk   =  Arheniusk./3600  ; % in 1/s

%% Initialisieren der Stoffwerte
% Stoffwerte Propylen Oxid
M_PropylenOxid      = 58.095    ; % Molare Masse in g/mol
roh_PropylenOxid    = 830       ; % Dichte in kg/m^3
cp_PropylenOxid     =146.54     ; % Wärmekapazität in J/mol*K          
dH_PropylenOxid     =-154911.6  ; % Standardbildungsenthalpie in J/mol  

% Stoffwerte Methanol
M_Methanol  = 32.042    ; % Molare Masse
roh_Methanol= 791.3     ; % Dichte
cp_Methanol = 81.095    ; % Wärmekapazität
dH_Methanol = 0         ; % Standardbildungsenthalpie

% Stoffwerte Wasser
M_Wasser    = 18        ; % Molare Masse
roh_Wasser  = 1000      ; % Dichte
cp_Wasser   = 75.36     ; % Wärmekapazität
dH_Wasser   = -286098   ; % Standardbildungsentalpie

% Stoffwerte Propylen-Glycol
M_PropylenGlycol    = 76.095    ; % Molare Masse
roh_PropylenGlycol  = 1040      ; % Dichte
cp_PropylenGlycol   = 192.59    ; % Wärmekapazität
dH_PropylenGlycol   = -525676   ; % Standardbildungsenthalpie

dhr = dH_PropylenGlycol - ( dH_Wasser + dH_PropylenOxid)    ;

%% Berechnung der Zuführrate, Massenstrom und Volumenstrom der Stoffe
% Ströme Propylen-Glycol
feed_PropylenOxid           = 0.1                                            ; % Zuführrate in mol/s
massenstrom_PropylenOxid    = feed_PropylenOxid * M_PropylenGlycol *(1/1000) ; % Massenstrom in kg/s
volumenstrom_PropylenOxid   = massenstrom_PropylenOxid / roh_PropylenGlycol  ; % Volumenstrom in m³/s

% Ströme Methanol
volumenstrom_Methanol       = volumenstrom_PropylenOxid                     ; % Volumenstrom in m³/s
massenstrom_Methanol        = volumenstrom_Methanol * roh_Methanol          ; % Massenstrom in kg/s 
feed_Methanol               = (massenstrom_Methanol / M_Methanol)*1000      ; % Zuführrate in mol/s

% Ströme Wasser
volumenstrom_Wasser         = 2.5 * (volumenstrom_PropylenOxid+volumenstrom_Methanol)   ; % Volumenstrom in m³/s
massenstrom_Wasser          = volumenstrom_Wasser * roh_Wasser                          ; % Massenstrom in kg/s
feed_Wasser                 = (massenstrom_Wasser / M_Wasser)*1000                      ; % Zuführrate in mol/s

%% Werte zum Untersuchen
% feed_Wasser                 = 3.0*feed_Wasser; % Beim 3-fachen Wasser-Feed bleibt die Temperatur unter 325K 
% feed_Methanol               = 10*feed_Methanol;
%%


feed_Gesamt 		= feed_PropylenOxid + feed_Methanol + feed_Wasser                           ; 	% Gesamte Zuführrate in mol/s 
volumenstrom_gesamt = volumenstrom_Wasser + volumenstrom_Methanol + volumenstrom_PropylenOxid   ;   % Gesamte Zuführrate in mol/s

%% Berechnung der Startwerte für die Konzentrationen und die Temperatur
cPropylenoxid0		= feed_PropylenOxid /volumenstrom_gesamt        ;	% Eingangskonzentrationen in mol/m³
cWasser0        	= feed_Wasser       /volumenstrom_gesamt        ;	% Eingangskonzentrationen in mol/m³
cMethanol0      	= feed_Methanol     /volumenstrom_gesamt        ;	% Eingangskonzentrationen in mol/m³
cPropylenglycol0   	= 0                 /volumenstrom_gesamt        ;	% Eingangskonzentrationen in mol/m³
Temperatur0     	= 312                                           ;	% Eingangstemperatur in Kelvin

%% Startwerte als structure abspeichern 
startWerteParameter = struct; 
startWerteParameter.cPropylenoxid0       = cPropylenoxid0;
startWerteParameter.cWasser0             = cWasser0;
startWerteParameter.cMethanol0           = cMethanol0;
startWerteParameter.cPropylenglycol0     = cPropylenglycol0;
startWerteParameter.Temperatur0          = Temperatur0;
% 
% %%%%%%% DEBUGGINGMODE%%%%%%%%
% 
TNorth  = 	10 	;
TSouth 	= 	50 	;
TWest 	= 	50	;
TEast 	=	10 	;
% 
startWerteParameter = struct; 
startWerteParameter.cPropylenoxid0       = TWest;
startWerteParameter.cWasser0             = TWest;
startWerteParameter.cMethanol0           = TWest;
startWerteParameter.cPropylenglycol0     = TWest;
startWerteParameter.Temperatur0          = TWest;
% 
% %%%%%%% DEBUGGINGMODE%%%%%%%%




% Berechnung der axialen Geschwindigkeit des Fluids
Uz                  = volumenstrom_gesamt/(((D/2)^2)*pi)            ; % Volumenstrom / Fläche = Geschwindigkeit

% Berechnung der gemittelten Werte für roh und cp
roh_mittel  = roh_PropylenOxid*(feed_PropylenOxid/feed_Gesamt) + roh_Methanol*(feed_Methanol/feed_Gesamt) + roh_Wasser*(feed_Wasser/feed_Gesamt)    ; % gemittelter Wert für roh
cp_mittel   = cp_PropylenOxid*(feed_PropylenOxid/feed_Gesamt) + cp_Methanol*(feed_Methanol/feed_Gesamt) + cp_Wasser*(feed_Wasser/feed_Gesamt)       ; % gemittelter Wert für cp

roh         = roh_mittel ;
cp          = cp_mittel  ;
 
% roh     =   1173;
% cp      =   3667;
 