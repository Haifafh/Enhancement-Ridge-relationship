function [SCIRD_filter_bank, properties, all_ind] = create_SCIRD_fb(sigma_1,sigma_1_step, sigma_2,sigma_2_step, k, k_step, step_angle)

% create_SCIRD_fb creates SCIRD filter bank (same notation adopted in [1])
%
% [1] R. Annunziata, A. Kheirkhah, P. Hamrah, E. Trucco, "Scale and 
%     Curvature Invariant Ridge Detector for Tortuous and Fragmented 
%     Structures", MICCAI, 2015.

s1_ind=0;
s2_ind=0;
k_ind=0;
angle_ind=0;
all_ind=0;
SCIRD_filter_bank = cell(1,1);
properties = struct;
for i_s1 = sigma_1(1):sigma_1_step:sigma_1(end)
    s1_ind = s1_ind+1; 
    for i_s2 = sigma_2(1):sigma_2_step:sigma_2(end) 
        s2_ind = s2_ind+1; 
        for i_k = k(1)-1e-15:k_step:k(end)+1e-15 
            if i_s1>=i_s2 %enforces filters to be longer than wider
                k_dim = i_k;
                k_ind = k_ind+1; 
                Sigma = max(i_s1,i_s2);
                [x,y]   = ndgrid([-round(4*Sigma):0,1:round(4*Sigma)]); %normal grid
         
                for angle = 0:step_angle:(180-step_angle)
                    angle_ind = angle_ind+1;
                    
                    %Refer to Eq. (9) [1]
                    %normalised derivatives
                    Gammaxx = (exp(- (k_dim*x.^2 + y).^2/(2*i_s2^2) - x.^2/(2*i_s1^2)).*(x/i_s1^2 + (2*k_dim*x.*(k_dim*x.^2 + y))/i_s2^2).^2)/(2*pi*i_s1*i_s2) - (exp(- (k_dim*x.^2 + y).^2/(2*i_s2^2) - x.^2/(2*i_s1^2)).*(1/i_s1^2 + (2*k_dim*(k_dim*x.^2 + y))/i_s2^2 + (4*k_dim^2*x.^2)/i_s2^2))/(2*pi*i_s1*i_s2);
                    Gammayx = (exp(- (k_dim*x.^2 + y).^2/(2*i_s2^2) - x.^2/(2*i_s1^2)).*(x/i_s1^2 + (2*k_dim*x.*(k_dim*x.^2 + y))/i_s2^2).*(2*k_dim*x.^2 + 2*y))/(4*pi*i_s1*i_s2^3) - (k_dim*x.*exp(- (k_dim*x.^2 + y).^2/(2*i_s2^2) - x.^2/(2*i_s1^2)))/(pi*i_s1*i_s2^3);
                    % Gammaxy = Gammayx as per Hessian matrix properties
                    Gammayy = (exp(- (k_dim*x.^2 + y).^2/(2*i_s2^2) - x.^2/(2*i_s1^2)).*(2*k_dim*x.^2 + 2*y).^2)/(8*pi*i_s1*i_s2^5) - exp(- (k_dim*x.^2 + y).^2/(2*i_s2^2) - x.^2/(2*i_s1^2))/(2*pi*i_s1*i_s2^3);
                    
                    %Now, we need to obtain orthogonal directions at each pixel (Gamma_x_tilde and Gamma_y_tilde).
                    %So, we assume a constant longitudinal profile (remove Gaussianity) by replacing the first term
                    %of Eq. (4) with a constant C = sqrt(2*pi*sigma_2^2).
                    %Then, we compute derivatives w.r.t. x and y
                    Gammax_tilde = -exp(- (k_dim*x.^2 + y).^2/(2*i_s2^2)).*((2*k_dim*x.*(k_dim*x.^2 + y))/i_s2^2);
                    Gammay_tilde = -(exp(- (k_dim*x.^2 + y).^2/(2*i_s2^2) ).*(2*k_dim*x.^2 + 2*y))/(2*i_s2^2);

                    %normalized gradient
                    vx = Gammax_tilde./(sqrt(Gammax_tilde.^2 + Gammay_tilde.^2));
                    vy = Gammay_tilde./(sqrt(Gammax_tilde.^2 + Gammay_tilde.^2));
                    
                    %there are a few points some points where v is NaN because the filter gradient is zero.
                    %We explicitly remove them.
                    vx(isinf(vx))=0;
                    vy(isinf(vy))=0;
                    vx(isnan(vx))=0;
                    vy(isnan(vy))=0;

                    all_ind = all_ind + 1; 

                    %the obtained kernel is designed to measure contrast in the gradient direction at each pixel
                    %Eq. (9)
                    kernelww = (vx.*Gammaxx + vy.*Gammayx).*vx + (vx.*Gammayx + vy.*Gammayy).*vy;
                    
                    %apply rotation using bicubic interpolation
                    kernel_rotatedww = imrotate(kernelww,angle,'bicubic','crop');
                    
                    %store kernel in the filter bank
                    SCIRD_filter_bank{all_ind} =  kernel_rotatedww; 
                    
                    %store properties related to the current kernel
                    properties(all_ind).s1 = i_s1;
                    properties(all_ind).s2 = i_s2;
                    properties(all_ind).k = i_k;
                    properties(all_ind).angle = angle;
                    
                end
            end
        end
    end
 end
end


