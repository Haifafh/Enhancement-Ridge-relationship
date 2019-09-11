function [Dx,Dy,GM] = gradient_magnitude(I,Sigma)

    if nargin < 2, Sigma = 1; end

    % Make kernel coordinates
    [X,Y]   = ndgrid(-round(3*Sigma):round(3*Sigma));

    % Compute Gaussian derivatives wrt x and y
    DGaussx = -(((Sigma)*1)/(((2*pi))*Sigma^4)) * (X) .* exp(-(X.^2+Y.^2)/(2*Sigma^2));
    DGaussy = -(((Sigma)*1)/(((2*pi))*Sigma^4)) * (Y) .* exp(-(X.^2+Y.^2)/(2*Sigma^2));

    % apply Gaussian derivatives to input image
    Dx = imfilter(I,DGaussx,'conv');
    Dy = imfilter(I,DGaussy,'conv');

    %compute Gradient
    GM = sqrt(Dx.^2+Dy.^2);
end
