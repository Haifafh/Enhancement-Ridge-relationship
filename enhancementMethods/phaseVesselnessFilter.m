function out = phaseVesselnessFilter(I, params)
%% Description..
%% Temp
% Usage:
% params=[2,2,4,10,3,2.1,0.55,8];
%
% REFERENCE:
%       A.F. Frangi, et al., 
%       Multiscale Vessel Enhancement Filtering,
%       Lecture Notes in Computer Science, 1496, 130-137, 1998
%
%% Code
I = imcomplement(I);
beta = params(1);
c = params(2);
params1 = {I,params(3),params(4),params(5),params(6),params(7),params(8)};
%% Phase
[M,m,or,featType,PC,EO,T,pcSum] = phasecong3(params1{:});
%% Normalize
out = pcSum;
out = normalize(out);
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
%%
index = abs(L1)>abs(L2); 
L1s = L1; 
L2s = L2;
L1s(index) = L2(index);
L2s(index) = L1(index);
L1 = L1s;
L2 = L2s;
L2(L2==0) = eps;
%% Compute Filtered Image    
Rbeta = L1./L2;
S = sqrt(L1.^2 + L2.^2);     
out = exp(-(Rbeta.^2)/(2*beta^2)).*(ones(size(out))-exp(-(S.^2)/(2*c^2)));    
%% Normalize
% out = (varargin{1} + out);
out = double(out); out = (out - min(out(:))) / (max(out(:)) - min(out(:)));
end