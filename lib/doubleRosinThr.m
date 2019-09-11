function [doubleThr] = doubleRosinThr(originalImage,precission,gaussianSigma)

% Function doubleRosinThr
%  function [doubleThr] = doubleRosinThr(image,precission,gaussianSigma)
%
%  Obtains the optimal threshold using (twice) the Rosin[1] method.
%  This methods assumes the histogram to be unimodal.
%  It relies on the histogram to be non-decreasing
%       after its peak. That means that there should be no
%       zero-bins in the histogram followed by non-zero ones.
%  Furthermore, it assumes the peak of the histogram to 
%       be closer to the low intensity, rather than to the
%       high one. 
%
%   This approach was presented, under another name by Wenlong et al.
%   Although light differences hold, we consider the naming double Rosin
%       as the most appropriate one.
%
%
% [Inputs]
%   image(mandatory)- Grayscale image, either [0,1] or [0,255]
%   precission(optional)- Threshold precission, 0.01 by default
%   gaussianSigma(optional)- Sigma of the Gaussian pulse used for
%       smoothing the histogram. The value 0 leads to no-smoothing 
%       at all. (default=0.00)
%
% [outputs]
%   doubleThr- A 2-place array so that the first position contains the
%       lowest threshold and the second one the highest one.
%
% [usages]
%   doubleThr = doubleRosinThr(myImage);
%       [equiv. to doubleRosinThr(myImage,0.01,0)]
%   doubleThr = doubleRosinThr(myImage,0.005);
%       [equiv. to doubleRosinThr(myImage,0.005,0)]
%   doubleThr = doubleRosinThr(myImage,0.02,3);
%
% [author]
%   Carlos L?pez Molina (carlos.lopez@unavarra.es)
%
% [references]
% 
% [1]   Unimodal Thresholding
%       Paul L. Rosin
%       Pattern Recognition 34 (2001) 2083-2096
% 
% [2] Bowstring-based dual-threshold computation method for adaptive Canny
%           edge detector
%       Liu, X.; Yu, Y.; Liu, B. & Li, Z.
%       International Conf. on Image and Vision Computing New Zealand
%       2013
%

% Versioning
%   1.00 - Released (February 2014)
%   1.01 - Corrected output parameter in documentation
%   

%
%	0- Validate Arguments 
%
assert(nargin~=2 || nargin~=3,'Error at doubleRosinThr: Wrong number of parameters.');
if (nargin==1)
    binsNumber=100;
else
    binsNumber= round(1/precission);
    assert(binsNumber>10,'Error at doubleRosinThr: Wrong (too coarse) precision.')
end
if (nargin<3)
    gaussianSigma=0;
else
    assert(gaussianSigma>0,'Error at doubleRosinThr: Wrong gaussianSigma selected, it must be a non-negative value.')
end


%
%	1- Preprocessing
%

originalImage = double(originalImage);
if (max(max(originalImage))>1.001)
    factor = 255;
    originalImage= double(double(originalImage)./255);
else
    factor=1;
end



%
%	2.1- Processing: Histogram
%
histogram = imhist(originalImage(:),binsNumber);
if (isinf(gaussianSigma))
    size(histogram)
    [~,poss]=findpeaks([0 histogram']);
    while(length(poss)>1)
        histogram=gaussianSmooth(histogram,1.0);
        size(histogram)
        [~,poss]=findpeaks([0 histogram']);
    end
elseif (gaussianSigma>0)
    histogram=gaussianSmooth(histogram,gaussianSigma);
end


%
%	2.2- Processing: Finding the peak, called histPeak
%

% The peak is histPeak, its occurrence is histPeakVal
% Note that histPeak is the bin #, not the value
[histPeakVal,histPeak] = findpeaks(histogram);
if (isempty(histPeakVal))
    % No peak is found, probably the first bin is the max
    [~,histPeak]=max(histogram);
elseif(length(histPeak)==1)
    % Single peak, valid unless it has on the rigth less than
    %   10% of the pixels. In that case it's an abnormal
    %   peak on the rightmost part of the histogram.
    % We take the max instead.
    %if (sum(histogram(histPeak:end))<0.10*sum(histogram))
    %    [~,histPeak]=max(histogram);
    %end
    
    % Single peak, valid unless it is 10 times lower than the value at 
    %   the first bin.
    % We take the max instead.
    if (histogram(histPeak)<0.10*histogram(1))
        [~,histPeak]=max(histogram);
    end
elseif(length(histPeak)>1)
    % We have several peaks, so we take that having a max value.
    histPeak=histPeak(histPeakVal==max(histPeakVal));
    if (length(histPeak)>1) %several peaks with same height
        histPeak=histPeak(1);
    end
    % In any case, we check whether it is not an isolated 
    %   maxima in the right side. If so, we take the max.
    if (sum(histogram(histPeak:end))<0.10*sum(histogram)) || ...
        (histogram(histPeak)<0.33*max(histogram))
        [~,histPeak]=max(histogram);
    end
end


%
%	2.3- Processing: Finding the max
%

%We have to find the first zero after which no more
%   non-zero bins exist.
histEnd=binsNumber;
while( (histogram(histEnd)==0) && (histogram(histEnd-1)==0) && histEnd>1)
    histEnd=histEnd-1;
end

% It can be either the highest bin of the histogram (if
%       histogram(binsNumber)>0
% Otherwise, it advances until it finds one    
if (histEnd==1)
    error('Error at doubleRosinThr: The histogram was empty or the image was 0-valued.');
end




%
%	2.4- Processing: Finding the high THR
%
highThr=histPeak+getMaxDist(histogram(histPeak:histEnd))-1;


%
%	2.5- Processing: Finding the low THR
%
lowThr=histPeak+getMaxDist(histogram(histPeak:highThr))-1;


%
%	3- Output formatting
%
perc = [lowThr highThr]./binsNumber;
doubleThr=perc.*factor;

end

%
%   X- Auxiliar functions
%

function furthersPos=getMaxDist(funcValues)

x=1;
y=length(funcValues);

hx=funcValues(x);
hy=funcValues(y);

%Defining the line
% (b) slope
a= (hy-hx)/(y-x);
% (a) abscises cutting point
b = hx - (x.*a);

% Computing the best thrs
distances=zeros(size(funcValues));
maxDistance = -1;
for z=x:y
    % z is the candidate threshold
    hz = funcValues(z); %z's ocurrence
    dist = abs(a*z-hz+b)/sqrt(a^2+1);
    distances(z)=dist;
    if (dist>maxDistance)
        maxDistance=dist;
        furthersPos=z;
    end
end

end