function binaryImage= floodHysteresis(grayImg,highThrs,lowThrs)


% Function Flood Hysteresis
%
%  function binaryImage= floodHysteresis(grayImg,highThrs,lowThrs)
%
%  Performs hysteresis not considering the orientation of the edge at each
%       pixel. Note that Canny, in his seminal paper, did propose to use
%       such orientations.
%
% [Inputs]
%   grayImg(mandatory)- Image to be binarized
%   highThrs(mandatory)- Value of the high threshold. Must be in [0,1].
%   lowThrs(optional, default=0.4*highThrs)- Value of the low threshold.
%       Must be in [0,1].
%
% [outputs]
%   binaryImage- Resulting binary image.
%
% [usages]
%   > bImage=floodHysteresis(myGImage,0.7);
%       (equiv. to bImage=floodHysteresis(myGImage,0.7,0.28);)
%
% [dependencies]
%   none
%
% [author]
%   Carlos Lopez-Molina (carlos.lopez@unavarra.es)
%
%
% [references]
%   none
%

%
%	0- Validate Arguments 
%
assert(2<=nargin && nargin<=3,'Error at floodHysteresis: Wrong number of arguments.');
assert(0<highThrs && highThrs<=1,'Error at floodHysteresis: Wrong value of highThrs.');
if (nargin==2)
    lowThrs=highThrs*0.4;
else
    assert(0<lowThrs && lowThrs<=1,'Error at floodHysteresis: Wrong value of lowThrs.');
    assert(lowThrs<=highThrs,'Error at floodHysteresis: The low Thrs should be lower than the high one.');
end

%
%	2- Processing
%

posHigh = find(grayImg>=highThrs);
imageLow = zeros(size(grayImg));
imageLow(grayImg>lowThrs)=1;

posHighR = rem(posHigh-1, size(grayImg,1))+1;
posHighC = floor((posHigh-1)/size(grayImg,1))+1;
binaryImage = bwselect(imageLow, posHighC, posHighR, 8);