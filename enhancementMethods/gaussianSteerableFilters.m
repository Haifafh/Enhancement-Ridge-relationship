function out = gaussianSteerableFilters(I,params)
%% HELP
% Jacob M, Unser M,
% Design of Steerable Filters for Feature. 
% Detection Using Canny-Like Criteria,
% IEEE Trans Pattern Anal Mach Intell. 2004 Aug;26(8):1007-19
%% Temp 
% params = [2,300,1.99];
% s = 0.2; theta = 300; M = 1.99;
%% Code
%I=imcomplement(I);
%% Normalize image
I = double(I); I = (I - min(I(:))) / (max(I(:)) - min(I(:))); 
%% Steerable Filters
s = params(1); theta = params(2); M = params(3);
%disp('    k,    i,    j,    l,    m,    u0,    u1,    u2,    c');
out = zeros(size(I));
for k=1:M
    for i=0:k
        b = steerableFiltersWeights(k,i,theta);
        imf = gaussianConvND(I,s,[k,i]);
        out = out + b.*imf;
    end
end
end