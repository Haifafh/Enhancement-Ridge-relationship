function [L1,L2,V1,V2,V3,V4] = hessianVectorField(im,s)
%%  BOHessianVectorField - 
%   
%   REFERENCE:
%
%   INPUT:
%       im      - gray image
%       s       - sigma
%
%   OUTPUT:
%       L1,L2   - eigenvalues
%       V1,V2   - eigenvectors (x,y)
%       V3,V4   - eigenvectors (x,y)
%
%   USAGE:
%
%   AUTHOR:
%       Boguslaw Obara, http://boguslawobara.net/
%
%   VERSION:
%       0.1 - 08/03/2010 First implementation

%% Normalize image
im = double(im); im = (im - min(im(:))) / (max(im(:)) - min(im(:))); 
%% Second Derivatives - Hessian Matrix
[Hxx,Hxy,Hyy] = hessianMatrix2D(im,s);
%% Normalized Derivative - Scale
Hxx = power(s,2)*Hxx;
Hxy = power(s,2)*Hxy;
Hyy = power(s,2)*Hyy;
%% Eigen Matrix - values and vectors
[L1,L2,V1,V2,V3,V4] = eigenMatrix2x2M(Hxx,Hxy,Hxy,Hyy);
end