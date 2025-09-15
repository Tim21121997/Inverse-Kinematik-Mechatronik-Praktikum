function S=A2S(A)
% Dem Rodriguezvektor s entsprechende schiefsymmetrische Matrix S
% aus der Transformationsmatrix A berechnen (Folie 28)

S=(+A-A')/(1+trace(A));