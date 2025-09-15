clear all; clc;
%% Hauptprogramm: Inverse Kinematik

% ---------- Anfangswerte ----------
if ~exist('q0') % Erstelle q0 wenn es noch nicht existiert
    q0 = [0, 0, 0, 0, 0, 0]';
    
end
% ---------- Zielposition vorgeben ----------


%q1=[1e-3 pi/2 2*pi/3 0 pi -pi];

% ---------- Plot Ausgangsstellung ----------
DH0=model_6dof(q0); %Funktion wird mit q0 ausgewertet
dhplot(DH0,[],[]);

dsoll= [0 -1000 800]'; % frei waehlbar, kommt spaeter von der MRT-Kamera
Asoll = Transformationsmatrix(1);
% Asoll= [0.50,       sqrt(3)/2,  0;
%         0.00,       0.00,      -1;
%         sqrt(3)/2,  0.50,       0;];

dhplot(DH0,dsoll,Asoll);
 
% % ---------- direkte Kinematik----------
T=fkin(DH0);
% xEE=T(:,:,6) * 10^3  * [0 -0.1 0 1]';
xEE=T(:,:,6) * [0 -0.1 0 1]';
dhplot(DH0,xEE(1:3),Asoll);

% ---------- inverse Kinematik ----------
qi = iKin(q0, dsoll, Asoll)
qi(2:6) = mod(qi(2:6) + pi, 2*pi) - pi
% q_store = qi;
% elemGreater2Pi = abs(q_store) > 2*pi;
% q_store(elemGreater2Pi) = mod(q_store(elemGreater2Pi), 2*pi);
% elemGreaterEqualPi = q_store >= pi;
% q_store(elemGreaterEqualPi) = q_store(elemGreaterEqualPi) - 2*pi;
% qi(2:6) = q_store(2:6)
% [~,J] = BerechneJ(T,dsoll,Asoll, JacobiMat(T,DH0.mu));
% J
% DHinv = model_6dof(qi);
% dhplot(DHinv,dsoll,Asoll);
% T2=fkin(DHinv);
% xEE2=T2(:,:,6) * [0 -0.1 0 1]';
% dhplot(DHinv,xEE2(1:3),Asoll);




%% Nachdem die inverse Kinematik berechnet wurde, kann der folgende Code durchlaufen werden. 
%% WICHTIG: Die Endposition der Gelenkwinkel muss mit qi bezeichnet werden.

% ---------- Winkelbereich [0 ... 2*pi] ----------
for i=1:length(q0)
    qi_red(i)=qi(i);
    if DH0.mu(i)==1
        n=floor(qi(i)/(2*pi));
        qi_red(i)=qi(i)-2*pi*(n);
    end
end
dq=qi-q0; 
disp('Soll-Stellung:');
disp(qi(1:end))
qi_red = qi;

% -------------------- Winkelverlaeufe --------------------
AnimNumPoints=20;
for i=1:length(qi)
    Q(:,i)=linspace(q0(i),qi_red(i),AnimNumPoints)';
end
% -------------------- Trajektorie --------------------
Traj=[];
for i=1:AnimNumPoints
    DH=feval(@model_6dof,Q(i,:));
    T=fkin(DH);
    Traj=[Traj,T(1:3,4,end)];
end

% -------------------- Animation --------------------
flag=1;
for i=1:AnimNumPoints
    DH=feval(@model_6dof,Q(i,:));
    dhplot(DH,dsoll,Asoll,Traj);
end





