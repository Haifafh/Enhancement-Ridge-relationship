function h = hermite1D(x,o)
syms t; 
Hs = hermiteH(o,t);
H = @(t) subs(Hs,'t',t);
h = double(H(x));
%% HELP for JAVA/C++ implementation
% H_n(x)=(-1)^n e^(x^2) d^n/dx^n (e^(-x^2))
%
% H_(n+1)(x) = 2x H_n(x) - 2n H_(n-1)(x)
% H_n(x) = 2n H_(n-1)(x)
%%
% if(0==n) 
%     h = 1;
% elseif(n==1)
%     h = [2 0];
% else
%    h1 = zeros(1,n+1);
%    h1(1:n) = 2*Hermite1D(n-1);
% 
%    h2 = zeros(1,n+1);
%    h2(3:end) = 2*(n-1)*Hermite1D(n-2);
% 
%    h = h1 - h2;
% end
end