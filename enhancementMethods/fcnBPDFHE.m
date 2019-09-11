function out = fcnBPDFHE(I, params)
% Description :
%   fcnBPDFHE performs Brightness Preserving Dynamic Fuzzy Histogram
%   Equalization (BPDFHE) on an Image
%
%   OUTPUTIMAGE = fcnBPDFHE(INPUTIMAGE) performs BPDFHE on an image using
%   default parameter settings. Supported image classes for INPUTIMAGE 
%   include uint8, uint16, int16, single, double. Default execution uses a 
%   triangular membership function with support of 5. Default memberships 
%   values are [1 2 3 4 5 4 3 2 1].
%   
%   OUTPUTIMAGE = fcnBPDFHE(INPUTIMAGE,FUZZY_MEMBERSHIP_TYPE,PARAMETERS)
%   performs BPDFHE on the INPUTIMAGE using Fuzzy Memberships as defined in
%   FUZZY_MEMBERSHIP_TYPE
%       Options:
%       --------
%       triangular - uses a triangular membership function
%       gaussian - uses a gaussian membership function
%       custom - uses the  user defined membership values
%   PARAMETERS are to be specified accordingly for usage
%       Options:
%       --------
%       Width of support if 'triangular'. Suggested is 5 for uint8
%       Width of support and spread factor if 'gaussian'. Suggested is
%       [5,2] for uint8
%       User defined membership values if 'custom'. Suggested is [1 2 3 4 5 4 3 2 1]
%
%   [OUTPUTIMAGE, TRANSFORMATION_MAP] = fcnBPDFHE(...) returns also the
%   intensity transformation matrix for further usage.
% 
%   Details of the method are available in
%   D. Sheet, H. Garud, A. Suveer, J. Chatterjee and M. Mahadevappa,
%   "Brightness Preserving Dynamic Fuzzy Histogram Equalization", 
%   IEEE Trans., Consumer Electronics, vol. 56, no. 4, pp. 2475 - 2480, 
%   Nov. 2010. [http://dx.doi.org/10.1109/TCE.2010.5681130]
%
%   H. Garud, D. Sheet, A. Suveer, P.K. Karri, A.K. Ray, M. Mahadevappa,
%   J. Chatterjee, "Brightness preserving contrast enhancement in digital 
%   pathology", Proc. ICIIP 2011. 
%   [http://dx.doi.org/10.1109/ICIIP.2011.6108964]
%
%   2009 (c) Debdoot Sheet, Indian Institute of Technology Kharagpur, India
%       Ver 1.0     28 January 2009
%       Ver 2.0     11 December 2011
%           Rev 1.0 14 December 2011
%           Rev 2.0 15 December 2011
%
% Example (Grayscale Images)
% --------------------------
% inputImage = imread('cameraman.tif');
% out = fcnBPDFHE(inputImage);
% figure, subplot 131, imshow(inputImage), subplot 132,
% imshow(out), subplot 133, imshow(inputImage-out,[])
%
% Example (Color Images)
% --------------------------
% rgbInputImage = imread('peppers.png');
% labInputImage = applycform(rgbInputImage,makecform('srgb2lab'));
% Lbpdfhe = fcnBPDFHE(labInputImage(:,:,1));
% labOutputImage = cat(3,Lbpdfhe,labInputImage(:,:,2),labInputImage(:,:,3));
% rgbOutputImage = applycform(labOutputImage,makecform('lab2srgb'));
% figure, subplot 121, imshow(rgbInputImage), subplot 122,
% imshow(rgbOutputImage);


% 2009 (c) Debdoot Sheet, Indian Institute of Technology Kharagpur, India
% All rights reserved.
% 
% Permission is hereby granted, to use, copy, modify, and distribute this code 
% (the source files) and its documentation for any purpose, provided that 
% the copyright notice in its entirety appear in all copies of this code, 
% and the original source of this code. Further Indian Institute of 
% Technology Kharagpur (IIT Kharagpur / IITKGP)  is acknowledged in any
% publication that reports research or any usage using this code. The work
% is to be cited using the bibliography as
% 
% D. Sheet, H. Garud, A. Suveer, J. Chatterjee and M. Mahadevappa,
% "Brightness Preserving Dynamic Fuzzy Histogram Equalization", 
% IEEE Trans., Consumer Electronics, vol. 56, no. 4, pp. 2475 - 2480, 
% Nov. 2010. [http://dx.doi.org/10.1109/TCE.2010.5681130]
%
% Garud, H.  Sheet, D.  Suveer, A.  Karri, P.K.  Ray, A.K.  Mahadevappa, M.
% Chatterjee, J., "Brightness preserving contrast enhancement in digital 
% pathology", Proc. ICIIP 2011. 
% [http://dx.doi.org/10.1109/ICIIP.2011.6108964]
% 
% In no circumstantial cases or events the Indian Institute of Technology
% Kharagpur or the author(s) of this particular disclosure be liable to any
% party for direct, indirectm special, incidental, or consequential 
% damages if any arising out of due usage. Indian Institute of Technology 
% Kharagpur and the author(s) disclaim any warranty, including but not 
% limited to the implied warranties of merchantability and fitness for a 
% particular purpose. The disclosure is provided hereunder "as in" 
% voluntarily for community development and the contributing parties have 
% no obligation to provide maintenance, support, updates, enhancements, 
% or modification.

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%% Code
% Input argument support check
%validateattributes(I,{'uint8','uint16','int16','single','double'}, {'nonsparse','2d'}, mfilename,'I',1);

    if params(1)== 0                                                       % means FUZZY_MEMBERSHIP_TYPE is triangular : needs 2 params (method, params(2))
        membership = params(2)-abs(-params(2):params(2));
        
    elseif params(1)== 1                                                   % means FUZZY_MEMBERSHIP_TYPE is gaussian :needs 3 params (method, params(2),params(3))

        membership = exp(-(-params(2):params(2)).^2/params(3)^2);

    elseif params(1)== 2                                        % means FUZZY_MEMBERSHIP_TYPE is custom :needs 3 params (method, params(2):params(10))
            
        membership = params(2:10);
    
    end

imageType = class(I);

% Histogram creation
if strcmp(class(I),'uint8')
    [crispHistogram,grayScales] = imhist(I);
elseif strcmp(class(I),'uint16')
    crispHistogram = zeros([2^16 1]);
    for counter = 1:numel(I)
        crispHistogram(I(counter)+1) = crispHistogram(I(counter)+1) + 1;
    end
    grayScales = 0:(2^16 - 1);
elseif strcmp(class(I),'int16')
    crispHistogram = zeros([2^16 1]);
    for counter = 1:numel(I)
        crispHistogram(I(counter)+32769) = crispHistogram(I(counter)+32769) + 1;
    end
    grayScales = -32768:32767;
elseif (strcmp(class(I),'double')||strcmp(class(I),'single'))
    maxGray = max(I(:));
    minGray = min(I(:));
    I = im2uint8(mat2gray(I));
    [crispHistogram,grayScales] = imhist(I);
end

I = double(I);

fuzzyHistogram = zeros(numel(crispHistogram)+numel(membership)-1,1);

for counter = 1:numel(membership)
    fuzzyHistogram = fuzzyHistogram + membership(counter)*[zeros(counter-1,1);crispHistogram;zeros(numel(membership)-counter,1)];
end

fuzzyHistogram = fuzzyHistogram(ceil(numel(membership)/2):end-floor(numel(membership)/2));

del1FuzzyHistogram = [0;(fuzzyHistogram(3:end)-fuzzyHistogram(1:end-2))/2;0];
del2FuzzyHistogram = [0;(del1FuzzyHistogram(3:end)-del1FuzzyHistogram(1:end-2))/2;0];

locationIndex = (2:numel(fuzzyHistogram)-1)'+1;

maxLocAmbiguous = locationIndex(((del1FuzzyHistogram(1:end-2).*del1FuzzyHistogram(3:end))<0) & (del2FuzzyHistogram(2:end-1)<0));

counter = 1;

maxLoc = 1;

while counter < numel(maxLocAmbiguous)
    if (maxLocAmbiguous(counter)==(maxLocAmbiguous(counter+1)-1))
        maxLoc = [maxLoc ; (maxLocAmbiguous(counter)*(fuzzyHistogram(maxLocAmbiguous(counter))>fuzzyHistogram(maxLocAmbiguous(counter+1)))) + (maxLocAmbiguous(counter+1)*(fuzzyHistogram(maxLocAmbiguous(counter))<=fuzzyHistogram(maxLocAmbiguous(counter+1))))];
        counter = counter + 2;
    else
        maxLoc = [maxLoc ; maxLocAmbiguous(counter)];
        counter = counter + 1;
    end
end
if(maxLoc(end)~=numel(fuzzyHistogram))
    maxLoc = [maxLoc ; numel(fuzzyHistogram)];
end

low = maxLoc(1:end-1);
high = [maxLoc(2:end-1)-1;maxLoc(end)];
span = high-low;
cumulativeHistogram = cumsum(fuzzyHistogram);
M = cumulativeHistogram(high)-cumulativeHistogram(low);
factor = span .* log10(M);
range = max(grayScales)*factor/sum(factor);

transformationMap = zeros(numel(grayScales),1);

for counter = 1:length(low)
    for index = low(counter):high(counter)
        transformationMap(index) = round((low(counter)-1) + (range(counter)*(sum(fuzzyHistogram(low(counter):index)))/(sum(fuzzyHistogram(low(counter):high(counter))))));
    end
end

out = transformationMap(I+1);

out = mean(I(:))/mean(out(:))*out;

out = cast(out,imageType);

if strcmp(imageType,'single')
    out = minGray + (maxGray-minGray)*mat2gray(out);
elseif strcmp(imageType,'double')
    out = minGray + (maxGray-minGray)*mat2gray(out);
end
%out = imcomplement(out);
end