function im = gaussianConvND(I,s,o)
ds = ndims(I);  % number of dimensions
if numel(o)~=ds
    error([mfilename ': o == ds !']);
end
%% Convolve in each dimension
for d=1:ds
    % create kernel in appropriate direction
    g = gaussianFilterN1D(s,o(d));
    % shift the dimension of the kernel
    g = shiftdim(g,-(d-1));
    % convolve
    im = imfilter(I,g,'symmetric','same' );
end
end