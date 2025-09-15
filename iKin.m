function qi = iKin(q0, dsoll, Asoll)
    N = 1000;
    for i=1:N
        if i >= 2
            q0 = qi;
        end
        % DH-Parameter bestimmen
        DH = model_6dof(q0);
        % Transformationsmatrizen bestimmen
        T = fkin(DH)
        J = JacobiMat(T, DH.mu)
        % Rechte und linke Seite des Gleichungssystems
        [b,K] = BerechneJ(T, dsoll, Asoll, J)
        N = N + 1;
        % Gleichungssystem lösen
        qi = q0 - pinv(K) * b;
        % Abbruchbedingung
        if abs(qi-q0) < 0.001
            break;
        end
    end
end