function d = hausdorffDistance(A,B)
%% Hausdorff distance between two binary images (untested)
D = bwdist(A);
D = D(logical(B));
d = max(D(:));
D = bwdist(B);
D = D(logical(A));
d = max(d,max(D(:)));
if d == inf || isempty(d)
    d = 0001e+038;
end
end