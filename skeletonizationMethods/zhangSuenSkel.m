function out = zhangSuenSkel(I,params)
%% Description:
% Zhang-Suen Thinning Algorithm for skeletonization.
% This algorithm is used for thinning binary image. Two steps will be 
% successively applied to the image.
%% Reference: 
% (1) Zhang T Y, Suen C Y. A fast parallel algorithm for thinning digital patterns. 
% Comm ACM, 1984, 27: 236-239.
% (2) "Character Recognition Systems: A Guide for Students and 
% Practitioners",Page48-50, By Mohamed Cheriet, Nawwaf Kharma, Cheng-Lin Liu, Ching
% Suen.
%% Author:  
% Linbo<linbo.me>
%% Version: 1.0  25/10/2014
%% Code
changing = 1;
[rows, columns] = size(I);
out = I;
BW_Del = ones(rows, columns);
while changing
    % BW_Del = ones(rows, columns);
    changing = 0;
    % Setp 1 :
    % All pixels are tested and pixels satisfying all the following
    % conditions:
    % Condition 0: The pixel is 1 and has eight neighbours 
    % Condition 1: 2 < = N(P1) < = 6 
    % Condition 2: S(P1) = 1
    % Condition 3: P2 * P4 * P6 = 0 
    % Condition 4: P4 * P6 * P8 = 0 
    for i=2:rows-1
        for j = 2:columns-1
            P = [out(i,j) out(i-1,j) out(i-1,j+1) out(i,j+1) out(i+1,j+1) out(i+1,j) out(i+1,j-1) out(i,j-1) out(i-1,j-1) out(i-1,j)]; % P1, P2, P3, ... , P8, P9, P2
            if (out(i,j) == 1 &&  sum(P(2:end-1))<=6 && sum(P(2:end-1)) >=2 && P(2)*P(4)*P(6)==0 && P(4)*P(6)*P(8)==0)   % conditions
                % No. of 0,1 patterns (transitions from 0 to 1) in the ordered sequence
                A = 0;
                for k = 2:size(P,2)-1
                    if P(k) == 0 && P(k+1)==1
                        A = A+1;
                    end
                end
                if (A==1)
                    BW_Del(i,j)=0;
                    changing = 1;
                end
            end
        end
    end
    out = out.*BW_Del;  % the deletion must after all the pixels have been visited
    % Step 2 :
    % All pixels are again tested and pixels satisfying all the following conditions
    % are just noted at this stage. 
    % Condition 0: The pixel is 1 and has eight neighbours 
    % Condition 1: 2 < = N(P1) < = 6  
    % Condition 2: S(P1) = 1   
    % Condition 3: P2 * P4 * P8 = 0   
    % Condition 4: P2 * P6 * P8 = 0  
    for i=2:rows-1
        for j = 2:columns-1
            P = [out(i,j) out(i-1,j) out(i-1,j+1) out(i,j+1) out(i+1,j+1) out(i+1,j) out(i+1,j-1) out(i,j-1) out(i-1,j-1) out(i-1,j)];
            if (out(i,j) == 1 && sum(P(2:end-1))<=6 && sum(P(2:end-1)) >=2 && P(2)*P(4)*P(8)==0 && P(2)*P(6)*P(8)==0)   % conditions
                A = 0;
                for k = 2:size(P,2)-1
                    if P(k) == 0 && P(k+1)==1
                        A = A+1;
                    end
                end
                if (A==1)
                    BW_Del(i,j)=0;
                    changing = 1;
                end
            end
        end
    end
    out = out.*BW_Del;
end%while
end