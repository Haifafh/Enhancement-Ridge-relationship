function out = localHistEq(I,params)
%% Description:
% Local Histogram Equalization
%% Reference :
%  Zhu, Hui, Francis HY Chan, and Francis K. Lam. "Image contrast enhancement by
%  constrained local histogram equalization." Computer vision and image understanding 73.2 (1999): 281-290.?
%% Code
I =im2double(I);
M = mean2(I);
z = colfilt(I,[params(1) params(1)],'sliding',@std);
m = colfilt(I,[params(1) params(1)],'sliding',@mean);
A = params(2)*M./z;
out = A.*(I - m)+ m;
out= normalize(out);
%out = 1-out;
end