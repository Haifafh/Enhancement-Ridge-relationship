function out = topHat(I,params)
%% Description:
% Top-hat enhancement
%% Reference
% Chen, Ting, et al. "A pseudo top-hat mathematical morphological approach 
% to edge detection in dark regions." Pattern Recognition 35.1 (2002): 199-210.?
%% Code
I =double(I);
gamma_L = zeros(size(I));
for i=0:params(1):params(2)
    se = strel('line',params(1),i);
    gamma_Li = imopen(I,se);
    gamma_L = max(gamma_L,gamma_Li);
end

S_op = imreconstruct(I,gamma_L);

out = zeros(size(I));
for i=0:params(1):params(2)
    se = strel('line',params(1),i);
    gamma_Li = imopen(I,se);
    out = out + (S_op - gamma_Li);
    
end
out=(out-min(out(:)))/(max(out(:))-min(out(:)));
%out = imcomplement(out);
end