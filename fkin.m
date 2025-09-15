function [T_matrix_2] = fkin(DH)

    T_matrix_1 = zeros(4,4,6);
    T_matrix_2 = zeros(4,4,6);

    for i=1:6
        T_matrix_1(:,:,i) = [cos(DH.p(i,3)), -sin(DH.p(i,3))*cos(DH.p(i,1)), sin(DH.p(i,3))*sin(DH.p(i,1)), DH.p(i,2)*cos(DH.p(i,3));
                           sin(DH.p(i,3)), cos(DH.p(i,3))*cos(DH.p(i,1)), -cos(DH.p(i,3))*sin(DH.p(i,1)), DH.p(i,2)*sin(DH.p(i,3));
                           0, sin(DH.p(i,1)), cos(DH.p(i,1)), DH.p(i,4);
                           0, 0, 0, 1
                           ];
    end

    T_matrix_2(:,:,1) = T_matrix_1(:,:,1);
    T_matrix_2(:,:,2) = T_matrix_1(:,:,1) * T_matrix_1(:,:,2);
    T_matrix_2(:,:,3) = T_matrix_1(:,:,1) * T_matrix_1(:,:,2) * T_matrix_1(:,:,3);
    T_matrix_2(:,:,4) = T_matrix_1(:,:,1) * T_matrix_1(:,:,2)  * T_matrix_1(:,:,3) * T_matrix_1(:,:,4);
    T_matrix_2(:,:,5) = T_matrix_1(:,:,1) * T_matrix_1(:,:,2) * T_matrix_1(:,:,3) * T_matrix_1(:,:,4) * T_matrix_1(:,:,5);
    T_matrix_2(:,:,6) = T_matrix_1(:,:,1) * T_matrix_1(:,:,2) * T_matrix_1(:,:,3) * T_matrix_1(:,:,4) * T_matrix_1(:,:,5) * T_matrix_1(:,:,6);

    T1_E =  T_matrix_2(:,:,6);
    

    
    