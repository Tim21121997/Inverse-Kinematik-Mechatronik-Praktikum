function[f,J] = BerechneJ(T, dsoll, Asoll, Jac)

% f(q) aufstellen 
d1e = T(1:3, 4, end);
A1e = T(1:3, 1:3, end);
Aze = transpose(Asoll)*A1e;
sz_matrix = A2S(Aze);
s1e_vektor = Asoll  * skew(sz_matrix);
s_matrix = skew(s1e_vektor);
d_diff = d1e - dsoll;
f = [d_diff; s1e_vektor];

% Jacobimatrix berechnen
u = (eye(3) + s_matrix) / (1 + transpose(s1e_vektor) * s1e_vektor);
J = [Jac(1:3,:);
    1/2 * inv(u) * Jac(4:6,:)];
end


