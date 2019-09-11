function [l,m] = steerableFiltersWeightsSet(k,i,j)
%% HELP
% S(k,i,j)
% i<=k
% j=0:k
%%
l = 0:(k-i);
m = 0:i;
idxlm = zeros(length(l),length(m));
for li=1:length(l)
    for mi=1:length(m)
        if j == k-(l(li)+m(mi));
            idxlm(li,mi) = 1;
        end
    end
end
[li,mi] = find(idxlm==1);
l = l(li);
m = m(mi);
end