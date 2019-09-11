function [tbl, mu_ij, mu,sigma_ij, sigma,interactions] = anovatwo2(data)
%% anovatwo 
% Calculates a tabular display of parameters in two-way anova. Data must be
% in the form of a three-dimensional array: first two dimensions are
% factors; third dimension is individual observations for each combination
% of factors. 
% Output tbl:
% Bottom right-hand entry is overall mean. Rest of RH column is deviations
% of row means. Rest of bottom row is deviations of column means. Rest of
% array is deviations of individual means. 
% Output muij: 
% Means for each combination of factors.
% Output sigmaij:
% Standard deviations for each combination of factors.
% Output sigma:
% Standard deviation of 'residuals'. 
%% HELP
% https://www.chegg.com/homework-help/questions-and-answers/understand-general-concept-two-way-anova-cell-mean-model-don-t-understand-uij-u-ai-bj-inte-q27109139

%% Size
data = randn(8,19,10,1);
[I, J, reps] = size(data);

%% Mean of cell - accross 3rd dimension
mu_ij = mean(data, 3); % Size [I, J]

%% Std accross 3rd dimension
sigma_ij = std(data, 1, 3);

%% Global Mean - scalar
mu = mean2(mu_ij); % Size [1, 1]

%% Mean of i-th level of factor A
alpha = mean(mu_ij - mu, 2); % Size [I, 1]

%% Mean of j-th level of factor B
beta = mean(mu_ij - mu, 1); % Size [1, J]

%% Reshape 
alphar = repmat(alpha, [1, J]); % Size [I, J]
betar = repmat(beta, [I, 1]); % Size [I, J]

%% Interaction variation
interactions = mu_ij - alphar - betar - mu; % Size [I, J]

%% Residuals
residuals = data - repmat(mu_ij, [1, 1, reps]);

%% Sigma
sigma = std(residuals(:), 1);

%% Table
tbl = [interactions, alpha; beta, mu];
end