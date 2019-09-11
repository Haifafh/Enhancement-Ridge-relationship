function ims = BOLoadImage3D(filename)
info = imfinfo(filename);
for i=1:round(length(info))
    ims(:,:,i) = imread(filename,i);
end
end