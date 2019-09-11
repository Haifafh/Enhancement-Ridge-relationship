function out = contrastAdaptHistEq(I, params)
%% Desicription:
%  Contrast-limited adaptive histogram equalization (CLAHE)
%% Reference:
%  [1] Zuiderveld, Karel. "Contrast Limited Adaptive Histograph Equalization.
%   " Graphic Gems IV. San Diego: Academic Press Professional, 1994. 474?485.
%% Code
%% CLAHE
    out = adapthisteq(I);
end