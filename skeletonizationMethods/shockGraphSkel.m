function out = shockGraphSkel(I,params)
%% Description
% skeletonization of an image using shockgraphs
%% Reference
% Siddiqi, Kaleem, et al. "Shock graphs and shape matching." International 
% Journal of Computer Vision 35.1 (1999): 13-32.?
%% Code
I =(I-min(I(:)))/(max(I(:))-min(I(:)));
%
%Change the type of I into double for computation 
I=double(I); 
 
%Calculate the size of input image 
[M,N]=size(I); 

%inverse the input image 
I=imcomplement(I);
 
if max(isnan(I(:)))==1
    out = zeros(size(I));
    return
end
%Convert the image to a binary image where the foreground object is
%black and the background is white
I=xor(I,ones(M,N)); 

%Calculate the distances of the binary image using Euclidean distance
%D is a resulting distance matrix that is the same size as I, and L is a matrix of the number of
%elements in I represented as a double
[D,L]=bwdist(I); 
L=double(L); 

%Create a 2x2 lowpass filter to smooth the image
G=fspecial('gaussian',[2 2],params(1)); 

%Apply filter to resulting distance matrix D 
SD=imfilter(D,G); 

%Determine the equivalent supscript values given the number of elements in
%L
[r,c]=ind2sub([M N], L);

%Preallocation Step
delDx=zeros(M,N); 
delDy=zeros(M,N); 

%Create a meshgrid
[X,Y]=meshgrid(1:1:N,1:1:M); 

%Calculate the vector field
    for i=1:1:M 
         for j=1:1:N 
             if SD(i,j) ~= 0 
                 delDx(i,j)=-1*(c(i,j)-j)/SD(i,j); 
                 delDy(i,j)=-1*(r(i,j)-i)/SD(i,j); 
             end 
         end
    end

%Preallocation Step
FluxP=zeros(M,N); 

%Calculate the divergence (ie flux) of the vector field
FluxP=divergence(X,Y,delDx,delDy); 

%Preallocation step
result=255.*ones(M,N); 

%Calculate the resulting shock graph
for i=1:M 
     for j=1:N 
         if I(i,j)==0 
         result(i,j)=128; 
         end 
     end 
end 
 
%Overlay the Shockgraph onto the original image 
for i=1:M 
     for j=1:N 
         if FluxP(i,j) < params(2) 
            result(i,j)=0; 
         else 
            continue;
         end 
     end 
end 
result = result> params(3);
%Construct shockgraph using MATLAB's bwmorph command
result =imcomplement(result);
out=bwmorph(result,'skel');
