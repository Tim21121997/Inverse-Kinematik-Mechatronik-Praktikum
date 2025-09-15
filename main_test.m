clc
clear all
DH = model_6dof([0,0,0,0,0,0]);
T = fkin(DH);
J = JacobiMat(T, DH.mu)
J*[0;0;0;10;0;0];