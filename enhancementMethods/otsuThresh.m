function out = otsuThresh(I, params)
%% Otsu's thresholding with no parameters
if nargin == 0; out = 0; return; end
%% Code
out = imbinarize(I);
end