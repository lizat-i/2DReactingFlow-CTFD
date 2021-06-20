%% Skript zum Erstellen der Koeffizientenmatrizen
% Hier werden die Koeffizientenmatrizen mit den jeweiligen Randbedingungen
% definiert

dz      =   L/(N-1)       ; % axiale Schrittweite (übernommen aus Folie 32 aus Termin 8)
dr      =   (D/2)/(M-1)   ; % radiale Schrittweite (übernommen aus Folie 32 aus Termin 8)    
dz2     =   dz*dz         ; 
dr2     =   dr*dr         ;
qc1     =   0             ;
 
cPropylenoxid0      = startWerteParameter.cPropylenoxid0   ;
cWasser0            = startWerteParameter.cWasser0         ;
cMethanol0          = startWerteParameter.cMethanol0       ;
cPropylenglycol0    = startWerteParameter.cPropylenglycol0 ;
Temperatur0         = startWerteParameter.Temperatur0      ;
 

coolingT    =   350;
alpha       =   5;
%% Diffusionsterm  
 A                                      =   zeros(N*M)                      ; % Initialisieren der Systemmatrix
[b]                                     =   deal(zeros(size(A,1),1))        ; % Initialisieren des b-Vektors
[Node_number_matrix,Coordinate_R,~]     =   createMesh(M,N,(D/2),L)         ; 

[A1_T,b1_T]                             =   Aconstruct_diffusiveTerm_new(A,b,Node_number_matrix,Coordinate_R,dr,dz) ;


[A1_T,b1_T]                               =   NeumannBC_diffusionTerm_new(A1_T,b1_T,'South',Node_number_matrix,dr,dz)                                       ;
[A1_T,b1_T]                               =   NeumannBC_diffusionTerm_new(A1_T,b1_T,'East',Node_number_matrix,dr,dz)                                        ;
[A1_T,b1_T]                               =   RobinBC_diffusionTerm_new(A1_T,b1_T,'North',Node_number_matrix,dr,dz,coolingT,alpha)                          ;
[A1_T,b1_T]                               =   Dirichlet_diffusionTerm_new(A1_T,b1_T,'West',Node_number_matrix,dr,dz,startWerteParameter.Temperatur0 )       ;

[A1_T,b1_T]                               =   Aconstruct_diffusiveTerm_new(A1_T,b1_T,Node_number_matrix,Coordinate_R,dr,dz) ;



% %%%
% alpha = 1;                  % Convective heat transfer coefficient
% Tinf = 100;                  % Temperature of the surrounding fluid
% %%%%%%%%%%%%%%%%%

[A1_c1,b1_c1]                               =   Aconstruct_diffusiveTerm_new(A,b,Node_number_matrix,Coordinate_R,dr,dz) ;

[A1_c1,b1_c1]                               =   NeumannBC_diffusionTerm_new(A1_c1,b1_c1,'South',Node_number_matrix,dr,dz)   ;
[A1_c1,b1_c1]                              =   NeumannBC_diffusionTerm_new(A1_c1,b1_c1,'North',Node_number_matrix,dr,dz)  ;
%[A1_c1,b1_c1]                               =   RobinBC_diffusionTerm_new(A1_c1,b1_c1,'North',Node_number_matrix,dr,dz,startWerteParameter.cPropylenoxid0*1.2,5)  ;
[A1_c1,b1_c1]                               =   NeumannBC_diffusionTerm_new(A1_c1,b1_c1,'East',Node_number_matrix,dr,dz)    ;
[A1_c1,b1_c1]                               =   Dirichlet_diffusionTerm_new(A1_c1,b1_c1,'West',Node_number_matrix,dr,dz,startWerteParameter.cPropylenoxid0 )    ;

[A1_c1,b1_c1]                               =   Aconstruct_diffusiveTerm_new(A1_c1,b1_c1,Node_number_matrix,Coordinate_R,dr,dz) ;


% z = linspace(0,L,M);
% r = linspace(0,D,N);
% r = fliplr(r);
% [Z,R] = meshgrid(z,r);
% figure(1)
% spy(A1_c1)
% figure(2)
% surf(Z,R,reshape(A1_T \b1_T,M,N));
% disp(A1_c1) ;
% dummy = nan ; 
% return

%%%%%%%%%%%%%%%%%%%%%%
[A1_c2,b1_c2]=Aconstruct_diffusiveTerm_new(A,b,Node_number_matrix,Coordinate_R,dr,dz); 

