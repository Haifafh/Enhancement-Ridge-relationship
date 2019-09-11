function  out = methodsCombos(I,label,mask,skeleton,enhancement,skel,enh,flg,foldername_plots1,foldername_plots2,ext1,ext2,filename)
% I           : the Image
% skeleton    : skeleton function's name.
% enhancement : enhancement function's name.
% skel        : parameters needed for image skeletonization.
% enh         : parameters needed for image enhancement.
%% 

 enhancementFunction = str2func(enhancement);
 skeletonFunction = str2func(skeleton);
 
 out1= enhancementFunction(double(I),enh);
 if flg ==1
  maskVmax = imerode(mask, strel('disk',10));
  out1 =  double(out1) .* double(maskVmax);
 end
 out1 = normalize(out1);
 outimage = skeletonFunction(out1,skel);
 %% Save and Write
    %Save as 'png' image
    imwrite(outimage,(fullfile(foldername_plots1,[filename ext1])),'XResolution',300);
    %Save as 'mat' file
    save((fullfile(foldername_plots2,[filename ext2])),'outimage');
    %%
 out = ModHausdorffDist(outimage,label);
end