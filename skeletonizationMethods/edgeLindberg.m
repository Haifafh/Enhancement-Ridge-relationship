function out = edgeLindberg(I, params)
%% Description:
% Edge Detection and Ridge Detection with Automatic Scale Selection
%% Reference:
% Lindeberg, Tony. "Edge detection and ridge detection with automatic scale selection."
% Computer Vision and Pattern Recognition, 1996. Proceedings CVPR'96, 1996 IEEE Computer
% Society Conference on. IEEE, 1996.?
%% Copyright (C) 1999 Andy Adler <adler@sce.carleton.ca>
%% Copyright (C) 2008 Søren Hauberg <soren@hauberg.org>
%% Copyright (C) 2015 Hartmut Gimpel <hg_code@gmx.de>
%% Copyright (C) 2015 Carnë Draug <carandraug@octave.org>
%% Code
  if (nargin > 1 && (~ isnumeric (params(1)) || ~ isscalar (params(1))))
    error ('edge: SIGMA for Lindeberg method must be a numeric scalar');
  end

  %% Filters for computing the derivatives
  Px   = [-1 0 1; -1 0 1; -1 0 1];
  Py   = [1 1 1; 0 0 0; -1 -1 -1];
  Pxx  = conv2 (Px,  Px, 'full');
  Pyy  = conv2 (Py,  Py, 'full');
  Pxy  = conv2 (Px,  Py, 'full');
  Pxxx = conv2 (Pxx, Px, 'full');
  Pyyy = conv2 (Pyy, Py, 'full');
  Pxxy = conv2 (Pxx, Py, 'full');
  Pxyy = conv2 (Pyy, Px, 'full');
  %% Change scale
  L = imsmooth (double (I), 'Gaussian', params(1));
  %% Compute derivatives
  Lx   = conv2 (L, Px,   'same');
  Ly   = conv2 (L, Py,   'same');
  Lxx  = conv2 (L, Pxx,  'same');
  Lyy  = conv2 (L, Pyy,  'same');
  Lxy  = conv2 (L, Pxy,  'same');
  Lxxx = conv2 (L, Pxxx, 'same');
  Lyyy = conv2 (L, Pyyy, 'same');
  Lxxy = conv2 (L, Pxxy, 'same');
  Lxyy = conv2 (L, Pxyy, 'same');
  %% Compute directional derivatives
  Lvv  = Lx.^2.*Lxx + 2.*Lx.*Ly.*Lxy + Ly.^2.*Lyy;
  Lvvv = Lx.^3.*Lxxx + 3.*Lx.^2.*Ly.*Lxxy ...
         + 3.*Lx.*Ly.^2.*Lxyy + 3.*Ly.^3.*Lyyy;
  %% Perform edge detection
  out = zerocrossings (Lvv) & Lvvv < 0;
  % remove small variation of edge detection functional
  out(abs(out)<params(2))= 0;
  out=double(out);
end
