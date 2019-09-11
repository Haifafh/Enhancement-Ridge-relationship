function out = morphSkeleton(I, params)
%% Skeletonization of grayscale image with some prior dilation amount
if nargin == 0; out = 1; return; end
%% Code
D = imdilate(I>0.55, strel('disk', params(1))); % investigate if its better to put >0.5 after or before imdilate
out = bwmorph(D, 'skel', inf); 
end