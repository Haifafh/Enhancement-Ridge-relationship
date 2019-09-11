
function [lineMap,dirMap]= AGlineDetector(im,sigmas,thetas,rhos)

% Function Anisotropic Gaussian Line Detector
%
%  function [lineMap] = AGlineDetector(image,sigmas,thetas,rhos)
%  function [lineMap,dirMap] = AGlineDetector(image,sigmas,thetas,rhos)
%
%   Produces a [0,1] estimation of the presence of a line at each of the 
%       positions of a given image im.
%   The estimation is computed as the difference between the maximum 
%       and minimum output yielded by 2dAGKs filter created from all the 
%       possible combination of sigmas, thetas and rhos.
%
% [Inputs]
%   im(mandatory)- Grayscale image in [0,1].
%   sigmas(mandatory)- Sigmas used in the creation of the filterbank.
%       All the sigmas must be real positive numbers.
%   thetas(mandatory)- Thetas used in the creation of the filterbank.
%       All the thetas must be within [0,pi[.
%   rhos(mandatory)-  Rhos used in the creation of the filterbank.
%       All the rhos must be positive real numbers greater or equal to 1.
%
% [outputs]
%   lineMap- Image with the estimations of the presence of a line (1 is
%       maximum, 0 is minimum.
%   dirMap- Direction of the lines at each pixel (in radians).
%
% [usages]
%
% [note]
%
% [dependencies]
%   function createGaussianFilter
%
% [author]
%   Carlos Lopez-Molina (carlos.lopez@unavarra.es)
%
%
%
% [references]
%	Title
%	Author
%	Journal etc.
%
%

%
%	0- Validate Arguments 
%
assert(nargin==4,'Error at AGlineDetector: Wrong number of arguments.');
assert(size(im,3)==1,'Error at AGlineDetector: The image should be a grayscale (monochannel) one.');
assert(min(sigmas)>0,'Error at AGlineDetector: Negative values are not allowed in argument sigmas.');
assert(min(thetas)>=0,'Error at AGlineDetector: Negative values are not allowed in argument thetas.');
assert(max(thetas)<(pi),'Error at AGlineDetector: Values greater or equal to pi are not allowed in argument thetas.');
assert(min(rhos)>=1,'Error at AGlineDetector: Values lowere than 1 are not allowed in argument rhos.');

%
%	1- Preprocessing
%

% Creating the filterbank
%   The dimensions of the filterBank are maxSize x maxSize x numFilters,
%   where maxSize is the size of the greatest filter. We first compute
%   maxSize by creating a filter with the maximum sigma and rho, them we
%   fill in the filter bank one by one.

maxSigma=max(sigmas);
params.rho=max(rhos);
maxSize=size(createGaussianFilter('2d',maxSigma,params),1);

%
%	2- Processing
%

lineMap=zeros(size(im));
dirMap=zeros(size(im));

for idxSigma=1:length(sigmas)
        
    sigma=sigmas(idxSigma);
        
    for idxThetas=1:length(thetas)

        params.theta=thetas(idxThetas);

        for idxRhos=1:length(rhos)

            params.rho=rhos(idxRhos);

            filter=createGaussianFilter('2d',sigma,params);

            %Normalizing the filter while keeping up the zero sum
            filter=2*filter./sum(abs(filter(:)));
            
            % fprintf('\t\t Applying filter s=%.2f,t=%.2f,r=%.2f\n',sigma,params.theta,params.rho);

            filteredIm=imfilter(im,-filter,'replicate');
            filteredIm=filteredIm./sum(-filter(-filter>0));
            
            dirMap(filteredIm>lineMap)=params.theta;
            lineMap(filteredIm>lineMap)=filteredIm(filteredIm>lineMap);


        end

    end
end
    
  










