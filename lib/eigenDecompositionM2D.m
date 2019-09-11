function [e1,e2,l1,l2] = EigenDecompositionM2D(M)
% [e1,e2,l1,l2] = EigenDecompositionM2D(M)
%% An analytic solution for the eigenvalues of 2x2 matrices.
%% Help: 
% http://en.wikipedia.org/wiki/Eigenvalue_algorithm
% http://www.math.harvard.edu/archive/21b_fall_04/exhibits/2dmatrices/index.html
%
%     | a  b |
% A = |      |
%     | c  d |
%
%% Split
a = M(:,:,1,1);
b = M(:,:,1,2);
c = M(:,:,2,1);
d = M(:,:,2,2);
%% Init
L1 = zeros(size(a));
L2 = zeros(size(a));
Ex1 = zeros(size(a));
Ey1 = zeros(size(a));
Ex2 = zeros(size(a));
Ey2 = zeros(size(a));
idx = find(L2==0);
%% if b.*c <= eps
p = 0.000001; %eps
idx1 = find(b.*c <= p);
idx2 = idx(~ismember(idx,idx1));
L1(idx1) = a(idx1);
L2(idx1) = d(idx1);
Ex1(idx1) = 1; 
Ey1(idx1) = 0;
Ex2(idx1) = 0; 
Ey2(idx1) = 1;
%% else
% lambda = (a+d)/2 +- sqrt( 4bc+(a-d)^2 )/2
tr = a(idx2)+d(idx2);
det = a(idx2).*d(idx2) - b(idx2).*c(idx2);
s = sqrt((tr/2).^2 - det);
L1(idx2) = tr/2 + s;
L2(idx2) = tr/2 - s;

ss = sqrt( max(((a(idx2)-d(idx2))/2).^2 + b(idx2).*c(idx2), 0.0) );
%% if (a-d)<0
idxl3 = (a(idx2)-d(idx2))<0;
idx3 = idx2(idxl3);
idx4 = idx2(~idxl3);
Ex1(idx3) = c(idx3);
Ey1(idx3) = - (a(idx3)-d(idx3))/2 + ss(idxl3);
Ex2(idx3) = + (a(idx3)-d(idx3))/2 - ss(idxl3);
Ey2(idx3) = b(idx3);
%else
Ex2(idx4) = c(idx4);
Ey2(idx4) = - (a(idx4)-d(idx4))/2 - ss(~idxl3);
Ex1(idx4) = + (a(idx4)-d(idx4))/2 + ss(~idxl3);
Ey1(idx4) = b(idx4);
%end

n1 = sqrt(Ex1(idx2).^2 + Ey1(idx2).^2);
Ex1(idx2) = Ex1(idx2)./n1; 
Ey1(idx2) = Ey1(idx2)./n1;
n2 = sqrt(Ex2(idx2).^2 + Ey2(idx2).^2);
Ex2(idx2) = Ex2(idx2)./n2; 
Ey2(idx2) = Ey2(idx2)./n2;
%% Sort Eigenvalues -> |lambda1| <= |lambda2|
index = (L1)>(L2);
L1p = L1; 
L2p = L2;
L1(index) = L2p(index);
L2(index) = L1p(index);
%% Sort Eigenvectors
Ex1p = Ex1; 
Ey1p = Ey1; 
Ex2p = Ex2; 
Ey2p = Ey2; 
Ex1(index) = Ex2p(index);
Ey1(index) = Ey2p(index);
Ex2(index) = Ex1p(index);
Ey2(index) = Ey1p(index);
%% Output
e1 = zeros(size(M,1),size(M,2),2);
e2 = zeros(size(M,1),size(M,2),2);
e1(:,:,1) = Ex1;
e1(:,:,2) = Ey1;
e2(:,:,1) = Ex2;
e2(:,:,2) = Ey2;
l1 = L1;
l2 = L2;
end