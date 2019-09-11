function b = steerableFiltersWeights(k,i,theta)
%% Orientation-Dependent Weights
alpha = zeros(2,2); 
alpha(2,1) = 1; % 2,1 -> 1,0
alpha(2,2) = 1; % 2,2 -> 1,1
%%
b = 0;
for j=0:k
    % Weights Set
    [l,m] = steerableFiltersWeightsSet(k,j,i);
    w = 0;
    for li=1:length(l)
        for mi=1:length(m)
            c = nchoosek(k-j,l(li))*nchoosek(j,m(mi)); %(k-j,l)(j,m) - binominal combinations
            u0 = m(mi);
            u1 = (   j +(l(li)-m(mi)));
            u2 = ((k-j)-(l(li)-m(mi)));
            w = w + c * (-1)^u0 * cos(theta)^u1 * sin(theta)^u2;
            %disp([k,i,j,l(li),m(mi),u0,u1,u2,c])
        end
    end
    b = b + alpha(k+1,j+1) * w;
end
end