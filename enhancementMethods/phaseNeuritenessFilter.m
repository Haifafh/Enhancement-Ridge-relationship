function out = phaseNeuritenessFilter(I,params)
%%  NeuriteneesFilter - computing the neuritenees
%   
%   REFERENCE:
%       E. Meijering et al. Design and Validation of a Tool for Neurite 
%       Tracing and Analysis in Fluorescence Microscopy Images
%       Cytometry Part A, 58A, 167?176, 2004
%
%   INPUT:
%       I      - gray image
%       sigma   - sigma factor
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
%% Temp
% Parameters :
% params = [ nscale, norient, minWaveLength, mult, sigmaOnf, k, cutOff, g, noiseMethod];
% params = [ 3,5,8,2.3,0.25, 15,0.4,5,-1]; 
%% Code
nscale        = params(1);  
norient       = params(2); 
minWaveLength = params(3); 
mult          = params(4);  
sigmaOnf      = params(5); 
k             = params(6); 
cutOff        = params(7); 
g             = params(8);                
noiseMethod   = params(9); 
% Phase
[M,m,or,featType,PC,EO,T,pcSum] = phasecong3(I, nscale, norient, minWaveLength, mult, sigmaOnf, ...
                   k, cutOff, g, noiseMethod);
%% Normalize
out = pcSum;
out = mat2gray(out);
%% Vectors
norient = length(PC);
ang = ((1:norient)-1)*pi/norient;
qk = zeros(size(out,1),size(out,2),norient);
for o=1:norient
    qk(:,:,o) = PC{o};
end
%% Tensor
T = tensorForOrientedQuadratureFilters(qk,ang);
%% Eigen Matrix - values and vectors
[L1,L2,V1,V2,V3,V4] = eigenMatrix2x2M(T(:,:,1),T(:,:,2),T(:,:,3),T(:,:,4));
% Modified Hessian
alfa = -1;
l1=L1;
l2=L2;
L1 = l1 + alfa*l2;
L2 = l2 + alfa*l1;
% Sort L1s > L2s
index = abs(L1)<abs(L2);
L1s = L1; 
L2s = L2;
L1s(index) = L2(index);
L2s(index) = L1(index);
%% Neuriteness
Lmin = min(L1(:));
out = zeros(size(L1));
out(L1<0) = L1(L1<0)./Lmin;
end