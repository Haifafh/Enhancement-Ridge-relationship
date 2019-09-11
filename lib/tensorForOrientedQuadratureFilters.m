function T = tensorForOrientedQuadratureFilters(q,ang)
%%  BOTensor - calculate 2D tensor of the image
%   
%   REFERENCE:
%       Hans Knutsson, 
%       Representing local structure using tensors, 
%       The 6th Scandinavian Conference on Image Analysis, Oulu, Finland, 
%       June 1989
%
%   INPUT:
%       im - 2D gray image
%       s  - Gaussian kernel sigma
%
%   OUTPUT:
%       T  - 2D tensor
%
%   HELP:
%       T = SUMi(|qi|(nini' - I) 
%       where: 
%           qi - response of i-th quadrature filter in the spatial domain
%
%   USAGE:
%       T = BOTensor(im,3)
%
%   AUTHOR:
%       Boguslaw Obara, http://boguslawobara.net/
%
%   VERSION:
%       0.1 - 07/12/2009 First implementation

%% Orientation vectors
ang = ang';
n = [cos(ang) sin(ang)];
%% Tensor
I = eye(2,2);
T = zeros(size(q,1),size(q,2),4);
for i=1:length(ang)
    nnT = kron(n(i,:),n(i,:)');
    %nnTI = (nnT-1/(4-1).*I); %alpha = 1/(m-1) where m = size of T
    %nnTI = (nnT-(1/(2-1)).*I); %alpha = 1/(m-1) where m = dimensionality of T    
    %nnTI = (nnT-(1/(length(ang)-1)).*I); %alpha = 1/(m-1) where m = nr of filters
    %nnTI = (nnT-(1/(2+1)).*I); %alpha = 1/(m+1) where m = dimensionality of T (A FRAMEWORK FOR ESTIMATION OF ORIENTATION AND VELOCITY)     
    nnTI =nnT;
    T(:,:,1) = T(:,:,1) + q(:,:,i)*nnTI(1,1);
    T(:,:,2) = T(:,:,2) + q(:,:,i)*nnTI(1,2);
    T(:,:,3) = T(:,:,3) + q(:,:,i)*nnTI(2,1);
    T(:,:,4) = T(:,:,4) + q(:,:,i)*nnTI(2,2);
end
%% 
end