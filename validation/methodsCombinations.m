function  out = methodsCombinations(I,skeleton,enhancement,x,flg)
%% description:
 % Enhancement-skeletonisation combination.
%% Inputs:
% I           : the Image
% skeleton    : skeleton function's name.
% enhancement : enhancement function's name.
% x           : parameters list x.
% flg         : flag indicates for using thresholding.
 enhancementFunction = str2func(enhancement);
 skeletonFunction = str2func(skeleton);
 % a function to normlize all params x 
 if flg ==0
     %% Grayscale-based skeletonization/ridge detection algorithms
     if (strcmp(skeleton ,'edgeLindberg') || strcmp(skeleton ,'shockGraphSkel') || strcmp(skeleton ,'stegerSkelJava')) && (strcmp(enhancement,'adaptiveThresh')...
             || strcmp(enhancement, 'otsuThresh') || strcmp(enhancement, 'globalThresh') || strcmp(enhancement, 'hysteresisThresh'))
         %% Convert binary images to grayscale after certain segmentation algorithms
         [params,enh,skel] = newnormliseParams(x,skeletonFunction,enhancementFunction,flg);
          params(end+1) = min(10,max(0.01,rand*10));
          enhI = enhancementFunction(I,params(1:enh));
         %% Adding Gaussian blur to the output
          sigma = params(end);
          G = imgaussfilt(double(enhI),sigma);
          out = skeletonFunction(G,params(enh+1:enh+skel));
         
     else
    
     [params,enh,skel] = newnormliseParams(x,skeletonFunction,enhancementFunction,flg);
     out = skeletonFunction(enhancementFunction(I,params(1:enh)),params(enh+1:enh+skel));
     end
 else
      %% Binary-based skeletonization/ridge detection algorithms
     [params,enh,skel] = newnormliseParams(x,skeletonFunction,enhancementFunction,flg); 
      out = skeletonFunction(normalize(enhancementFunction(I,params(1:enh)))> params(end),params(enh+1:enh+skel));
end
end