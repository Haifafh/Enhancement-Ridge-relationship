function M = readDataset(directory, extension, c,invert,resize,crop)

%% Reads a dataset into a large tensor M
imagefiles = dir(strcat(directory, '/*.', extension));      
nFiles = length(imagefiles);    % Number of files found
if exist('resize','var')
    sze = [crop(3),crop(4)];
else
sze = size(imread(imagefiles(1).name));
end
if c ==0
    M = zeros(sze(1),sze(2),nFiles);
for i=1:nFiles
   currentFilename = imagefiles(i).name;
   
   currentImage = imread(currentFilename);
  if exist('resize','var')   
    currentImage = imcrop( currentImage,[crop(1) crop(2) crop(3)-1 crop(4)-1]);
   end
   if size(currentImage, 3) > 1
       currentImage = rgb2gray(currentImage);
   end
   currentImage = im2double(currentImage);
   
   if invert==1
       currentImage = imcomplement(currentImage);
   end
   M(:,:,i) = currentImage;
end
else
    % if we need rgb images
    M = zeros(sze(1),sze(2),3, nFiles);
for i=1:nFiles
   currentFilename = imagefiles(i).name;
   currentImage = imread(currentFilename);
   currentImage = im2double(currentImage)./255;
   if exist('invert','var')
       currentImage =  imcomplement(currentImage);
   end
   M(:,:,:,i) = currentImage;
end
    
end
end