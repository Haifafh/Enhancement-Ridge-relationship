 function [params,enh,skel] = newnormliseParams(x,skeletonFunction,enhancementFunction,flg)
       params =0; 
switch char(enhancementFunction)
    case 'adaptiveThresh' 
        enh = 1;
        params = x(1);
    case 'otsuThresh'
        enh = 1;
        params = 0;
    case 'topHat' 
        enh = 2;
        params = [round(max(0.1,x(1))*100),round(max(0.1,x(2))*1000)];
    case 'CLAHE'
        enh = 1;
        params = 0;
    case 'globalThresh' 
        enh = 1;
        params = x(1);
    
    case 'hysteresisThresh' 
        enh = 3;
        if x(3)>= 0.5
            x(3) = 8;
        else
            x(3)= 4;
        end
        params = [max(0,x(1)),max(0,x(2)),x(3)];
    case 'localHistEq' %%%
        enh = 2;
        params = [round(max(0.2,x(1))*10),double(x(2))];
    case 'vesselness'
        enh = 7;
        params = [x(1),x(2),max(.1,x(3))*10,x(4),x(5),x(6),round(x(7))];
    
    case 'neuriteneesFilter'
        enh = 1;
        params = x(1);
    case 'phaseNeuritenessFilter'%%% double(min(.98,x(5)))
        enh = 9;
        params = [round(max(.1,x(1))*10),min(round(max(.1,x(1))*10),round(max(.1,x(2))*10)),...
                    max(round(max(.2,x(1))*10),round(max(.2,x(3))*10)),(max(.1,x(4))*10),...
                    double(min(.5,x(5))),round(max(.1,x(6))*100),double(min(.98,x(7))),round(max(.1,x(8))*100),round((x(9) * 2) - 2)];
    case 'phaseCongurency'%%% double(min(.98,x(5)))
        enh = 9;
        params = [round(max(.1,x(1))*10),min(min(round(max(.1,x(1))*10),round(max(.1,x(2))*10)),round(max(.1,x(3))*10)),...
                    max(max(round(max(.2,x(1))*10),round(max(.2,x(2))*10)),round(max(.2,x(3))*10)),(max(.1,x(4))*10),...
                    double(min(.5,x(5))),round(max(.1,x(6))*100),double(min(.98,x(7))),round(max(.1,x(8))*100),round((x(9) * 2) - 2)];
    case 'volumeRatio' %%
        enh = 6;
        params = [min(2,max(.1,x(1)*10)),min(min(3,max(.1,x(2)*10)),round(min(15,max(1,x(3)*10)))),round(min(15,max(1,x(3)*10))),...
                  round(min(5,max(.1,x(4))*10)),x(5),round(x(6))];
    
     case 'phaseVesselnessFilter'%%% min(.98,x(7))
         enh = 8;
        params = [round(max(0.1,x(1))*10),round(max(0.1,x(2))*10),max(round(max(0.1,x(1))*10),round(max(0.1,x(3))*10)),...
                  round(max(0.1,x(4))*100),round(max(.2,x(5))*10),x(6)*10,min(.5,x(7)),round(x(8)*10)];

    case 'localTensorVesselness' %x(5), round(max(.1,x(6))*10),x(7)
        enh = 8;
        params =[x(1),x(2),max(.1,x(3))*10,round(max(.1,x(4))*100),round(max(.1,x(5))*10),x(6),round(max(.1,x(7))*20),round(x(8))];
    case 'gaussianSteerableFilters'
        enh = 3;
        params =[round(x(1)*10),round(max(.1,x(2))*1000),min(1.99,x(3)*10)];
        case 'fcnBPDFHE' 
        enh = 10;
        params = [min(2,max(0,round(x(1)*10))),min(9,max(1,round(x(2)*10))),...
                  min(9,max(1,round(x(3)*10))),min(9,max(1,round(x(4)*10))),...
                  min(9,max(1,round(x(5)*10))),min(9,max(1,round(x(6)*10))),...
                  min(9,max(1,round(x(7)*10))),min(9,max(1,round(x(8)*10))),...
                  min(9,max(1,round(x(9)*10))),min(9,max(1,round(x(10)*10)))];
    case 'anIsotropicGaussianKernelEnhancement'
        enh= 13;
        params = [max(.1,x(1))*10,20*max(.1,x(2)),x(3)*10,x(4)*20,x(5)*30,x(6)*40,...
                  double(max(.1,x(7))*10),double(max(.1,x(8))*10),...
                  double(max(.1,x(9))*10),double(max(.1,x(10))*10),double(max(.1,x(11))*10),...
                  x(12),max(1,round(x(13)*10))];
    case 'iuwt'
        enh = 2;
        params = [min(round(10*max(.1,x(1))),round(10*max(.1,x(2)))),max(round(10*max(.1,x(1))),round(10*max(.1,x(2))))];
    case 'SCIRD'
        enh = 12;
        % x(2) : the color of vessel % 'black' in case of DRIVE
        params = [x(1),0,round(min(.5,min(max(.1,x(3)),max(.2,x(4))))*10),round(min(.5,max(max(.1,x(3)),max(.2,x(4))))*10)+1,round(min(1,max(.5,x(5)*10))),...
                    round(min(.3,min(max(.1,x(6)),max(.2,x(7))))*10),round(min(.5,max(max(.1,x(6)),max(.2,x(7))))*10)+1,min(1,max(.5,x(8)*10)),...
                    min(x(9)*2-1,x(10)*2-1),abs(max(x(9)*2-1,x(10)*2-1)), x(11),round(100*min(.3,max(.1,x(12))))];
    case 'pathOpening'
        enh= 4;
        params = [min(25,max(5,round(x(1)*100))),min(3,max(1,round(x(2)*10))),min(3,max(1,round(x(3)*10))),min(3,max(1,round(x(4)*10)))];
end
switch char(skeletonFunction)
    
    case 'morphSkeleton'
        skel = 1;
        params(end+1) = round(max(0.1,x(enh+1)*10));
    case 'shockGraphSkel'
        skel = 3;
        params(end+1:end+3) = [x(enh+1),(x(enh+2)*2)-1,x(enh+3)];
    case 'stegerSkelJava'
        skel = 4;
        params(end+1:end+4)= [min(6.3,max(1,x(enh+1)*10)),...
                            double(max(0,x(enh+2)*10)),...
                            double(x(enh+3)*255),x(enh+4)];
    
    case 'thinSkeleton'
        skel = 1;
        params(end+1)= round(max(0,x(enh+1)*10));
    case 'edgeLindberg'
        skel = 2;
        params(end+1:end+2)= [min(40,max(1,round(x(enh+1)*10))),x(enh+2)];
    case 'zhangSuenSkel'
        skel = 1;
        params(end+1)= 0;%%%
    case 'voronoiSkel'
        skel = 4;
        params(end+1:end+4)= [round(x(enh+1)),10*max(.1,x(enh+2)),round(x(enh+3)),((x(enh+4)*3) -2)];%%%  
    case 'afmmskel'
%         skel = 3;
%         params(end+1:end+3) = [round(x(enh+1)),round(x(enh+2)*5-2),max(.1,x(enh+3))];
        % there is internal intrpertation of params inside afmm skeleton
        % function
        % Generalised usage
        skel =1;
        params(end+1)= 0;%%%
end
if flg == 1
    params(end+1)= x(enh+skel+1);
end
  disp(params);  
end