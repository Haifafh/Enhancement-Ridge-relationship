function out = anIsotropicGaussianKernelEnhancement(I,params)
%% Discription
%% Temp
% Parameters:
% params =[sAnisotropy,aAnisotropy,mmSigmas,mmAnisotropy,chdDirs,sigmasOne];
% methods={'MM4','SS2','SS3','SS4','MS','SM1','SM2','SM3','SM4','MM','MM2'};
%% reference :
% Unsupervised ridge detection using second order anisotropic Gaussian kernels
% Lopez-Molina C Vidal-Diez de Ulzurrun G Baetens J Van den Bulcke J De Baets B
% Signal Processing
% 2015 vol: 116 (C) pp: 55-67
%% Code
%I = imcomplement(I);
%% set variables
sAnisotropy = params(1);
aAnisotropy = params(2);
mmSigmas =[params(3) params(4) params(5) params(6)];
mmAnisotropy =[params(7) params(8) params(9) params(10) params(11)];
% Directions used by the Chaudhuri method.
chdDirs =[0:1:15].*(pi/16);
sigmasOne = [params(12)];
switch uint8(params(13))
    case 1
        methods = {'MM4'};
    case 2
        methods = {'SS2'};
    case 3
        methods = {'SS3'};
    case 4
        methods = {'SS4'};
    case 5
        methods = {'MS'};
    case 6
        methods = {'SM1'};
    case 7
        methods = {'SM2'};
    case 8
        methods = {'SM3'};
    case 9
        methods = {'SM4'};
    case 10
        methods = {'MM2'};
end
%% pre-processing

if(size(I,3)>0)
    I = mean(I,3);
end
 I = I-min(I(:));
 I = I./max(I(:));
 
% processing the image
    %%
  for idxMethod=1:length(methods)
    
        methodName=char(methods(idxMethod));
        
        for idSigmaOne=1:length(sigmasOne)

            sigmaOne=sigmasOne(idSigmaOne);
            sigmaOneName=regexprep(sprintf('%.2f',sigmaOne),'\.','-');

               if (sigmaOne>0)
                    smooImage=gaussianSmooth(I,sigmaOne);
                    % Normlise?
                    smooImage=smooImage-min(smooImage(:));
                    smooImage=smooImage./max(smooImage(:));
                else
                    smooImage=I;
                end

                
                if (~isempty(strfind(methodName,'SS')))
                    theseScales=str2num(regexprep(methodName,'SS',''));
                    theseAnisotries=sAnisotropy;
                elseif(~isempty(strfind(methodName,'MS')))
                    theseScales=mmSigmas;
                    theseAnisotries=sAnisotropy;
                elseif(~isempty(strfind(methodName,'SM')))
                    theseScales=str2num(regexprep(methodName,'SM',''));
                    theseAnisotries=aAnisotropy;
                elseif(~isempty(strfind(methodName,'MM')))
                    if (strcmp(methodName,'MM1'))
                        theseScales=mmSigmas;
                        theseAnisotries=mmAnisotropy;
                    elseif (strcmp(methodName,'MM2'))
                        theseScales=mmSigmas;
                        theseAnisotries=mmAnisotropy(2:end-1);
                    elseif (strcmp(methodName,'MM3'))
                        theseScales=mmSigmas(2:end-1);
                        theseAnisotries=mmAnisotropy;
                    elseif (strcmp(methodName,'MM4'))
                        theseScales=mmSigmas(2:end-1);
                        theseAnisotries=mmAnisotropy(2:end-1);
                    end
                    
                else
                    error('Should specify which method you gonna use!');
                end
                 
        [gsLineImage,dirImage]=aGlineDetector(smooImage,theseScales,chdDirs,theseAnisotries);
        
        end
       
  end   
     out = gsLineImage./max(gsLineImage(:));
     %figure,imshow(out);
  end