function out = neuriteneesFilter(I,params)
%%  NeuriteneesFilter - computing the neuritenees
%   
%   REFERENCE:
%       E. Meijering et al. Design and Validation of a Tool for Neurite 
%       Tracing and Analysis in Fluorescence Microscopy Images
%       Cytometry Part A, 58A, 167???176, 2004
%
%   INPUT:
%       I      - gray image
%       params(sigma)   - sigma factor
%
%   OUTPUT:
%       out     - filtered image
%
%   USAGE:
%
%   AUTHOR:
%       Boguslaw Obara, http://boguslawobara.net/
%
%   VERSION:
%       0.1 - 25/04/2010 First implementation
%% Code
%% Normalise the image
I = double(I); I = (I - min(I(:))) / (max(I(:)) - min(I(:)));
%  I = imcomplement(I);
%% Cost Map
[L1,L2,V1,V2,V3,V4] = hessianVectorField(I,params(1));
% Modified Hessian
L1t = L1;
L2t = L2;
alfa = -1/3;
L1 = L1t + alfa*L2t;
L2 = L2t + alfa*L1t;
% Sort L1s > L2s
index = abs(L1)<abs(L2);
L1s = L1; 
L1s(index) = L2(index);
% Neuriteness
Lmin = min(L1s(:));
out = zeros(size(L1));
out(L1s<0) = L1s(L1s<0)./Lmin;
%out = imcomplement(out);
end