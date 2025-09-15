function out = JacobiMat(T, DH_mu)

J = zeros(6, 6);

r_1e = T(1:3, 4, end);
J(1:3, 1) = DH_mu(1) * cross([0; 0; 1], r_1e) + (1-DH_mu(1)) * [0; 0; 1];

for i=1:5
    r_ie = inv(T(:,:,i)) * T(:,:,end) * [0; 0; 0; 1];
    r_ie_BK = T(1:3,1:3,i) * r_ie(1:3);
    ui = T(1:3,3,i);
    J(1:3, i+1) = DH_mu(i+1) * cross(ui,r_ie_BK) + (1-DH_mu(i+1)) * ui;
end

J(4:6, 1) = DH_mu(1) * [0; 0; 1];
for k=1:5
    uk = T(1:3,3,k);
    J(4:6, k+1) = DH_mu(k+1) * uk;
    DH_mu(k+1);
end

out = J;



% for i = 1:2
%     for j = 1:6
%         if i==1
%             u = T(1:3, 3, j);
%             r = inv(T(:,:,j))*T(:,:,6)(1:3,4);
%             J(i, j) = DH_mu(j) * cross(u,r) + (1-DH_mu(j) * u);
%         end
%         if i==2
% 
%         end
%     end
% end

