function [orMap,magnMap]=components2orientations(fx,fy)

% Function Components to Orientations
%
%  function [orMap,magnMap] = components2orientations(fx,fy)
%
%  Converts a gradient map given in cartesian coordinates to one
%   in polar ones.
%
% [Inputs]
%
%   fx(mandatory)- Horizontal components. It can have more than 2
%       dimensions.
%   fy(mandatory)- Vertical components. It must be
%       the same size as orMap.
%
% [outputs]
%
%   orMap- Orientation at each pixel
%   magnMap- Magnitude of the vector at each pixel
%
% [notes]
%
%   The angular convention used takes the East (E) as 0 degrees,
%       and increases counterclockwise.
%   Hence, pi/2 is N, pi is W and 3*pi/2 is S.
%
% [usages]
%   -
%
% [author]
%   Carlos Lopez-Molina (carlos.lopez@unavarra.es)
%
%
% [references]
%   -
%

%
%	0- Validate Arguments 
%
assert(nargin==2,'Error at orientations2components: Wrong number of arguments.');
assert(min(size(fx)==size(fy))==1,'Error at orientations2components: The input matrices must be the same size.');

%
%	1- Processing
%

orMap = atan(fy./fx);
orMap(fx<0)=orMap(fx<0)+pi;
orMap(and(fx>=0,fy<0))=orMap(and(fx>=0,fy<0))+2*pi;

magnMap=sqrt(fx.^2+fy.^2);