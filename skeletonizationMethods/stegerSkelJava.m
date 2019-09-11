function  out = stegerSkelJava(I,params)
%% Description
%    A well-known differential geometric line extraction algorithm
%% Reference
%    C. Steger, ?An unbiased detector of curvilinear structures?, 
%    IEEE Transactions on Pattern Analysis and Machine Intelligence,
%    20(2), pp. 113-125, 1998.
%% AUTHORS:
%    Philip T. G. Jackson (Durham University)
%% Code
%% Setup Java dynamic classpath

serverDir ='C:\Users\haifa\Documents\';
%serverDir = '/mnt/storage/home/haifa/';
javaaddpath(strcat(serverDir,'curvilinear-methods\code\lib\BOMatlabImageJ\jar\bomij.jar'));
javaaddpath(strcat(serverDir,'curvilinear-methods\code\lib\BOMatlabImageJ\jar\ij.jar'));
javaaddpath(strcat(serverDir,'curvilinear-methods\code\lib\JAR\ij.jar'));
javaaddpath(strcat(serverDir,'curvilinear-methods\code\lib\JAR\steger.jar'));
javaaddpath(strcat(serverDir,'curvilinear-methods\code\lib\JAVA\steger\lib/commons-lang3-3.4.jar'));
%% clear java
%fprintf('Done\n');
% import ij.* ;
% import bomij.*;
% import steger.*;
% import commons-lang3-3.4.*;
%% Parameters

w = params(1);
sigma = double((w)/(2*sqrt(3)));
conLow = params(2);
conHigh = params(3); % Normlize highest contrast to 0-255
Tu = floor(0.17*2*conHigh*(w/2)*exp(-(w/2)^2 / (2*sigma^2)) / (sqrt(2*pi)*sigma^3));
Tl = floor(0.17*2*conLow*(w/2)*exp(-(w/2)^2 / (2*sigma^2)) / (sqrt(2*pi)*sigma^3));
%% Save enhanced images temproray
name1= 'C:\Users\haifa\Documents\curvilinear-methods\code';
name2 = tempname;
%filename =strcat(name1,name2);
filename =tempname;
imwrite(I,strcat(filename,'.tif'));
%% Create Java objects
% import ij.io.Opener.*;
% import de.biomedical_imaging.ij.steger.LineDetector.*;
opener = ij.io.Opener;
implus = opener.openImage(strcat(filename,'.tif'));
region = I;   %for use in MATLAB
ip = implus.getProcessor();
ld = de.biomedical_imaging.ij.steger.LineDetector;
%% Run Steger line detection
try
    lines = ld.detectLines(ip, sigma, Tu, Tl, false, true, false, true);
catch e
     %e.message
    if(isa(e,'matlab.exception.JavaException'))
        out = double(zeros(size(I)));
        delete(strcat(filename,'.tif'));
    return
    end
end
try % in case of Matalb error
%% Plot lines, coloured by tortuosity
%fprintf('Found %d lines\n', lines.size());
if lines.size()==0
    out = double(zeros(size(I)));
    delete(strcat(filename,'.tif'));
    return 
end
T = [];
br = [];
for i = 0:(lines.size()-1)
    line = lines.get(i);
    x = line.getXCoordinates + 1;
    y = line.getYCoordinates + 1;
    
    mask = (~isnan(x)) & (~isnan(y));
    x = x(mask);
    y = y(mask);
    len = sum(sqrt(diff(x).^2+diff(y).^2)); %total length of curve
    endpointdist = sqrt((x(end)-x(1))^2 + (y(end)-y(1))^2);
    tortuosity = len / endpointdist;
    T(end+1) = tortuosity;
    red = 1/(1+exp(-tortuosity+1));
    if isnan(red)
        continue
    end
end

%% Make binary image
mask = false(size(region));
for i = 0:(lines.size()-1)
    line = lines.get(i);
    x = line.getXCoordinates + 1;
    y = line.getYCoordinates + 1;
    I = round(y);
    J = round(x);
    idx = sub2ind(size(region), I, J);
    mask(idx) = true;
end
%figure, imshow(mask);


CC = bwconncomp(mask);
% sort the connected components by size:
sizes = cellfun(@length, CC.PixelIdxList);
[~, ind] = sort(sizes, 'descend');
CC.PixelIdxList = CC.PixelIdxList(ind);

% show the n biggest lines:
range = size(CC.PixelIdxList,2)-1;
n = floor((params(4)* range)+1);

out = false(size(region));
for i = 1:n
out(CC.PixelIdxList{i}) = true;
end
%clean up
% delete(strcat(filename,'.tif'));
catch
    out = double(zeros(size(I)));
    delete(strcat(filename,'.tif'));
    return
end
delete(strcat(filename,'.tif'));
%figure, imshow(out);
% 
%figure, plot(cellfun(@length, CC.PixelIdxList));

% branchPoints = bwmorph(bwmorph(mask,'skel',Inf), 'branchpoints');
% branchRatio = [];
% meanBranchSize = [];
% branchIdx = find(branchPoints);
% for i = 1:CC.NumObjects
%     idx = CC.PixelIdxList{i};
%     a = repmat(idx, 1, length(branchIdx));
%     b = repmat(branchIdx', length(idx), 1);
%     branchRatio(i) = sum(sum(a == b)) / length(idx);        % number of branch points / number of pixels
%     meanBranchSize(i) = length(idx) / (sum(sum(a==b))+1);   % number of pixels / number of branches = mean branch size
% end
% %figure, plot(branchRatio);
% 
% goodlineslog = meanBranchSize > mean(meanBranchSize);
% goodlines = CC.PixelIdxList(goodlineslog);
% goodmask = false(size(region));
% for i = 1:length(goodlines)
%     goodmask(goodlines{i}) = true;

% end
% %figure, imshow(goodmask);
% coolout = cat(3, double(mask), double(goodmask), double(goodmask));
% %figure, imshow(coolout);
% 
% goodlinesidx = find(goodlineslog);
% biggestGoodLines = CC.PixelIdxList(goodlinesidx);
% % show the n biggest lines:
% n = 1;
% out2 = false(size(region));
% for i = 1:n
% out2(biggestGoodLines{i}) = true;
% end
% goodlineslog = meanBranchSize > mean(meanBranchSize);
% goodlines = CC.PixelIdxList(goodlineslog);
% goodmask = false(size(region));
% for i = 1:length(goodlines)
%     goodmask(goodlines{i}) = true;
% end
% %figure, imshow(goodmask);
% coolout = cat(3, double(mask), double(goodmask), double(goodmask));
% %figure, imshow(coolout);
% 
% goodlinesidx = find(goodlineslog);
% biggestGoodLines = CC.PixelIdxList(goodlinesidx);
% % show the n biggest lines:
% n = 1;
% out1 = false(size(region));
% for i = 1:n
% out1(biggestGoodLines{i}) = true;
% end
% out1= double(out1);
% %figure, imshow(out);
%clear ij.io.Opener.* de.biomedical_imaging.ij.steger.LineDetector.*;
end