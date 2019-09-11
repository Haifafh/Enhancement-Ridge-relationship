function g = GaussianFilterN1D(s,o)
%% Test sigma size
smin = 0.5 + s^(0.62) / 5;
s = max(s,smin);
%% Calculate coordinates range
f = 3 + 0.25 * o - 2.5/((o-6)^2+(o-9)^2); 
sd = ceil(f*s);
%% Grid coordinates
x = (-sd:sd)';
%x = (-3*s:3*s)';
%% Gaussian
g = gaussianN1D(x,s,o);
end