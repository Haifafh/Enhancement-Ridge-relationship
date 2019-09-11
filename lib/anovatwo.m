function [tbl, muij, sigmaij, sigma] = anovatwo(data)
%anovatwo 
% Calculates a tabular display of parameters in two-way anova. Data must be
% in the form of a three-dimensional array: first two dimensions are
% factors; third dimension is individual observations for each combination
% of factors. 
% Output tbl:
% Bottom right-hand entry is . Roverall meanest of RH column is deviations
% of row means. Rest of bottom row is deviations of column means. Rest of
% array is deviations of individual means. 
% Output muij: 
% Means for each combination of factors.
% Output sigmaij:
% Standard deviations for each combination of factors.
% Output sigma:
% Standard deviation of 'residuals'. 

[I, J, reps] = size(data);

muij = mean(data, 3); % Size [I, J] mu_ij

sigmaij = std(data, 1, 3); %Std_ij

mu = mean2(muij); % Size [1, 1]

muij1 = muij - mu; % Size [I, J]

alpha = mean(muij1, 2); % Size [I, 1]

beta = mean(muij1, 1); % Size [1, J]

alphar = repmat(alpha, [1, J]); % Size [I, J]

betar = repmat(beta, [I, 1]); % Size [I, J]

interactions = muij1 - alphar - betar; % Size [I, J]

%max(abs(muij - (mu + alphar + betar + interactions)))

residuals = data - repmat(muij, [1, 1, reps]);

sigma = std(residuals(:), 1);

tbl = [interactions, alpha; beta, mu];

figure;

for i = [1:I]
    
    for j = [1:J]
        
        d = data(i, j, :);
        
        p = sub2ind([J, I], j, i);
        
        subplot(I, J, p);
        
        goodData = (d(:) < 13).* d(:);
        
        hist(d(:));

        
    end;
    
end;

figure;

for rep = [1:reps]
        
        d = data(:, :, rep);
        
        subplot(1, reps, rep);
        
        goodData = (d(:) < 13).* d(:);
        
        hist(goodData);
    
end;
end