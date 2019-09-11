function [L1,L2,V1,V2,V3,V4] = eigenSort2x2M(L1,L2,V1,V2,V3,V4)
%% Setup
if nargin<6
    V1 = []; V2 = []; V3 = []; V4 = []; 
end
%% Eigen Values
L12 = [];
L12(:,:,1) = abs(L1); 
L12(:,:,2) = abs(L2); 
%[L12,idx] = sort(L12,3,'descend');
[L12,idx] = sort(L12,3);

L1s = L1; 
L2s = L2;
L1s(idx(:,:,1)==2) = L2(idx(:,:,1)==2);
L2s(idx(:,:,2)==1) = L1(idx(:,:,2)==1);
L1 = L1s;
L2 = L2s;
%% Eigen Vectors
if ~isempty(V1)
V1s = V1; 
V2s = V2;
V3s = V3;
V4s = V4;

% V12 V34
V1s(idx(:,:,1)==2) = V3(idx(:,:,1)==2);
V2s(idx(:,:,1)==2) = V4(idx(:,:,1)==2);

V3s(idx(:,:,2)==1) = V1(idx(:,:,2)==1);
V4s(idx(:,:,2)==1) = V2(idx(:,:,2)==1);

V1 = V1s;
V2 = V2s;
V3 = V3s;
V4 = V4s;
end
%% End
end