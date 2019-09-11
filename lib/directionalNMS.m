function [output1,output2] =  directionalNMS(fx,fy)

% Function Directional Non-Maximum Suppression
%
%  function [maxMap] = directionalNMS(fx,fy)
%  function [cleanFx,cleanFy] = directionalNMS(fx,fy)
%
%  	Performs NMS on a gradient map specified by the component maps
%		fx and fy.
%	This function considers the vertical axis (Y) to be increasing upwards.
%	In order to perform NMS it considers the local gradient at each pfxel
%		and check the closest next and previous pfxels.
%
% [Inputs]
%   fx(mandatory)- Horizontal components. Positive with the increas upwards.
%   fy(mandatory)- Vertical components. Positive with the increase to the right.
%
% [outputs]
%   maxMap- Binary map with the maxima pfxels.
%   [cleanFx,cleanFy]- Versions of fx and fy at which the non-maxima pfxels 
%		have been removed (set to 0).
%
% [usages]
%
% [note]
%
% [dependencies]
%
% [author]
%   Carlos Lopez-Molina (carlos.lopez@unavarra.es)
%
%
% [references]
%	Rosenfeld, A, Thurston, M
%	Edge and Curve Detection for Visual Scene Anafysis
%	IEEE Trans. on Computers, 1971, 20, 562-569


%
%	0- Validate Arguments 
%
assert(nargin==2,'Error at directionalNMS: Wrong number of arguments.');

%
%	1- Preprocessing
%
ft=sqrt(fx.^2+fy.^2);
fMax=zeros(size(fx));

oris=components2orientations(fx,fy);
oris(oris>pi)=oris(oris>pi)-pi;%map the orientations to [0,pi]
oris(1,:)=NaN;
oris(end,:)=NaN;
oris(:,1)=NaN;
oris(:,end)=NaN;

%
%	2- Processing
%

for dir = 1:4
    
    if (dir==1)
        idx=find(or(oris<=pi/8,oris>=7*pi/8));
        [pI,pJ]=ind2sub(size(ft),idx);
        prevJ=pJ-1;
        nextJ=pJ+1;
        prevI=pI;
        nextI=pI;
        prevIDX=sub2ind(size(ft),prevI,prevJ);
        nextIDX=sub2ind(size(ft),nextI,nextJ);
        
    elseif(dir==2)
        idx=find(and(oris>=pi/8,oris<=3*pi/8));
        [pI,pJ]=ind2sub(size(ft),idx);
        prevI=pI+1;
        prevJ=pJ-1;
        nextI=pI-1;
        nextJ=pJ+1;
        prevIDX=sub2ind(size(ft),prevI,prevJ);
        nextIDX=sub2ind(size(ft),nextI,nextJ);
    elseif(dir==3)
        idx=find(and(oris>=3*pi/8,oris<=5*pi/8));
        [pI,pJ]=ind2sub(size(ft),idx);
        prevJ=pJ;
        nextJ=pJ;
        prevI=pI-1;
        nextI=pI+1;
        prevIDX=sub2ind(size(ft),prevI,prevJ);
        nextIDX=sub2ind(size(ft),nextI,nextJ);
    elseif(dir==4)
        idx=find(and(oris>=5*pi/8,oris<=7*pi/8));
        [pI,pJ]=ind2sub(size(ft),idx);
        prevI=pI+1;
        prevJ=pJ+1;
        nextI=pI-1;
        nextJ=pJ-1;
        prevIDX=sub2ind(size(ft),prevI,prevJ);
        nextIDX=sub2ind(size(ft),nextI,nextJ);
    end
    
    localDirMaxima= and(ft(idx)>ft(prevIDX),ft(idx)>=ft(nextIDX));
    localDirMaxima=idx(localDirMaxima);
    
    fMax(localDirMaxima)=1;
    
end





%
%   3- Output preparison
%

if (nargout==1)
    output1=fMax;
elseif(nargout==2)
    output1=fx.*fMax;
    output2=fy.*fMax;
end