 function g = gaussian1D(x,s,o,n)
% x - values
% s - sigma
% o - order=0,1,2
% n - normalise=0,1
%% Parameters
if isempty(n); n = false; end
%% Base
gb = exp(-(x.*x)/(2*s^2));
% %% Normalise
% if (n)
%     gb = s*gb;
% end
%% Gaussian
if o==0            
    g = (1/(s*sqrt(2*pi))).*gb;
elseif o==1
    g = -(x./(s^3*sqrt(2*pi))).*gb;
elseif o==2
   g = -gb./(s^3*sqrt(2*pi))+x.*x.*gb/(s^5*sqrt(2*pi));
%    g=gb.*((x.*x)-(s^2))./(s^5*sqrt(2*pi));
end
%% Normalise
if (n)
    %g = (g - min(g(:))) / (max(g(:)) - min(g(:)));
    g = g./sum(g);
end
end