[A1_c2,b1_c2]                               =   Aconstruct_diffusiveTerm_new(A1_c2,b1_c2,Node_number_matrix,Coordinate_R,dr,dz) ;
[A1_c2,b1_c2]                               =   NeumannBC_diffusionTerm_new(A1_c2,b1_c2,'South',Node_number_matrix,dr,dz)   ;
[A1_c2,b1_c2]                               =   NeumannBC_diffusionTerm_new(A1_c2,b1_c2,'East',Node_number_matrix,dr,dz)    ;
[A1_c2,b1_c2]                               =   NeumannBC_diffusionTerm_new(A1_c2,b1_c2,'North',Node_number_matrix,dr,dz )  ;
[A1_c2,b1_c2]                               =   Dirichlet_diffusionTerm_new(A1_c2,b1_c2,'West',Node_number_matrix,dr,dz,startWerteParameter.cWasser0 )    ;

[A1_c2,b1_c2]                               =   Aconstruct_diffusiveTerm_new(A1_c2,b1_c2,Node_number_matrix,Coordinate_R,dr,dz) ;

%%%%%%%%%%%%%%%%%%%%%%%%
[A1_c3,b1_c3]                               =   Aconstruct_diffusiveTerm_new(A,b,Node_number_matrix,Coordinate_R,dr,dz) ;

[A1_c3,b1_c3]                               =   NeumannBC_diffusionTerm_new(A1_c3,b1_c3,'South',Node_number_matrix,dr,dz)   ;
[A1_c3,b1_c3]                               =   NeumannBC_diffusionTerm_new(A1_c3,b1_c3,'East',Node_number_matrix,dr,dz)    ;
[A1_c3,b1_c3]                               =   NeumannBC_diffusionTerm_new(A1_c3,b1_c3,'North',Node_number_matrix,dr,dz )  ;
[A1_c3,b1_c3]                               =   Dirichlet_diffusionTerm_new(A1_c3,b1_c3,'West',Node_number_matrix,dr,dz,startWerteParameter.cMethanol0 )    ;


[A1_c3,b1_c3]                               =   Aconstruct_diffusiveTerm_new(A1_c3,b1_c3,Node_number_matrix,Coordinate_R,dr,dz) ;
%%%%%%%%%%%%%%%%%%%%%%%%%%%
[A1_c4,b1_c4]                               =   Aconstruct_diffusiveTerm_new(A,b,Node_number_matrix,Coordinate_R,dr,dz) ;
[A1_c4,b1_c4]                               =   NeumannBC_diffusionTerm_new(A1_c4,b1_c4,'South',Node_number_matrix,dr,dz)   ;
[A1_c4,b1_c4]                               =   NeumannBC_diffusionTerm_new(A1_c4,b1_c4,'East',Node_number_matrix,dr,dz)    ;
[A1_c4,b1_c4]                               =   NeumannBC_diffusionTerm_new(A1_c4,b1_c4,'North',Node_number_matrix,dr,dz )  ;
[A1_c4,b1_c4]                               =   Dirichlet_diffusionTerm_new(A1_c4,b1_c4,'West',Node_number_matrix,dr,dz,startWerteParameter.cPropylenglycol0 )    ;

[A1_c4,b1_c4]                               =   Aconstruct_diffusiveTerm_new(A1_c4,b1_c4,Node_number_matrix,Coordinate_R,dr,dz) ;

%% Konvektionsterm  
[A2_T,b2_T] =   Aconstruct_konvectiveTerm_new(A,b,Node_number_matrix,Coordinate_R,dr,dz);

[A2_T,b2_T]                                 =   NeumannBC_konvectiveTerm_new(A2_T,b2_T,'South',Node_number_matrix,dr,dz);
[A2_T,b2_T]                                 =   NeumannBC_konvectiveTerm_new(A2_T,b2_T,'North',Node_number_matrix,dr,dz);
[A2_T,b2_T]                                 =   NeumannBC_konvectiveTerm_new(A2_T,b2_T,'East',Node_number_matrix,dr,dz); 
[A2_T,b2_T]                                 =   Dirichlet_diffusionTerm_new(A2_T,b2_T,'West',Node_number_matrix,dr,dz,startWerteParameter.Temperatur0 );
  
[A2_c1,b2_c1]=Aconstruct_konvectiveTerm_new(A,b,Node_number_matrix,Coordinate_R,dr,dz);

[A2_c1,b2_c1]                                 =   NeumannBC_konvectiveTerm_new(A2_c1,b2_c1,'South',Node_number_matrix,dr,dz);
[A2_c1,b2_c1]                                 =   NeumannBC_konvectiveTerm_new(A2_c1,b2_c1,'North',Node_number_matrix,dr,dz);
[A2_c1,b2_c1]                                 =   NeumannBC_konvectiveTerm_new(A2_c1,b2_c1,'East',Node_number_matrix,dr,dz); 
[A2_c1,b2_c1]                                 =   Dirichlet_diffusionTerm_new(A2_c1,b2_c1,'West',Node_number_matrix,dr,dz,startWerteParameter.cPropylenoxid0 );
 
