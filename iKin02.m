function qi = iKin02(q0,dsoll,Asoll)
% function to iteratively calculate target q for given end position
% returns joint angels in [-pi, pi)
% define numeric parameters
N = 10000; % max number iterations
epsilon = 1e-3; % termination criterion
q = q0; % initializing q

for i=1:N
    DH = model_6dof(q);
    T = fkin(DH);
    Jac = JacobiMat(T, DH.mu);

    [f,J] = BerechneJ(T,dsoll,Asoll,Jac);
    q_next = q - pinv(J)*f;

    if abs(q_next - q) < epsilon
        qi = q_next;
        elemGreater2Pi = abs(q_next) > 2*pi;
        disp(elemGreater2Pi)
        q_next(elemGreater2Pi) = mod(q_next(elemGreater2Pi),2*pi);
        elemGreaterEqualPi = q_next >= pi;
        q_next(elemGreaterEqualPi) = q_next(elemGreaterEqualPi) - 2*pi;
        qi(2:6) = q_next(2:6);
        disp('Solution has converged')
        break;
    end

    q = q_next;
    if i == N
        qi = q_next;
        disp(['Solution did not converge!' newline 'Possible singularity or non reachable position!' newline repmat('=',1,50)])
    end
end