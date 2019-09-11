function [out] = stegerSkel(I,params)   


sigma = params(1);
% Tl = params(2);
% Tu = params(3);

%% Calculate Hessian metrix
[Dx,Dy,Dxx,Dxy,Dyy] = Hessian2D(I,sigma);
%% Calculate Eigen values
[eigenvalue1, eigenvalue2, eigenvectorx, eigenvectory]=eig2image(Dxx, Dxy, Dyy);  
  
%%(px, py)??O??_??b[-1/2,1/2]X[-1/2,1/2]??d????  
t = -(Dx.*eigenvectorx + Dy .* eigenvectory) ./...  
    (Dxx .* eigenvectorx.^2 + 2*Dxy.*eigenvectorx.*eigenvectory + Dyy.*eigenvectory.^2 );  
  
px = t.*eigenvectorx;  
py = t.*eigenvectory; 
%%
[candidateX1, candidateY1] = find(px >= -0.5 & px <= 0.5 & py >= -0.5 & py <= 0.5);  
linePixel = [candidateX1, candidateY1]; 
out = zeros(size(I));
for i=1:size(linePixel,1)
        out(linePixel(i,2),linePixel(i,1))= 1;
end 
end