[A2_c2,b2_c2]=Aconstruct_konvectiveTerm_new(A,b,Node_number_matrix,Coordinate_R,dr,dz); 

[A2_c2,b2_c2]                                 =   NeumannBC_konvectiveTerm_new(A2_c2,b2_c2,'South',Node_number_matrix,dr,dz);
[A2_c2,b2_c2]                                 =   NeumannBC_konvectiveTerm_new(A2_c2,b2_c2,'North',Node_number_matrix,dr,dz);
[A2_c2,b2_c2]                                 =   NeumannBC_konvectiveTerm_new(A2_c2,b2_c2,'East',Node_number_matrix,dr,dz); 
[A2_c2,b2_c2]                                 =   Dirichlet_diffusionTerm_new(A2_c2,b2_c2,'West',Node_number_matrix,dr,dz,startWerteParameter.cWasser0 );

[A2_c3,b2_c3]=Aconstruct_konvectiveTerm_new(A,b,Node_number_matrix,Coordinate_R,dr,dz); 

[A2_c3,b2_c3]                                 =   NeumannBC_konvectiveTerm_new(A2_c3,b2_c3,'South',Node_number_matrix,dr,dz);
[A2_c3,b2_c3]                                 =   NeumannBC_konvectiveTerm_new(A2_c3,b2_c3,'North',Node_number_matrix,dr,dz);
[A2_c3,b2_c3]                                 =   NeumannBC_konvectiveTerm_new(A2_c3,b2_c3,'East',Node_number_matrix,dr,dz); 
[A2_c3,b2_c3]                                 =   Dirichlet_diffusionTerm_new(A2_c3,b2_c3,'West',Node_number_matrix,dr,dz,startWerteParameter.cMethanol0 );
 
[A2_c4,b2_c4]=Aconstruct_konvectiveTerm_new(A,b,Node_number_matrix,Coordinate_R,dr,dz); 

[A2_c4,b2_c4]                                 =   NeumannBC_konvectiveTerm_new(A2_c4,b2_c4,'South',Node_number_matrix,dr,dz);
[A2_c4,b2_c4]                                 =   NeumannBC_konvectiveTerm_new(A2_c4,b2_c4,'North',Node_number_matrix,dr,dz);
[A2_c4,b2_c4]                                 =   NeumannBC_konvectiveTerm_new(A2_c4,b2_c4,'East',Node_number_matrix,dr,dz); 
[A2_c4,b2_c4]                                 =   Dirichlet_diffusionTerm_new(A2_c4,b2_c4,'West',Node_number_matrix,dr,dz,startWerteParameter.cPropylenglycol0 );
 

figure(1)
spy(A1_c1);

cp_c_gleichgewicht = 3.515009308308688e+06;

%% Zusammensetzen der einzelnen Matrizen für Energie und Massenbilanz

