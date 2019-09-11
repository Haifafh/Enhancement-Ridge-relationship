function out = adaptiveThresh(I, params)
%% Adaptive thresholding
%  0 = sensitivity
%% Code
out = imbinarize(I, adaptthresh(I,params(1)));
 end