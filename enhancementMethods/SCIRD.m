function [out] = SCIRD(I,params)

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%                                                                         %
%                             help SCIRD                                  %
%                                                                         %
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%
% SCIRD   This function implements the Scale and Curvature Invariant Ridge 
%         Detector (SCIRD) described in [1].
%         
% Input:
%
%     I          image to be filtered. It should be grayscale (single layer).
%     
%   alpha        controls the balance between contrast and 
%                filter bank response (max). It should be positive if 
%                structures of interest are poorly contrasted. Otherwise, it
%                should be negative to reduce noise. Set it to 0 as default.
%             
% ridges_color   specifies if structures of interest are black or white.
%
% fb_parameters  contains the parameters of the filter bank to be used.
%                It should be formatted as:
%                   fb_parameters.sigma_1 ("memory" or elongation range)
%                   fb_parameters.sigma_1_step (discretisation step to be used to span sigma_1 range)
%                   fb_parameters.sigma_2 (width)
%                   fb_parameters.sigma_2_step (discretisation step to be used to span sigma_2 range)
%                   fb_parameters.k (curvature range)
%                   fb_parameters.k_step (discretisation step to be used to span k)
%                   fb_parameters.angle_step (discretisation step to be used to span 180-step degrees)
%                Notice that spanning 0:180-angle_step degrees and
%                negative curvature values (e.g. [-0.1 0.1]) is equivalent
%                to 0:360-angle_step and k=[0 0.1]. Here we use the
%                solution with negative curvature values (see below).
% 
% Output:
%
%  out   filtered/enhanced image.
%     
%  properties    contains parameters of SCIRD filters generated in the 
%                current setting. For instance, properties(10) contains 
%                all the parameters of the 10th filter.
%     
%  ALLfiltered   responsed of SCIRD filter bank before soft thresholding and   
%                contrast adaptation. Access the 10th response with 
%                ALLfiltered(:,:,10)
%
% Usage: refer to the toy example in "runme.m"
%
%**************************************************************************
%  author: Roberto Annunziata, School of Computing, University of Dundee 
%  e-mail: r.annunziata@dundee.ac.uk or r_o_b_e_r_t_o@hotmail.it
%  web: http://staff.computing.dundee.ac.uk/rannunziata/
%  date: May 2015
%
%  If you use this code in your project, please cite [1].
%        
% [1] R. Annunziata, A. Kheirkhah, P. Hamrah, E. Trucco, "Scale and 
%     Curvature Invariant Ridge Detector for Tortuous and Fragmented 
%     Structures", MICCAI, 2015.
%**************************************************************************
%params= [alpha,Rcolor,fb_parameters.sigma_1,fb_parameters.sigma_1_step,fb_parameters.sigma_2,...
%fb_parameters.sigma_2_step,fb_parameters.k,fb_parameters.k_step,fb_parameters.angle_step];
%%
%single layer grayscale single precision
I = single(I(:,:,1));
%set contrast-adaptation parameter
alpha = params(1); 

%ridges color 'black' or 'white'
if params(2)~=1
    ridges_color = 'black';
else
    ridges_color = 'white';
end
%set filter bank parameters
fb_parameters.sigma_1 = [params(3) params(4)]; 
fb_parameters.sigma_1_step = params(5);
fb_parameters.sigma_2 = [params(6) params(7)]; 
fb_parameters.sigma_2_step = params(8); 
fb_parameters.k = [params(9)  params(10)]; 
fb_parameters.k_step = params(11); 
fb_parameters.angle_step = params(12);
%% invert image (if needed) and reduce salt & pepper noise
if strcmp(ridges_color,'black')
    I = -(max(I(:))-I);
else
    if strcmp(ridges_color,'white')
    I = -I;
    else
        fprintf('ERROR: specify ridge color, please!');
    end
end

I = medfilt2(I,[3 3],'symmetric');                         

%% create SCIRD filter bank

[SCIRD_filters, properties, num_kernels] = create_SCIRD_fb(fb_parameters.sigma_1,fb_parameters.sigma_1_step, fb_parameters.sigma_2,fb_parameters.sigma_2_step, fb_parameters.k, fb_parameters.k_step, fb_parameters.angle_step);


%% apply SCIRD filter bank

ALLfiltered = single(zeros(size(I,1),size(I,2),num_kernels));
for all_ind = 1:num_kernels
    ALLfiltered(:,:,all_ind) = single(imfilter(I,SCIRD_filters{all_ind},'conv','symmetric'));
end

% MAX is used to achieve orientation, scale, curvature invariance (refer to Eq. (10), numerator)
[outIm_max, ~] = max(ALLfiltered,[],3);

% soft-thresholding
outIm_pos = outIm_max;
outIm_pos(outIm_max<0)=0;

%% contrast-sensitive adaptation

%compute the largest gradient magnitude  over the range of SCIRD's widths
options_GM.ScaleRange = fb_parameters.sigma_2;
options_GM.ScaleRatio = fb_parameters.sigma_2_step;
options_GM.verbose = 0;
outImGM = largestGradientMagnitudeoverscale(I,options_GM);

%local average as contrast measure (Eq. (11))
N = 8*fb_parameters.sigma_2(2); %this is not a free parameter (see [1])
local_contrast = filter2(fspecial('average',N+1),outImGM);
local_contrast_pos = local_contrast;
local_contrast_pos(local_contrast<0)=0;

%denominator in Eq. (10)
contrast_term = (ones(size(outIm_pos))./(ones(size(outIm_pos)) + (alpha * local_contrast_pos)));

%SCIRD result (Eq. (10))
out = contrast_term.*outIm_pos;
out = double(out);
end
