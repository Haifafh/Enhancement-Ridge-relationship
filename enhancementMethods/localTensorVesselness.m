function out = localTensorVesselness(I,params)
%%  VesselnessTensor2D - 
%       tensor-based multiscale vessel enhancement filtering
%   
%   REFERENCE:
%       A.F. Frangi, et al., 
%       Multiscale Vessel Enhancement Filtering,
%       Lecture Notes in Computer Science, 1496, 130-137, 1998
%
%   INPUT:
%       I      - 2D gray image,
%       sigma   - half-Gaussian kernel sigma [1 2 3 ...],
%       ndir    - number of directions,
%       gamma   - vesselness parameter,
%       beta    - vesselness parameter,
%       c       - vesselness parameter,
%       wb      - detect black or white regions.
%
%   OUTPUT:
%       Vmax    - vesselness,
%       V       - array of all vesselness images for each sigma
%
%   USAGE:
%       sigma = 2:1:5; ndir = 12; gamma = 2; beta = 0.5; c = 15; wb = true;
%       [V,Vmax] = LocalTensorVesselness2D(I,sigma,ndir,gamma,beta,c,wb);
%
%   AUTHOR:
%       Boguslaw Obara, http://boguslawobara.net/
%
%   VERSION:
%       0.1 - 05/02/2013 First implementation
%% Temp
% Parameters :
%params=[5,1,5,24,2,0.5,15,1];
%% Code
sigma = (params(1):params(2):params(3))*2;ndir =params(4); gamma = params(5);beta = params(6);
c = params(7);wb = params(8); 
%% Default Parameters
if isempty(sigma);  sigma = 1;  end
if isempty(ndir);   ndir = 24;  end
if isempty(gamma);  gamma = 2;  end
if isempty(beta);   beta = 0.5; end
if isempty(c);      c = 15;     end
if isempty(wb);     wb = true;  end
%% Normalize
I = double(I); I = normalize(I);
%% Convert Image to Grey-Scale
%I = im2uint8(I); % I assume that Vesselness was defined for grey-scale images
%% Convert Image to Double
I = double(I);
%% Start Loop
[m,n] = size(I);
V = zeros(m,n,length(sigma)); 
for i=1:length(sigma)
%% Filter
%% LogGabor2D
    ang = ((1:ndir)-1)*pi/ndir;
    minWaveLength = 2; mult = 1.1; sigmaOnf = 0.55;
    minWaveLength = max(sigma(i),2);
    for k=1:ndir
        Q(:,:,k) = logGabor2D(I,ang(k),ndir,minWaveLength,mult,sigmaOnf);
    end    
%% BOLocalTensorConvolution2D
    q = localTensorConvolution(I,Q,ang);
%% Normalized Derivative - Scale
    q = power(sigma(i),gamma)*q;
%% BOLocalTensor2D
    T = localTensor(q,ang);
%% Eigen Matrix - values and vectors
    [L1,L2] = eigenMatrix2x2M(T(:,:,1),T(:,:,2),T(:,:,3),T(:,:,4));
%% Vesselness    
    L2(L2==0) = eps;
    Rbeta = L1./L2;
    S = sqrt(L1.^2 + L2.^2);   
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