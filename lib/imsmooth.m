function J = imsmooth(I, name, varargin)
  %% Check inputs
  if (nargin == 0)
    print_usage();
  end
  [imrows, imcols, imchannels, tmp] = size(I);
  if ((imchannels ~= 1 && imchannels ~= 3) || tmp ~= 1)
    error('imsmooth: first input argument must be an image');
  end
  if (nargin == 2 && isscalar (name))
    varargin {1} = name;
    name = 'Gaussian';
  end
  if (~ischar(name))
    error('imsmooth: second input must be a string');
  end
  len = length(varargin);

  %% Save information for later
  C = class(I);

  %% Take action depending on 'name'
  switch (lower(name))
    %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
    %%%   Gaussian smoothing   %%%
    %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
    case 'gaussian'
      %% Check input
      s = 0.5;
      if (len > 0)
        if (isscalar(varargin{1}) && varargin{1} > 0)
          s = varargin{1};
        else
          error('imsmooth: third input argument must be a positive scalar when performing Gaussian smoothing');
        end
      end
      %% Compute filter
      h = ceil(3*s);
      f = exp( (-(-h:h).^2)./(2*s^2) ); 
      f = f / sum(f);
      %% Pad image
      I = double (padarray (I, [h h], 'symmetric'));
      %% Perform the filtering
      for i = imchannels:-1:1
        J(:,:,i) = conv2(f, f, I(:,:,i), 'valid');
      end

    %%%%%%%%%%%%%%%%%%%%%%%%%%%%
    %%%   Square averaging   %%%
    %%%%%%%%%%%%%%%%%%%%%%%%%%%%
    case 'average'
      %% Check input
      s = [3, 3];
      if (len > 0)
        if (isscalar(varargin{1}) && varargin{1} > 0)
          s = [varargin{1}, varargin{1}];
        elseif (isvector(varargin{1}) && length(varargin{1}) == 2 && all(varargin{1} > 0))
          s = varargin{1};
        else
          error('imsmooth: third input argument must be a positive scalar or two-vector when performing averaging');
        end
      end
      %% Compute filter
      f2 = ones(1,s(1))/s(1);
      f1 = ones(1,s(2))/s(2);
      %% Pad image
      I = padarray (I, floor ( [s(1) s(2)]   /2), 'symmetric', 'pre');
      I = padarray (I, floor (([s(1) s(2)]-1)/2), 'symmetric', 'post');
      I = double (I);
      %% Perform the filtering
      for i = imchannels:-1:1
        J(:,:,i) = conv2 (f1, f2, I(:,:,i), 'valid');
      end

    %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
    %%%   Circular averaging   %%%
    %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
    case 'disk'
      %% Check input
      r = 5;
      if (len > 0)
        if (isscalar(varargin{1}) && varargin{1} > 0)
          r = varargin{1};
        else
          error('imsmooth: third input argument must be a positive scalar when performing averaging');
        end
      end
      %% Compute filter
      f = fspecial('disk', r);
      %% Pad image
      i = double (padarray (I, [r r], 'symmetric'));
      %% Perform the filtering
      for i = imchannels:-1:1
        J(:,:,i) = conv2(I(:,:,i), f, 'valid');
      end

    %%%%%%%%%%%%%%%%%%%%%%%%%%%%
    %%%   Median Filtering   %%%
    %%%%%%%%%%%%%%%%%%%%%%%%%%%%
    case 'median'
      %% Check input
      s = [3, 3];
      if (len > 0)
        opt = varargin{1};
        if (isscalar(opt) && opt > 0)
          s = [opt, opt];
        elseif (isvector(opt) && numel(opt) == 2 && all(opt>0))
          s = opt;
        else
          error('imsmooth: third input argument must be a positive scalar or two-vector');
        end
        s = round(s); % just in case the use supplies non-integers.
      end
      %% Perform the filtering
      for i = imchannels:-1:1
        J(:,:,i) = medfilt2(I(:,:,i), s, 'symmetric');
      end

    %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
    %%%   Bilateral Filtering   %%%
    %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
    case 'bilateral'
      %% Check input
      
      if (len > 0 && ~isempty(varargin{1}))
        if (isscalar(varargin{1}) && varargin{1} > 0)
          sigma_d = varargin{1};
        else
          error('imsmooth: spread of closeness function must be a positive scalar');
        end
      else
        sigma_d = 2;
      end
      if (len > 1 && ~isempty(varargin{2}))
        if (isscalar(varargin{2}) && varargin{2} > 0)
          sigma_r = varargin{2};
        else
          error('imsmooth: spread of similarity function must be a positive scalar');
        end
      else
        sigma_r = 10/255;
        if (isinteger(I))
            sigma_r = sigma_r *intmax(C); 
        end
      end
      %% Pad image
      s = max([round(3*sigma_d),1]);
      I = padarray (I, [s s], 'symmetric');
      %% Perform the filtering
      J = bilateral__(I, sigma_d, sigma_r);

    %%%%%%%%%%%%%%%%%%%%%%%%%%%%
    %%%   Perona and Malik   %%%
    %%%%%%%%%%%%%%%%%%%%%%%%%%%%
    case {'perona & malik', 'perona and malik', 'p&m'}
      %% Check input
      K = 25;
      method1 = @(d) exp(-(d./K).^2);
      method2 = @(d) 1./(1 + (d./K).^2);
      method = method1;
      lambda = 0.25;
      iter = 10;
      if (len > 0 && ~isempty(varargin{1}))
        if (isscalar(varargin{1}) && varargin{1} > 0)
          iter = varargin{1};
        else
          error('imsmooth: number of iterations must be a positive scalar');
        end
      end
      if (len > 1 && ~isempty(varargin{2}))
        if (isscalar(varargin{2}) && varargin{2} > 0)
          lambda = varargin{2};
        else
          error('imsmooth: fourth input argument must be a scalar when using Perona & Malik');
        end
      end
      if (len > 2 && ~isempty(varargin{3}))
        fail = false;
        if (ischar(varargin{3}))
          if (strcmpi(varargin{3}, 'method1'))
            method = method1;
          elseif (strcmpi(varargin{3}, 'method2'))
            method = method2;
          else
            fail = true;
          end
        elseif (strcmp(typeinfo(varargin{3}), 'function handle'))
          method = varargin{3};
        else
          fail = true;
        end
        if (fail)
          error('imsmooth: fifth input argument must be a function handle or the string method1 or method2 when using Perona & Malik');
        end
      end
      %% Perform the filtering
      I = double(I);
      for i = imchannels:-1:1
        J(:,:,i) = pm(I(:,:,i), iter, lambda, method);
      end

    %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
    %%%   Custom Gaussian Smoothing   %%%
    %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
    case 'custom gaussian'
      %% Check input
      if (length (varargin) < 2)
        error ('imsmooth: not enough input arguments');
      elseif (length (varargin) == 2)
        varargin {3} = 0; % default theta value
      end
      arg_names = {'third', 'fourth', 'fifth'};
      for k = 1:3
        if (isscalar (varargin {k}))
          varargin {k} = repmat (varargin {k}, imrows, imcols);
        elseif (isnumeric (varargin {k}) && ismatrix (varargin {k}))
          if (rows (varargin {k}) ~= imrows || columns (varargin {k}) ~= imcols)
            error (['imsmooth: %s input argument must have same number of rows '
                    'and columns as the input image'], arg_names {k});
          end
        else
          error ('imsmooth: %s input argument must be a scalar or a matrix', arg_names {k});
        end
        if (~strcmp (class (varargin {k}), 'double'))
          error ('imsmooth: %s input argument must be of class double', arg_names {k});
        end
      end

      %% Perform the smoothing
      for i = imchannels:-1:1
        J(:,:,i) = custom_gaussian_smoothing__ (I(:,:,i), varargin {:});
      end

    %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
    %%%   Mean Shift Based Smoothing   %%%
    %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
    % NOT YET IMPLEMENTED
    %case 'mean shift'
    %  J = mean_shift(I, varargin{:});

    %%%%%%%%%%%%%%%%%%%%%%%%%%%%%
    %%%   Unknown filtering   %%%
    %%%%%%%%%%%%%%%%%%%%%%%%%%%%%
      otherwise
      error('imsmooth: unsupported smoothing type %s', name);
  end

  %% Cast the result to the same class as the input
  J = cast(J, C);
