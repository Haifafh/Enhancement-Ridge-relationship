function filter = createGaussianFilter(order,sigma,params)

% Function Create Gaussian Filter
%
%  function [filter] = createGaussianFilter(order,sigma)
%  function [filter] = createGaussianFilter(order,sigma,params)
%
%   Produces a gaussian filter of order 0, 1 or 2 with a given sigma.
%   The user can also specificy
%       directionality, anisotropy index and size.
%   The size of the filter can be forced, although it is strongly
%       recommended to to make it too small.
%   In any case, if specified, the size will be that given by the user,
%       unless it is even (if so, it will be added a unit)
%  
%   The filter is NOT normalized in any manner.
%
%
% [Inputs]
%   order(mandatory)- Can be expressed as an integer in {1,2,3}, or a
%       string in {'1','1D','1d','2','2D','2d','3','3d','3D'}.
%   sigma(mandatory)- Positive float speficying the stdev.
%   params(optional)- Structure potentially including this fields:
%       params.rho (default=1)- Anisotropy index.
%       params.theta (default=0)- orientation of the filter, in radians.
%       params.size (default=round(sigma*max(1,1/rho)*9))- Lateral size of the filter,
%           which btw will be squared. Should be odd, otherwise will be added 
%           a unit.    
%
%
% [outputs]
%   filter- The requested Gaussian filter;
%
% [usages]
%   
%
% [author]
%   Carlos Lopez-Molina (carlos.lopez@unavarra.es)
%
%
% [references]
%	-
%

%
% Version control-
%	2014.02 Release 
%   2014.04.06 Corrected incidence with even size in case sigma param was defined
%       and size param was not.
%

%
%	0- Validate Arguments 
%

assert(nargin>1,'Error at createGaussianFilter: Too few arguments');
assert(nargin<4,'Error at createGaussianFilter: Too many arguments');
assert(sigma>0,'Error at createGaussianFilter: Negative sigma is not allowed');

order=parseFilterOrder(order);
if (nargin==2) %defaults
    params.rho=1;
    params.theta=0;
    params.size=round(sigma*max(1,1/params.rho)*9);
else %nargin==3
    params=checkParams(params,sigma);
end


%
%	1- Preprocessing
%

nHalfSize=(params.size-1)/2;
xs=repmat([-nHalfSize:nHalfSize],params.size,1);
ys=-xs';
sigmaSqr=sigma*sigma;

%
%	2- Processing
%

xs2=params.rho.*(xs.*cos(params.theta)+ys.*sin(params.theta));
ys2=(1/params.rho).*(xs.*(-sin(params.theta))+ys.*cos(params.theta));

switch order
    case 0,
        filter=(1/(2*pi*sigmaSqr)).*exp(-(xs2.^2+ys2.^2)/(2*sigmaSqr));
    case 1,
        z0b=(1/(2*pi*sigmaSqr)).*exp(-(xs2.^2+ys2.^2)/(2*sigmaSqr));
        filter=(-xs2./sigmaSqr).*z0b;
    case 2,
        z0b=(1/(2*pi*sigmaSqr)).*exp(-(xs2.^2+ys2.^2)/(2*sigmaSqr));
        filter=(xs2./sigmaSqr).*(xs2./sigmaSqr).*z0b-(z0b./sigmaSqr);
end



function newParams=checkParams(params,sigma)

    newParams=params;

    % Param rho
    if isfield(newParams,'rho')
        assert(newParams.rho>0,'Error at createGaussianFilter: Invadid parameter rho');
    else
        newParams.rho=1;
    end
    % Param theta
    if ~isfield(newParams,'theta')
        newParams.theta=0;
    end 
    % Param size
    if isfield(newParams,'size')
        assert(newParams.size>0,'Error at createGaussianFilter: Invadid parameter size');
        if(mod(newParams.size,2)==0)
            newParams.size=newParams.size+1;
        end
    else
        newParams.size=round(sigma*max(1,1/params.rho)*9);
        if(mod(newParams.size,2)==0) %Corrected 2014/06/16
            newParams.size=newParams.size+1;
        end
    end

return


function intOrder=parseFilterOrder(ord)

%procesing the order
if (ischar(ord))
    ord=regexprep(ord,'d','');
    ord=regexprep(ord,'D','');
    ord=str2num(ord);
    assert(~isempty(ord),'Error at createGaussianFilter: order could not be parsed');
end
if (isnumeric(ord))
    assert(round(ord)==ord,'Error at createGaussianFilter: order must be an integer');
    assert(ord>=0,'Error at createGaussianFilter: order must be positive');
    assert(ord<=2,'Error at createGaussianFilter: order must be 1, 2 or 3');
end

intOrder=ord;

return


