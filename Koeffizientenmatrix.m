%% Skript zum Erstellen der Koeffizientenmatrizen
% Hier werden die Koeffizientenmatrizen mit den jeweiligen Randbedingungen
% definiert

dz      =   L/(N-1)       ; % Räumliche Schrittweite (übernommen aus Folie 32 aus Termin 8) 
dz2     =   dz*dz         ; 

qc1     = 0                 ;

%% Konstruieren der Koeffizienten Matrix des ersten Terms (diffusiver Anteil)

 A1                 = zeros(N)                     ; % Initialisieren der Systemmatrix
[b1]                = deal(zeros(size(A1,1),1))    ; % Initialisieren des b-Vektors

%  Zusammensetzen des Matrixtorsos
for i = 2:N-1
    A1(i,i)      = -2                        ; % Diagonalelemente
    A1(i,i-1)    =  1                        ; % untere Diagonale
    A1(i,i+1)    = 1                         ; % obere Diagonale
    
    b1(i)        =   0                       ; % Befüllen des b-Vektors     
end

% Randbedinung am Raktoreingang nach Ditrichlet
for i = 1
    
    A1(i,i)      =   0                          ; % Diagonalelemente
    A1(i,i+1)    =   0                          ; % obere Diagonale
    b1(i)        =   0                          ; % Befüllen des b-Vektors
end
 
% Randbedinung am Reaktorausgang nach Neumann
for i = N
    
    A1(i,i)      =  -2                           ; % Diagonalelemente
    A1(i,i-1)    =   2                           ; % obere Diagonale
    b1(i)        =   0                           ; % Befüllen des b-Vektors
end

%% Konstruieren der Koeffizienten Matrix des zweiten Terms (konvektiver Anteil)
% Ruekwaertsdifferenz (upwind schema)

A2               = zeros(N)                     ; % Initialisieren der Systemmatrix
[b2,z_vec2]      = deal(zeros(size(A2,1),1))    ; % Initialisieren des b-Vektors

%  Zusammensetzen des Matrixtorsos
for i = 2:N-1
    A2(i,i)      =  1                         ; % Diagonalelemente
    A2(i,i-1)    =  -1                        ; % untere Diagonale
    A2(i,i+1)    =   0                        ; % obere Diagonale
    
    b2(i)        =  0                       ; % Befüllen des b-Vektors
end

% Randbedinung am Raktoreingang nach Ditrichlet
for i = 1
    A2(i,i)      =   0                         ; % Diagonalelemente
    A2(i,i+1)    =   0                         ; % obere Diagonale
    b2(i)        =   0                         ; % Befüllen des b-Vektors
end
 
% Randbedinung am Reaktorausgang nach Neumann
for i = N
    A2(i,i)      = 1                             ; % Diagonalelemente
    A2(i,i-1)    = -1                            ; % obere Diagonale
    b2(i)        = 0                             ; % Befüllen des b-Vektors
end

cp_c_gleichgewicht = 3.515009308308688e+06;

%% Zusammensetzen der einzelnen Matrizen für Energie und Massenbilanz
 
mass_balance_Amatrix        = ( (De/dz2)*A1      -(Uz/(dz))*A2              )       ; % Koeffizientenmatrix für die Stoffkonzentrationen (später je 1x pro Stoff)
mass_balance_bvektor        = ( (De/dz2)*b1(:)   -(Uz/(dz))*b2(:)           )       ; % b-Vektor für die Stoffkonzentrationen (später je 1x pro Stoff)

mass_balance_Amatrix        = sparse(mass_balance_Amatrix)                          ;
mass_balance_bvektor        = sparse(mass_balance_bvektor)                          ;

%  energy_balance_Amatrix      = ( (+ke/dz2)*A1     - ((ci_c_gleichgewicht.*Uz)./(dz)).*A2       )	; % Koeffizientenmatrix für die Temperaturen
%  energy_balance_bvektor      = ( (+ke/dz2)*b1(:)  - ((ci_c_gleichgewicht.*Uz)./(dz)).*b2(:)    )	; % b-Vektor für die Temperaturen

 energy_balance_Amatrix1      =  (+ke/dz2)*A1                                   ; % Koeffizientenmatrix für die Temperaturen
 energy_balance_Amatrix2      =  ((Uz)./(dz)).*A2                               ; % Koeffizientenmatrix für die Temperaturen
 energy_balance_bvektor      =   ( (+ke/dz2)*b1(:)  - ((Uz)./(dz)).*b2(:)    )	; % b-Vektor für die Temperaturen

energy_balance_Amatrix1      = sparse (energy_balance_Amatrix1)                 ;
energy_balance_Amatrix2      = sparse (energy_balance_Amatrix2)                 ;
 
%  energy_balance_Amatrix      = sparse (energy_balance_Amatrix)                ;
 energy_balance_bvektor      = sparse (energy_balance_bvektor)                  ;