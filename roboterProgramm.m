clear all; clc;

%%% Roboterprogramm %%%

%% Parameter
i = 1;
user=['G13'];
pwd=['13'];
sync = 0;

% Ausgangsstellung
q0 = [0, 0, 0, 0, 0, 0]';

% Soll-Position
dsoll = zeros(3,1);
Asoll = zeros(3,3);
phi = 0; 

%% Daten vom Server abrufen, Zielpose berechnen und auf Server laden
while i == 1
    pause(5);
    sync = getVal(user, pwd, 'G13_Kom', 'SyncVar', 'INT32');
    try
        if sync == 2

            % Werte vom Server abrufen
            dsoll(1) = getVal(user, pwd, 'G13_Kamera', 'x_Kamera', 'DOUBLE');
            dsoll(2) = getVal(user, pwd, 'G13_Kamera', 'y_Kamera', 'DOUBLE');
            dsoll(3) = getVal(user, pwd, 'G13_Kamera', 'z_Kamera', 'DOUBLE');
            phi = getVal(user, pwd, 'G13_Kamera', 'phi_Object', 'DOUBLE');

            if phi == 0
                phi = 1;
            end
            Asoll = Transformationsmatrix(phi);

            % Inverse Kinematik
            qi = iKin(q0, dsoll, Asoll)
            qi(2:6) = mod(qi(2:6), 2*pi)

            % Werte auf Server laden
            saveValItem(user, pwd,'G13_Kinematik', 'q1', string(qi(1)), 'DOUBLE', 0, 0);
            saveValItem(user, pwd, 'G13_Kinematik', 'q2', string(qi(2)), 'DOUBLE', 0, 0);
            saveValItem(user, pwd, 'G13_Kinematik', 'q3', string(qi(3)), 'DOUBLE', 0, 0);
            saveValItem(user, pwd, 'G13_Kinematik', 'q4', string(qi(4)), 'DOUBLE', 0, 0);
            saveValItem(user, pwd, 'G13_Kinematik', 'q5', string(qi(5)), 'DOUBLE', 0, 0);
            saveValItem(user, pwd, 'G13_Kinematik', 'q6', string(qi(6)), 'DOUBLE', 0, 0);
            
            % Sync Variable aktualisieren
            saveValItem(user, pwd, 'G13_Kom', 'SyncVar', '3', 'INT32', 0, 0);
        end
    catch
        saveValItem(user, pwd, 'G13_Kom', 'Syncvar', '2', 'INT32', 0, 0);
    end
end
