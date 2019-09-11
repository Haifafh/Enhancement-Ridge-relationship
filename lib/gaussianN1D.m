function g = gaussianN1D(x,s,o)
%% Help
% n-th derivative of (e^(-x^2)) = (-1)^n Hn(x) e^(-x^2)
% n-th derivative of G(x,s) = (-1)^n (1/((s sqrt(2)))^n) ... 
%                               Hn(x/(s sqrt(2))) G(x,s)
% o -> n - order
%% Hermite
H = hermite1D(x./(s*sqrt(2)),o);
%% Gaussian
G = gaussian1D(x,s,0,1);
%% N-th Derivative
g = ((-1)^o) * (1/((s*sqrt(2)))^o) .* H .* G; 
%figure; plot(H,'-r'); hold on; plot(G,'-g')
end