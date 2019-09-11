function out = vesselness(I,params)
%%  BOVesselness2D - multiscale vessel enhancement filtering
%   
%   REFERENCE:
%       A.F. Frangi, et al., 
%       Multiscale Vessel Enhancement Filtering,
%       Lecture Notes in Computer Science, 1496, 130-137, 1998
%
%   INPUT:
%       I      - 2D gray image,
%       sigma   - Gaussian kernel sigma [1 2 3 ...],
%       gamma   - vesselness parameter,
%       beta    - vesselness parameter,
%       c       - vesselness parameter,
%       wb      - detect black or white regions.
%
%   OUTPUT:
%       out    - vesselness.
%
%   USAGE:
%       sigma = 0.5:0.5:1; gamma = 2; beta = 0.5; c = []; wb = true;
%       [V,Vmax] = BOVesselness2D(I,sigma,gamma,beta,c,wb);
%
%   AUTHOR:
%       Boguslaw Obara, http://boguslawobara.net/
%
%   VERSION:
%       0.1 - 22/04/2009 First implementation
%       0.2 - 16/10/2009 Fast approach
%       0.3 - 11/04/2010 im2uint8
%% temp
%   Parameters (Drive): [sigma,gamma,beta,c,wb]
%                       [0.5,0.5,3, 20, 1.5, 5, 1]
%%
sigma = params(1):params(2):params(3);gamma = params(4);beta = params(5);
c = params(6);wb = params(7); 
I = imcomplement(I);
%% Default Parameters
if isempty(sigma);  sigma = 1;  end
if isempty(gamma);  gamma = 2;  end
if isempty(beta);   beta = 0.5; end
if isempty(c);      c = 15;     end
if isempty(wb);     wb = 1;     end
%% Normalize
I = double(I); I = (I - min(I(:))) / (max(I(:)) - min(I(:)));
%% Convert Image to Grey-Scale
%I = im2uint8(I); % I assume that Vesselness was defined for grey-scale images
%% Convert Image to Double
I = double(I);
%% Start Loop
[m,n] = size(I);
V = zeros(m,n,length(sigma)); 
for i=1:length(sigma)
%% Second Derivatives - Hessian Matrix
    [Hxx,Hxy,Hyy] = hessianMatrix2D(I,sigma(i));
%% Normalized Derivative - Scale
    Hxx = power(sigma(i),gamma)*Hxx;
    Hxy = power(sigma(i),gamma)*Hxy;
    Hyy = power(sigma(i),gamma)*Hyy;
%% Eigen Matrix - values and vectors
%[L1,L2] = BOEigenMatrix2x2(Hxx,Hxy,Hxy,Hyy);An analytic solution for the eigenvalues of 2x2 matrices.
[L1,L2] = eigenMatrix2x2M(Hxx,Hxy,Hxy,Hyy);
%% Vesselness    
    L2(L2==0) = eps;
    Rbeta = (L1./L2);
    S = L1.^2 + L2.^2;     
%% Compute Filtered Image
    Vo = exp(-(Rbeta.^2)/(2*beta^2)).*(ones(size(I))-exp(-(S.^2)/(2*c^2)));  
%% TODO     half the value of the maximum Hessian norm has proven to work
%% If |lambda2 > 0| or |lambda2 < 0|  => Vo = 0
    if(wb==1)
        Vo(L2<0) = 0;
    else
        Vo(L2>0) = 0;
    end    
%% Table of Vo
    V(:,:,i) = Vo;
end
%% Calculate Maximum Image Over the Scales
if length(sigma)>1
    out = max(V,[],3);
else
    out = V;
end
%% End
end