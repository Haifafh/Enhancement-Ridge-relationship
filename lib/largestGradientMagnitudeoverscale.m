function [outImGM]=largestGradientMagnitudeoverscale(I,options)
outImGM = zeros(size(I));
defaultoptions = struct('ScaleRange', [1 3], 'ScaleRatio', 1, 'verbose',true); 
% Process inputs
if(~exist('options','var')), 
    options=defaultoptions; 
else
    tags = fieldnames(defaultoptions);
    for i=1:length(tags)
         if(~isfield(options,tags{i})),  options.(tags{i})=defaultoptions.(tags{i}); end
    end
    if(length(tags)~=length(fieldnames(options))), 
        warning('largestGradientMagnitudeoverscale:unknownoption','unknown options found');
    end
end

sigmas=options.ScaleRange(1):options.ScaleRatio:options.ScaleRange(2);
sigmas = sort(sigmas, 'ascend');

% Make matrices to store all filterd images
ALLfiltered=zeros([size(I) length(sigmas)]);
%  filter for all sigmas
for i = 1:length(sigmas)
    % Show progress
    if(options.verbose)
        disp(['Current Filter Sigma: ' num2str(sigmas(i)) ]);
    end
    
    % Make gradient Dx Dy
    [Dx,Dy,GM] = gradient_magnitude(I,sigmas(i));
   
    % store the results in 3D matrices
      ALLfiltered(:,:,i) = GM/sigmas(i);    
end

% Return for every pixel the value of the scale(sigma) with the maximum 
% output pixel value
if length(sigmas) > 1
    [outImGM ] = max(ALLfiltered,[],3);
    
    outImGM = reshape(outImGM,size(I));  
end
