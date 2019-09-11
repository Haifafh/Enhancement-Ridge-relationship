function bnImage = binarizeLineImage(originalImage,lineImage,dirImage,thresholds,rosinBinPrec,minLengthPercentage)

lineImage=lineImage./max(lineImage(:));

%Should I do this?
lineImage=lineImage.*(originalImage./max(originalImage(:)));
lineImage=lineImage./max(lineImage(:));


%lineImage=lineImage.^(1/2);


fx=lineImage.*cos(dirImage);
fy=lineImage.*sin(dirImage);
maxMap=directionalNMS(fx,fy);

ft2=maxMap.*lineImage;
    
if (isempty(thresholds))
    %Old version:
    % [thrs]=doubleRosinThr(ft2(ft2>0)),ConfigStruct.rosinBinPrec,2);
    [thrs]=(doubleRosinThr(ft2(ft2>0).^(0.5),rosinBinPrec,2)).^2;
else
    thrs=thresholds;
end

bnImage=floodHysteresis(ft2,thrs(2),thrs(1));


se=strel('disk',3);
auxImage=bnImage;
bnImage2=imclose(auxImage,se);

while (max(max(abs(bnImage2-auxImage)))>0)
    auxImage=bnImage2;
    bnImage2=imclose(auxImage,se);
end

bnImage2=bwmorph(bnImage2,'thin',inf);


% Activate this for minimum-length segment removing
minDiagSegment=minLengthPercentage;
bnImage=bwareaopen(bnImage2,round(minDiagSegment*sqrt(sum(size(bnImage2).^2))),8);% 8 for the connectivity

if (sum(sum(bnImage))==0)
    bnImage=bnImage2;%not removing
end