end

%% Perona and Malik for gray-scale images
function J = pm(I, iter, lambda, g)
  %% Initialisation
  [imrows, imcols] = size(I);
  J = I;

  for i = 1:iter
    %% Pad image
    padded = padarray (J, [1 1], 'circular');

    %% Spatial derivatives
    dN = padded(1:imrows, 2:imcols+1) - J;
    dS = padded(3:imrows+2, 2:imcols+1) - J;
    dE = padded(2:imrows+1, 3:imcols+2) - J;
    dW = padded(2:imrows+1, 1:imcols) - J;

    gN = g(dN);
    gS = g(dS);
    gE = g(dE);
    gW = g(dW);

    %% Update
    J = J + lambda*(gN.*dN + gS.*dS + gE.*dE + gW.*dW);
  end
end

% %% Mean Shift smoothing for gray-scale images
% %% XXX: This function doesn't work~~
% %{
% function J = mean_shift(I, s1, s2)
%   sz = [size(I,2), size(I,1)];
%   %% Mean Shift
%   [x, y] = meshgrid(1:sz(1), 1:sz(2));
%   f = ones(s1);
%   tmp = conv2(ones(sz(2), sz(1)), f, 'same'); % We use normalised convolution to handle the border
%   m00 = conv2(I, f, 'same')./tmp;
%   m10 = conv2(I.*x, f, 'same')./tmp;
%   m01 = conv2(I.*y, f, 'same')./tmp;
%   ms_x = round( m10./m00 ); % konverter ms_x og ms_y til lin??re indices og arbejd med dem~
%   ms_y = round( m01./m00 );
% 
%   ms = sub2ind(sz, ms_y, ms_x);
%   %for i = 1:10
%   i = 0;
%   while (true)
%     disp(++i)
%     ms(ms) = ms;
%     %new_ms = ms(ms);
%     if (i >200), break; end
%     %idx = ( abs(I(ms)-I(new_ms)) < s2 );
%     %ms(idx) = new_ms(idx);
%     %for j = 1:length(ms)
%     %  if (abs(I(ms(j))-I(ms(ms(j)))) < s2)
%     %    ms(j) = ms(ms(j));
%     %  end
%     %end
%   endwhile
%   %end
% 
%   %% Compute result
%   J = I(ms);
% end