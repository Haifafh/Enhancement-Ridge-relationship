function logGabor = logGabor2D(im,angl,k,minWaveLength,mult,sigmaOnf)
%%  LogGabor2D - 
%   
%   REFERENCE:
%       H. Knutsson and C-F. Westin and G. H. Granlund, 
%       Local multiscale frequency and bandwidth estimation, 
%       IEEE International Conference on Image Processing,
%       36-40, Austin, Texas, USA, November 1994.
%
%       http://www.vision.caltech.edu/mweber/research/CNS248/node13.html
%
%   INPUT:
%       im                      - 2D gray image
%       ang                     - angle
%       k                       - angular resolution (related to number of angles to be used)
%       minWaveLength    3      - Wavelength of smallest scale filter.
%       mult             2.1    - Scaling factor between successive filters.
%       sigmaOnf         0.55   - Ratio of the standard deviation of the Gaussian 
%                            describing the log Gabor filter's transfer function 
%                            in the frequency domain to the filter center frequency.
%   OUTPUT:
%       Ri      - 
%
%   HELP:
%                                        2
%       Ri(rho) = exp[-(4/B^2*log(2)) * ln (rho/rhoi)]
%
%   USAGE:
%
%   AUTHOR:
%       Boguslaw Obara, http://boguslawobara.net/
%
%   VERSION:
%       0.1 - 07/02/2013 First implementation

%% Setup frequency
% Set up X and Y matrices with ranges normalised to +/- 0.5
% The following code adjusts things appropriately for odd and even values
% of rows and columns.
[rows,cols] = size(im);
if mod(cols,2)
    xrange = [-(cols-1)/2:(cols-1)/2]/(cols-1);
else
    xrange = [-cols/2:(cols/2-1)]/cols; 
end

if mod(rows,2)
    yrange = [-(rows-1)/2:(rows-1)/2]/(rows-1);
else
    yrange = [-rows/2:(rows/2-1)]/rows; 
end
%% XY
[x,y] = meshgrid(xrange, yrange);
%% Polar coordinates 
radius = sqrt(x.^2 + y.^2);       % Matrix values contain *normalised* radius from centre.
theta = atan2(-y,x);              % Matrix values contain polar angle.
%figure, imagesc(radius);          % (note -ve y is used to give +ve anti-clockwise angles)
%figure, imagesc(theta);           

radius = ifftshift(radius);       % Quadrant shift radius and theta so that filters
%figure, imagesc(radius);
theta  = ifftshift(theta);        % are constructed with 0 frequency at the corners.
%figure, imagesc(theta);
radius(1,1) = 1;                  % Get rid of the 0 radius value at the 0
                                  % frequency point (now at top-left corner)
                                  % so that taking the log of the radius will 
                                  % not cause trouble.
sintheta = sin(theta);
costheta = cos(theta);
%figure, imagesc(sintheta);
%figure, imagesc(costheta);
clear x; clear y; clear theta;    % save a little memory       
%% Log-Gabor

% Filters are constructed in terms of two components.
% 1) The radial component, which controls the frequency band that the filter
%    responds to
% 2) The angular component, which controls the orientation that the filter
%    responds to.
% The two components are multiplied together to construct the overall filter.

%% Lowpass
% Construct the radial filter components...
% First construct a low-pass filter that is as large as possible, yet falls
% away to zero at the boundaries.  All log Gabor filters are multiplied by
% this to ensure no extra frequencies at the 'corners' of the FFT are
% incorporated as this seems to upset the normalisation process when
% calculating phase congrunecy.
lp = lowpassfilter([rows,cols],.45,15);   % Radius .45, 'sharpness' 15
%lp = 1;

wavelength = minWaveLength*mult;
fo = 1.0/wavelength;                % Centre frequency of filter.
logGabor = exp((-(log(radius/fo)).^2) / (2 * log(sigmaOnf)^2));  
logGabor = logGabor.*lp;            % Apply low-pass filter
logGabor(1,1) = 0;                  % Set the value at the 0 frequency point of the filter
                                    % back to zero (undo the radius fudge).
%figure; imagesc(ifftshift(logGabor)); axis off; axis equal; axis tight;
%%  Angular filter spread function   
% Construct the angular filter spread function
% For each point in the filter matrix calculate the angular distance from
% the specified filter orientation.  To overcome the angular wrap-around
% problem sine difference and cosine difference values are first computed
% and then the atan2 function is used to determine angular distance.
ds = sintheta * cos(angl) - costheta * sin(angl);    % Difference in sine.
dc = costheta * cos(angl) + sintheta * sin(angl);    % Difference in cosine.
dtheta = abs(atan2(ds,dc));                          % Absolute angular distance.
% Scale theta so that cosine spread function has the right wavelength and clamp to pi    
dtheta = min(dtheta*k/2,pi);
% The spread function is cos(dtheta) between -pi and pi.  We add 1,
% and then divide by 2 so that the value ranges 0-1
spread = (cos(dtheta)+1)/2;        
%% Final
logGabor = logGabor .* spread;      % Multiply radial and angular
                                    % components to get the filter. 
logGabor = ifftshift(logGabor);     % Quadrant shift radius and theta so that filters                                    
%% End
end