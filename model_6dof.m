function DH=model_6dof(q)
% Berechnung der DH-Parametersaetze in Abhängigkeit der Gelenkkoordinaten q


%---------- 6 dof --------------%
% DH-Parameter bestimmen und zeilenweise eintragen
DH.p = [ -pi/2 , 575 , 0 , 400+q(1) ;
         -pi/2 , 0 , q(2) , -290 ;
         0 , 500 , pi/2+q(3) , 0 ;
         pi , 387 , -pi/2+q(4) , 0 ;
         -pi/2 , 0 , -pi/2+q(5) , 20 ;
         0 , 0 , q(6) , 200 
        ];

% Bestimmen, ob es sich um ein Dreh- oder ein Schubgelenk handelt   
DH.mu=[ 0 , 1 , 1 , 1 , 1 , 1 ];

