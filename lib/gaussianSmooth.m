 function [filteredData] = gaussianSmooth(data,sigma)
 
% Function Gaussian Smooth
%
%  function [filteredIm] = gaussianSmooth(im,sigma)
%  function [filteredData] = gaussianSmooth(data,sigma)
%   
%   Regularizes an image using a Gaussian filter of a given sigma.
%
%   -or-
%
%   Regularizes 1D data using a Gaussian filter of a given sigma.using a
%   Gaussian filter of a given sigma.
% 
%
% [Inputs (primary usage)]
%   im(mandatory)- Image. It can be either a matrix of doubles in [0,1] or
%       a matrix of integers in [0,245]. If multichannel, all the channels
%       will be smoothed out individually.
%   sigma(mandatory)- Standard deivation of the filter.
%
% [Inputs (secondary usage)]
%   data(mandatory)- Data. It can be either a vector of doubles in [0,1] or
%       a vector of integers in [0,245]. Must be monochannel.
%   sigma(mandatory)- Standard deivation of the filter.
%
%
% [outputs]
%   filteredIm- In the same codification as the input one
%   -or-
%   filteredData- In the same codification as the input one
%
% [usages]
%   fIm=gaussianSmooth(im,3.0);
%   fData=gaussianSmooth(data,3.0);
%
% [dependencies]
%   function createGaussianFilter
%   function gaussianSmooth
%
% [author]
%   Carlos Lopez-Molina (carlos.lopez@unavarra.es)
%
% [references]
%	none
%
%

%
%	0- Validate Arguments 
%
assert(nargin==2,'Error at gaussianSmooth: wrong number of arguments.');
assert (sigma>0,'Error at function gaussianSmooth: Sigma must be positive.');

%
%	1- Preprocessing
%
filter=createGaussianFilter('0D',sigma);

if (max(data(:))<1.001)
    factor=1;
else
    factor=255;
    data=double(data)./255;
end


%
%	2- Process
%
if (isvector(data))
    %that's 1d data
    filteredData=imfilter(data',filter,'replicate');
    
else
    %that's an image
    filteredData=imfilter(data,filter,'replicate');
    
end
    
if (factor==255)
    filteredData=round(filteredData.*255);
end