%terme = 'alle'      ;
terme = 'onlyDiffusion' ;
De = 1          ;
ke = 1          ;
switch terme
     case 'onlyDiffusion'
        mass_balance_Amatrix.c1        = ( (De )*A1_c1        +         0             + 0                - 0             ); 
        mass_balance_bvektor.c1        = ( (De )*b1_c1        +         0             + 0                - 0             );
        mass_balance_Amatrix.c2        = ( (De )*A1_c2        +         0             + 0                - 0             ); 
        mass_balance_bvektor.c2        = ( (De )*b1_c2        +         0             + 0                - 0             );
        mass_balance_Amatrix.c3        = ( (De )*A1_c3        +         0             + 0                - 0             ); 
        mass_balance_bvektor.c3        = ( (De )*b1_c3        +         0             + 0                - 0             );  
        mass_balance_Amatrix.c4        = ( (De )*A1_c4        +         0             + 0                - 0             ); 
        mass_balance_bvektor.c4        = ( (De )*b1_c4        +         0             + 0                - 0             ); 
        
        energy_balance_Amatrix1        = ( (ke )*A1_T             +         0             + 0                                 );  
        energy_balance_Amatrix2        = ( (ke )*zeros(size(A1_T))                                           - 0              );  
        energy_balance_bvektor1        = ( (ke )*b1_T             +         0             + 0                - 0              );  
        energy_balance_bvektor2        = ( (ke )*zeros(size(b1_T))+         0             + 0                - 0              );  
    case 'ConvectionDiffusion'
        mass_balance_Amatrix.c1        = ( (De )*A1_c1        	+         (Uz )*A2_c1        		             + 0                - 0             ); 
        mass_balance_bvektor.c1        = ( (De )*b1_c1        	+         (Uz )*b2_c1        		             + 0                - 0             );
        mass_balance_Amatrix.c2        = ( (De )*A1_c2        	+         (Uz )*A2_c2        		             + 0                - 0             ); 
        mass_balance_bvektor.c2        = ( (De )*b1_c2        	+         (Uz )*b2_c2        		             + 0                - 0             );
        mass_balance_Amatrix.c3        = ( (De )*A1_c3        	+         (Uz )*A2_c3        		             + 0                - 0             ); 
        mass_balance_bvektor.c3        = ( (De )*b1_c3        	+         (Uz )*b2_c3        		             + 0                - 0             );  
        mass_balance_Amatrix.c4        = ( (De )*A1_c4        	+         (Uz )*A2_c4        		             + 0                - 0             ); 
        mass_balance_bvektor.c4        = ( (De )*b1_c4        	+         (Uz )*b2_c4        		             + 0                - 0             ); 
                                                                                      
        energy_balance_Amatrix1        = ( (ke )*A1_T           +         (ke )*A2_T             	             + 0                                 );  
        energy_balance_Amatrix2        = ( (ke )*zeros(size(A1_T)) +      (ke )*zeros(size(A2_T))	             + 0                - 0              );  
        %energy_balance_bvektor        = ( (ke )*b1_T           +         (ke )*b2_T             	             + 0                - 0              );     
        energy_balance_bvektor1        = ( (ke )*b1_T           +         0                                      + 0                - 0              );  
        energy_balance_bvektor2        = ( 0                    +         (ke )*b2_T                             + 0                - 0              );          
    case 'onlyConvection'
        mass_balance_Amatrix.c1        = (  	0               +         (Uz )*A2_c1        		             + 0                - 0             ); 
        mass_balance_bvektor.c1        = (  	0               +         (Uz )*b2_c1        		             + 0                - 0             );
        mass_balance_Amatrix.c2        = (  	0               +         (Uz )*A2_c2        		             + 0                - 0             ); 
        mass_balance_bvektor.c2        = (  	0               +         (Uz )*b2_c2        		             + 0                - 0             );
        mass_balance_Amatrix.c3        = (  	0               +         (Uz )*A2_c3        		             + 0                - 0             ); 
        mass_balance_bvektor.c3        = (  	0               +         (Uz )*b2_c3        		             + 0                - 0             );  
        mass_balance_Amatrix.c4        = (  	0               +         (Uz )*A2_c4        		             + 0                - 0             ); 
        mass_balance_bvektor.c4        = (  	0               +         (Uz )*b2_c4        		             + 0                - 0             ); 
 
        energy_balance_Amatrix1        = (  	0               +         (ke )*A2_T             	             + 0                                 );  
        energy_balance_Amatrix2        = (  	0               +         (ke )*zeros(size(A2_T))	             + 0                - 0              );  
        energy_balance_bvektor         = (  	0               +         (ke )*b2_T             	             + 0                - 0              );
        %energy_balance_bvektor        = ( (ke )*b1_T           +         (ke )*b2_T             	             + 0                - 0              );     
        energy_balance_bvektor1        = ( (ke )*b1_T           +         0                                      + 0                - 0              );  
        energy_balance_bvektor2        = ( 0                    +         (ke )*b2_T                             + 0                - 0              );    
end

        
        

mass_balance_Amatrix.c1        = sparse(mass_balance_Amatrix.c1)                          ;
mass_balance_bvektor.c1        = sparse(mass_balance_bvektor.c1)                          ;

mass_balance_Amatrix.c2        = sparse(mass_balance_Amatrix.c2)                          ;
mass_balance_bvektor.c2        = sparse(mass_balance_bvektor.c2)                          ;

mass_balance_Amatrix.c3        = sparse(mass_balance_Amatrix.c3)                          ;
mass_balance_bvektor.c3        = sparse(mass_balance_bvektor.c3)                          ;

mass_balance_Amatrix.c4        = sparse(mass_balance_Amatrix.c4)                          ;
mass_balance_bvektor.c4        = sparse(mass_balance_bvektor.c4)                          ;

energy_balance_Amatrix1      = sparse (energy_balance_Amatrix1)                 ;
energy_balance_Amatrix2      = sparse (energy_balance_Amatrix2)                 ;
 
%energy_balance_Amatrix      = sparse (energy_balance_Amatrix)                  ;
energy_balance_bvektor1      = sparse (energy_balance_bvektor1)                  ;
energy_balance_bvektor2      = sparse (energy_balance_bvektor2)                  ;