function [x] = Gauss_1(A,b)
%Funktion zur numerischen Integration mittels Gauss-quadratur bis einschließlich 5. Grades
% Variablen von Input und Output:
%   x     = Lösungsvektor (m x g )
%   A     = Matrix(m x m) und Vektor des Gleichungssystems( m x m)
%   b     = Störvektor (m x g)



%%  Initialisieren der Arrays

% Vektoren und Matrizen initialisieren

size_A  =  size(A)                              ;
size_b  =  size(b)                              ;
zero_A  =  zeros(size_A)                        ;
ones_A  =  ones(size_A)                         ;
R       = A                                     ;
L       = zero_A                                ;
coun    = 0                                     ;
p       = (1:1:size_A(2)).'                     ;

% Fehler abfragen

if size_A(1) ~= size_A(2); error('Matrix A mmuss quadratisch sein');end
if size_b(1) ~= size_A(2); error('Länge der einzelnen übergebenen Störvektoren muss gleich groß wie die Länge von A sein ');end


% Hauptschleife für Vorwärts- und Rücksubstitution bei mehreren Störvektoren
for i = 1 : (size_A(2))
    
    %%  Matrizen für die Berrechnung (Diagonalmasken) müssen bei jeder Itereation
    %  auf 0en zurückgesetzt und anschließend neu berrechnet werden.
    
    calc_a  = zeros(size_A);    % löschen der alten werte
    calc_b  = zeros(size_A);    % löschen der alten werte
    
    %% Pivotisierung der Spalte
    % finden des Elemetnts mit dem höchsten Betrag, und Fehlerausgabe falls
    % der Betrag 0 wäre und aschließende Sortierung der Elemente
    
    [n,m]       =   max(abs(R(i:end,i)))     ;
    if m == 0; error('Fehler bei der Pivotiesierung , max(abs(A))== 0 ! Rang der Matrix unzureichend ');end
    
    m           =   m+coun      ;
    
    R([i m],:)  =   R([m i],:)  ;
    b([i m],:)  =   b([m i],:)  ;
    L([i m],:)  =   L([m i],:)  ;
    p([i m],:)  =   p([m i],:) 	;
    
    %% Vorwärtselimination
    % folgende Rechenoperationen betreffen nur Matrixelemente unterhalb des Pivotelementes A(i,i)
    
    %calc_A A(i:n,i) horizontal aneinander gereiht  ;
    calc_a(i+1:end,i:end)   =   repmat(R(i+1:end,i),1,size_A(1) -i+1)   ;
   
    %calc_b A(i,i:n) vertikal runterkopiert         ;
    calc_b(i+1:end,i:end)   =   repmat(R(i,i:end),(size_A(2)-i ),1)  	;
    
    R               =   R             -     (calc_a.*calc_b)./R(i,i) 	; % Rechenoperationen auf R
    L(i:end,i)      =   L(i:end,i)    -     calc_a(i:end,i)./R(i,i)     ; % Rechenoperationen auf L
    coun            =   coun+1                                          ; % Count um Spaltenposition zu erfassen
end
L                   =   L+eye(size_A)                                   ; % Identitätsmatrix zu L addieren


for index = 1:size(b,2)
    B = b(:,index)  ;
    %% Vorwärtssubstitution
    y = zeros(size_A(1),1);
    for i = 1 : size_b(1)
        y(i) = B(i)     ;
        for j= 1 : i-1
            y(i) = y(i)+L(i,j)*y(j);
        end
    end
    
    %% Rückwärtssubstitution
    
    X = zeros(size_A(1),1)      ;
    
    for i = size_b(1) : -1 : 1
        X(i) = y(i)     ;
        for j= i + 1 : size_b(1)
            X(i) = X(i)-R(i,j)*X(j) ;
        end
        X(i) = X(i)/R(i,i);
    end
    x(:,index) = X;
    
end


