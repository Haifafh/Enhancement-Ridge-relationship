function q = localTensorConvolution(im,Q,ang)
%%  LocalTensor2D - calculate 2D tensor of the image
%   
%   REFERENCE:
%       Hans Knutsson, 
%       Representing local structure using tensors, 
%       The 6th Scandinavian Conference on Image Analysis, Oulu, Finland, 
%       244???251, June 1989
%
%   INPUT:
%       im - 2D gray image
%       Q  - 2D log-normal quadrature filters
%
%   OUTPUT:
%       q  - 2D convolved images
%
%   USAGE:
%       ang = ((1:ndir)-1)*2*pi/ndir;
%       n = [cos(ang) sin(ang)];
%       B = 2; rhoi = pi/32;
%       Q = BOLogNormalQuadratureFilters2D(im,rhoi,B,n);
%       q = BOLocalTensorConvolution2D(im,Q,ang)
%
%   AUTHOR:
%       Boguslaw Obara, http://boguslawobara.net/
%
%   VERSION:
%       0.1 - 05/02/2013 First implementation

%% Filter
[m,n] = size(im); ndir = length(ang);
q = zeros(m,n,ndir);
for i=1:ndir
    imfft = fftshift(fft2(im));
    q(:,:,i) = abs(ifft2(imfft.*Q(:,:,i)));
end
%% 
end