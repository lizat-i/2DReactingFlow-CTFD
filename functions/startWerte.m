function [u0] = startWerte(startWerteParameter,N,M,zustand)
%% Anfangsbedinung: Reaktor leer oder Befüllt?
%  Diese Funktion befüllt den u0 Vektor abhängig von dem gewählten
%  Startzustand

%% Extrahieren der Werte

cPropylenoxid0   = startWerteParameter.cPropylenoxid0   ;
cWasser0         = startWerteParameter.cWasser0         ;
cMethanol0       = startWerteParameter.cMethanol0       ;
cPropylenglycol0 = startWerteParameter.cPropylenglycol0 ;
Temperatur0      = startWerteParameter.Temperatur0      ;

u0  = ones(5*N*M,1) ; % Initialisieren des Anfangsbedinungsvektor


switch lower(zustand)
    
    case 'leer'
        
        %% unbefüllter Reaktor
        % Alle Werte außer dem ersten Gitterpunkt sind 0
        
        u0(1            :   M         )   =             cPropylenoxid0     ; % Befüllen der ersten N Zeilen
        u0(N*M+1        :   N*M+M      )   =             cWasser0           ; % Befüllen der zweiten N Zeilen
        u0(2*N*M+1      :   2*N*M+M   )   =             cMethanol0         ; % Befüllen der dritten N Zeilen
        u0(3*N*M+1      :   3*N*M+M   )   =             cPropylenglycol0   ; % Befüllen der vierten N Zeilen
        u0(u0==1)    =              0                 ;
        u0(4*N*M+1:5*N*M)   = ones(size(u0(4*N*M+1:5*N*M))).*   Temperatur0        ; % Befüllen der letzten/fünften N Zeilen
        
    case 'voll'
        %% befüllter Reaktor
        % Alle Werte auf dem Gitter haben den selben Wert.
        
        u0(1:N*M     )      =  u0(1:N*M     )     *   cPropylenoxid0     ; % Befüllen der ersten N Zeilen
        u0(N*M+1:2*N*M   )  =  u0(N*M+1:2*N*M   ) *   cWasser0           ; % Befüllen der zweiten N Zeilen
        u0(2*N*M+1:3*N*M )  =  u0(2*N*M+1:3*N*M ) *   cMethanol0         ; % Befüllen der dritten N Zeilen
        u0(3*N*M+1:4*N*M )  =  u0(3*N*M+1:4*N*M ) *   cPropylenglycol0   ; % Befüllen der vierten N Zeilen
        u0(4*N*M+1:5*N*M )  =  u0(4*N*M+1:5*N*M)  *   Temperatur0        ;
    
    case 'vollmitlm'
        %% befüllter Reaktor
        % Alle Werte auf dem Gitter haben den selben Wert.
        cLM = cPropylenoxid0+cWasser0+cMethanol0;
        
        
        u0(1:N       )  =  u0(1:N       ) *   0     ; % Befüllen der ersten N Zeilen
        u0(N+1:2*N   )  =  u0(N+1:2*N   ) *   0           ; % Befüllen der zweiten N Zeilen
        u0(2*N+1:3*N )  =  u0(2*N+1:3*N ) *   cLM         ; % Befüllen der dritten N Zeilen
        u0(3*N+1:4*N )  =  u0(3*N+1:4*N ) *   cPropylenglycol0   ; % Befüllen der vierten N Zeilen
        u0(4*N+1:5*N )  =  u0(4*N+1:5*N)  *   Temperatur0        ;
        
        u0(1     )   =             cPropylenoxid0     ; % Befüllen der ersten N Zeilen
        u0(N+1   )   =             cWasser0           ; % Befüllen der zweiten N Zeilen
        u0(2*N+1 )   =             cMethanol0         ; % Befüllen der dritten N Zeilen
        u0(3*N+1 )   =             cPropylenglycol0   ; % Befüllen der vierten N Zeilen
        u0(u0==1)    =              0                 ;
        u0(4*N+1:5*N)   = ones(size(u0(4*N+1:5*N))).*   Temperatur0        ; % Befüllen der letzten/fünften N Zeilen
        
end
end


