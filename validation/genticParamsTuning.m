function [ModHD,ModHDParam] = genticParamsTuning(I,target,img,ModHD,ModHDParam,flag)
 %% description:
 % A list of gentic-driven enhancement-skeletonisation combinations 
    I = double(I);
%% population size
    p = 50 ;
%% Maximum timeout
    t = 100000000000;
    outputDir = '/mnt/storage/home/haifa/curvilinear-methods/code/results/matFiles/ModHDAll/';
%% Metrics Functions
   %myMetric = str2func('ModHausdorffDist');
   filename1 ='ModHD1.mat';
   filename2 ='ModHDParams1.mat';
   resMetricFile = fullfile(outputDir, filename1);
   resParamsFile = fullfile(outputDir, filename2);
  
%% Algorithms combinations
%%   <1> zhangSuenSkel :
%%%    -------------------------------------------------------------------------
 skeleton  = 'zhangSuenSkel'; row = 1 ; ns = 1; sname = 'ZS'; thflag = 1;
 %%      (1) globalThresh
    enhancement = 'globalThresh'; col = 1; ename ='GT'; ne = 1; n = ne + ns + thflag;
    [ModHD,ModHDParam] = genaticCombo(I,target,img,skeleton,enhancement,row,col,n,p,t,sname,ename,ModHD,ModHDParam,resMetricFile,resParamsFile,flag,thflag ,''); 
 %%      (2) otsuThresh
    enhancement = 'otsuThresh'; col = 2; ename ='OT'; ne = 1; n = ne + ns + thflag;
    [ModHD,ModHDParam] = genaticCombo(I,target,img,skeleton,enhancement,row,col,n,p,t,sname,ename,ModHD,ModHDParam,resMetricFile,resParamsFile,flag,thflag ,''); 
 %%      (3) gaussianSteerableFilters
    enhancement = 'gaussianSteerableFilters'; col = 3; ename ='GS'; ne = 3; n = ne + ns + thflag;
    [ModHD,ModHDParam] = genaticCombo(I,target,img,skeleton,enhancement,row,col,n,p,t,sname,ename,ModHD,ModHDParam,resMetricFile,resParamsFile,flag,thflag ,''); 
 %%      (4) CLAHE
    enhancement = 'CLAHE'; col = 4; ename ='CLAHE'; ne = 1; n = ne + ns + thflag;
    [ModHD,ModHDParam] = genaticCombo(I,target,img,skeleton,enhancement,row,col,n,p,t,sname,ename,ModHD,ModHDParam,resMetricFile,resParamsFile,flag,thflag ,''); 
 %%      (5) vesselness
    enhancement = 'vesselness';col = 5; ename ='V'; ne = 7; n = ne + ns + thflag;
    [ModHD,ModHDParam] = genaticCombo(I,target,img,skeleton,enhancement,row,col,n,p,t,sname,ename,ModHD,ModHDParam,resMetricFile,resParamsFile,flag,thflag ,''); 
 %%      (6) localTensorVesselness
    enhancement = 'localTensorVesselness'; col = 6; ename ='LTV'; ne = 8; n = ne + ns + thflag;
    [ModHD,ModHDParam] = genaticCombo(I,target,img,skeleton,enhancement,row,col,n,p,t,sname,ename,ModHD,ModHDParam,resMetricFile,resParamsFile,flag,thflag ,''); 
 %%      (7) phaseVesselnessFilter
    enhancement = 'phaseVesselnessFilter'; col = 7; ename ='PCTV'; ne = 8; n = ne + ns + thflag;
    [ModHD,ModHDParam] = genaticCombo(I,target,img,skeleton,enhancement,row,col,n,p,t,sname,ename,ModHD,ModHDParam,resMetricFile,resParamsFile,flag,thflag ,''); 
 %%      (8) localHistEq
    enhancement = 'localHistEq';col = 8; ename ='LHE'; ne = 2; n = ne + ns + thflag;
    [ModHD,ModHDParam] = genaticCombo(I,target,img,skeleton,enhancement,row,col,n,p,t,sname,ename,ModHD,ModHDParam,resMetricFile,resParamsFile,flag,thflag ,''); 
%%       (9) topHat 
    enhancement = 'topHat'; col = 9; ename ='TH'; ne = 2; n = ne + ns + thflag;
    [ModHD,ModHDParam] = genaticCombo(I,target,img,skeleton,enhancement,row,col,n,p,t,sname,ename,ModHD,ModHDParam,resMetricFile,resParamsFile,flag,thflag ,''); 
%%       (10) adaptiveThresh 
    enhancement = 'adaptiveThresh'; col = 10; ename ='AT'; ne = 1; n = ne + ns + thflag;
    [ModHD,ModHDParam] = genaticCombo(I,target,img,skeleton,enhancement,row,col,n,p,t,sname,ename,ModHD,ModHDParam,resMetricFile,resParamsFile,flag,thflag ,''); 
%%       (11) phaseNeuritenessFilter
    enhancement = 'phaseNeuritenessFilter'; col = 11; ename ='PCTneurit'; ne = 9; n = ne + ns + thflag;
    [ModHD,ModHDParam] = genaticCombo(I,target,img,skeleton,enhancement,row,col,n,p,t,sname,ename,ModHD,ModHDParam,resMetricFile,resParamsFile,flag,thflag ,''); 
%%       (12) fcnBPDFHE
    enhancement = 'fcnBPDFHE'; col = 12; ename ='fcnBPDFHE'; ne = 10; n = ne + ns + thflag;
    [ModHD,ModHDParam] = genaticCombo(I,target,img,skeleton,enhancement,row,col,n,p,t,sname,ename,ModHD,ModHDParam,resMetricFile,resParamsFile,flag,thflag ,''); 
%%       (13) hysteresisThresh
    enhancement = 'hysteresisThresh'; col = 13; ename ='HT'; ne = 3; n = ne + ns + thflag;
    [ModHD,ModHDParam] = genaticCombo(I,target,img,skeleton,enhancement,row,col,n,p,t,sname,ename,ModHD,ModHDParam,resMetricFile,resParamsFile,flag,thflag ,''); 
%%       (14) phaseCongurency
    enhancement = 'phaseCongurency'; col = 14; ename ='PCT'; ne = 9; n = ne + ns + thflag;
    [ModHD,ModHDParam] = genaticCombo(I,target,img,skeleton,enhancement,row,col,n,p,t,sname,ename,ModHD,ModHDParam,resMetricFile,resParamsFile,flag,thflag ,''); 
%%       (15) iuwt
    enhancement = 'iuwt';  col = 15; ename ='iuwt'; ne = 2; n = ne + ns + thflag;
    [ModHD,ModHDParam] = genaticCombo(I,target,img,skeleton,enhancement,row,col,n,p,t,sname,ename,ModHD,ModHDParam,resMetricFile,resParamsFile,flag,thflag ,''); 
%%       (16) neuriteneesFilter
    enhancement = 'neuriteneesFilter'; col = 16; ename ='neurit'; ne = 1; n = ne + ns + thflag;
    [ModHD,ModHDParam] = genaticCombo(I,target,img,skeleton,enhancement,row,col,n,p,t,sname,ename,ModHD,ModHDParam,resMetricFile,resParamsFile,flag,thflag ,''); 
%%       (17) anIsotropicGaussianKernelEnhancement
    enhancement = 'anIsotropicGaussianKernelEnhancement';  col = 17; ename ='IGK';ne = 13; n = ne + ns + thflag;
    [ModHD,ModHDParam] = genaticCombo(I,target,img,skeleton,enhancement,row,col,n,p,t,sname,ename,ModHD,ModHDParam,resMetricFile,resParamsFile,flag,thflag ,''); 
%%       (18) SCIRD
    enhancement = 'SCIRD'; col = 18; ename ='SCIRD'; ne = 12; n = ne + ns + thflag;
    [ModHD,ModHDParam] = genaticCombo(I,target,img,skeleton,enhancement,row,col,n,p,t,sname,ename,ModHD,ModHDParam,resMetricFile,resParamsFile,flag,thflag ,'');  
%%       (19) volumeRatio
    enhancement = 'volumeRatio'; col = 19; ename ='VR'; ne = 6; n = ne + ns + thflag;
    [ModHD,ModHDParam] = genaticCombo(I,target,img,skeleton,enhancement,row,col,n,p,t,sname,ename,ModHD,ModHDParam,resMetricFile,resParamsFile,flag,thflag ,''); 
%%       (20) bowlerHat
    enhancement = 'bowlerHat'; col = 20; ename ='BH'; ne = 3; n = ne + ns + thflag;
    [ModHD,ModHDParam] = genaticCombo(I,target,img,skeleton,enhancement,row,col,n,p,t,sname,ename,ModHD,ModHDParam,resMetricFile,resParamsFile,flag,thflag ,''); 
%%      <2> thinSkeleton:
%     %-------------------------------------------------------------------------
    skeleton  = 'thinSkeleton'; row = 2 ; ns = 1; sname = 'ThinS'; thflag = 1;
 %%      (1) globalThresh
    enhancement = 'globalThresh'; col = 1; ename ='GT'; ne = 1; n = ne + ns + thflag;
    [ModHD,ModHDParam] = genaticCombo(I,target,img,skeleton,enhancement,row,col,n,p,t,sname,ename,ModHD,ModHDParam,resMetricFile,resParamsFile,flag,thflag ,''); 
 %%      (2) otsuThresh
    enhancement = 'otsuThresh'; col = 2; ename ='OT'; ne = 1; n = ne + ns + thflag;
    [ModHD,ModHDParam] = genaticCombo(I,target,img,skeleton,enhancement,row,col,n,p,t,sname,ename,ModHD,ModHDParam,resMetricFile,resParamsFile,flag,thflag ,''); 
 %%      (3) gaussianSteerableFilters
    enhancement = 'gaussianSteerableFilters'; col = 3; ename ='GS'; ne = 3; n = ne + ns + thflag;
    [ModHD,ModHDParam] = genaticCombo(I,target,img,skeleton,enhancement,row,col,n,p,t,sname,ename,ModHD,ModHDParam,resMetricFile,resParamsFile,flag,thflag ,''); 
 %%      (4) CLAHE
    enhancement = 'CLAHE'; col = 4; ename ='CLAHE'; ne = 1; n = ne + ns + thflag;
    [ModHD,ModHDParam] = genaticCombo(I,target,img,skeleton,enhancement,row,col,n,p,t,sname,ename,ModHD,ModHDParam,resMetricFile,resParamsFile,flag,thflag ,''); 
 %%      (5) vesselness
    enhancement = 'vesselness';col = 5; ename ='V'; ne = 7; n = ne + ns + thflag;
    [ModHD,ModHDParam] = genaticCombo(I,target,img,skeleton,enhancement,row,col,n,p,t,sname,ename,ModHD,ModHDParam,resMetricFile,resParamsFile,flag,thflag ,''); 
 %%      (6) localTensorVesselness
    enhancement = 'localTensorVesselness'; col = 6; ename ='LTV'; ne = 8; n = ne + ns + thflag;
    [ModHD,ModHDParam] = genaticCombo(I,target,img,skeleton,enhancement,row,col,n,p,t,sname,ename,ModHD,ModHDParam,resMetricFile,resParamsFile,flag,thflag ,''); 
 %%      (7) phaseVesselnessFilter
    enhancement = 'phaseVesselnessFilter'; col = 7; ename ='PCTV'; ne = 8; n = ne + ns + thflag;
    [ModHD,ModHDParam] = genaticCombo(I,target,img,skeleton,enhancement,row,col,n,p,t,sname,ename,ModHD,ModHDParam,resMetricFile,resParamsFile,flag,thflag ,''); 
 %%      (8) localHistEq
    enhancement = 'localHistEq';col = 8; ename ='LHE'; ne = 2; n = ne + ns + thflag;
    [ModHD,ModHDParam] = genaticCombo(I,target,img,skeleton,enhancement,row,col,n,p,t,sname,ename,ModHD,ModHDParam,resMetricFile,resParamsFile,flag,thflag ,''); 
%%       (9) topHat 
    enhancement = 'topHat'; col = 9; ename ='TH'; ne = 2; n = ne + ns + thflag;
    [ModHD,ModHDParam] = genaticCombo(I,target,img,skeleton,enhancement,row,col,n,p,t,sname,ename,ModHD,ModHDParam,resMetricFile,resParamsFile,flag,thflag ,''); 
%%       (10) adaptiveThresh 
    enhancement = 'adaptiveThresh'; col = 10; ename ='AT'; ne = 1; n = ne + ns + thflag;
    [ModHD,ModHDParam] = genaticCombo(I,target,img,skeleton,enhancement,row,col,n,p,t,sname,ename,ModHD,ModHDParam,resMetricFile,resParamsFile,flag,thflag ,''); 
%%       (11) phaseNeuritenessFilter
    enhancement = 'phaseNeuritenessFilter'; col = 11; ename ='PCTneurit'; ne = 9; n = ne + ns + thflag;
    [ModHD,ModHDParam] = genaticCombo(I,target,img,skeleton,enhancement,row,col,n,p,t,sname,ename,ModHD,ModHDParam,resMetricFile,resParamsFile,flag,thflag ,''); 
%%       (12) fcnBPDFHE
    enhancement = 'fcnBPDFHE'; col = 12; ename ='fcnBPDFHE'; ne = 10; n = ne + ns + thflag;
    [ModHD,ModHDParam] = genaticCombo(I,target,img,skeleton,enhancement,row,col,n,p,t,sname,ename,ModHD,ModHDParam,resMetricFile,resParamsFile,flag,thflag ,''); 
%%       (13) hysteresisThresh
    enhancement = 'hysteresisThresh'; col = 13; ename ='HT'; ne = 3; n = ne + ns + thflag;
    [ModHD,ModHDParam] = genaticCombo(I,target,img,skeleton,enhancement,row,col,n,p,t,sname,ename,ModHD,ModHDParam,resMetricFile,resParamsFile,flag,thflag ,''); 
%%       (14) phaseCongurency
    enhancement = 'phaseCongurency'; col = 14; ename ='PCT'; ne = 9; n = ne + ns + thflag;
    [ModHD,ModHDParam] = genaticCombo(I,target,img,skeleton,enhancement,row,col,n,p,t,sname,ename,ModHD,ModHDParam,resMetricFile,resParamsFile,flag,thflag ,''); 
%%       (15) iuwt
    enhancement = 'iuwt';  col = 15; ename ='iuwt'; ne = 2; n = ne + ns + thflag;
    [ModHD,ModHDParam] = genaticCombo(I,target,img,skeleton,enhancement,row,col,n,p,t,sname,ename,ModHD,ModHDParam,resMetricFile,resParamsFile,flag,thflag ,''); 
%%       (16) neuriteneesFilter
    enhancement = 'neuriteneesFilter'; col = 16; ename ='neurit'; ne = 1; n = ne + ns + thflag;
    [ModHD,ModHDParam] = genaticCombo(I,target,img,skeleton,enhancement,row,col,n,p,t,sname,ename,ModHD,ModHDParam,resMetricFile,resParamsFile,flag,thflag ,''); 
%%       (17) anIsotropicGaussianKernelEnhancement
    enhancement = 'anIsotropicGaussianKernelEnhancement';  col = 17; ename ='IGK';ne = 13; n = ne + ns + thflag;
    [ModHD,ModHDParam] = genaticCombo(I,target,img,skeleton,enhancement,row,col,n,p,t,sname,ename,ModHD,ModHDParam,resMetricFile,resParamsFile,flag,thflag ,''); 
%%       (18) SCIRD
    enhancement = 'SCIRD'; col = 18; ename ='SCIRD'; ne = 12; n = ne + ns + thflag;
    [ModHD,ModHDParam] = genaticCombo(I,target,img,skeleton,enhancement,row,col,n,p,t,sname,ename,ModHD,ModHDParam,resMetricFile,resParamsFile,flag,thflag ,'');  
%%       (19) volumeRatio
    enhancement = 'volumeRatio'; col = 19; ename ='VR'; ne = 6; n = ne + ns + thflag;
    [ModHD,ModHDParam] = genaticCombo(I,target,img,skeleton,enhancement,row,col,n,p,t,sname,ename,ModHD,ModHDParam,resMetricFile,resParamsFile,flag,thflag ,''); 
%%       (20) bowlerHat
    enhancement = 'bowlerHat'; col = 20; ename ='BH'; ne = 3; n = ne + ns + thflag;
    [ModHD,ModHDParam] = genaticCombo(I,target,img,skeleton,enhancement,row,col,n,p,t,sname,ename,ModHD,ModHDParam,resMetricFile,resParamsFile,flag,thflag ,'');  
%%      <3> shockGraphSkel:
%%%    -------------------------------------------------------------------------
    skeleton  = 'shockGraphSkel'; row = 3 ; ns = 3; sname = 'SG'; thflag = 0;
     %%      (1) globalThresh
    enhancement = 'globalThresh'; col = 1; ename ='GT'; ne = 1; n = ne + ns + thflag;
    [ModHD,ModHDParam] = genaticCombo(I,target,img,skeleton,enhancement,row,col,n,p,t,sname,ename,ModHD,ModHDParam,resMetricFile,resParamsFile,flag,thflag ,''); 
 %%      (2) otsuThresh
    enhancement = 'otsuThresh'; col = 2; ename ='OT'; ne = 1; n = ne + ns + thflag;
    [ModHD,ModHDParam] = genaticCombo(I,target,img,skeleton,enhancement,row,col,n,p,t,sname,ename,ModHD,ModHDParam,resMetricFile,resParamsFile,flag,thflag ,''); 
 %%      (3) gaussianSteerableFilters
    enhancement = 'gaussianSteerableFilters'; col = 3; ename ='GS'; ne = 3; n = ne + ns + thflag;
    [ModHD,ModHDParam] = genaticCombo(I,target,img,skeleton,enhancement,row,col,n,p,t,sname,ename,ModHD,ModHDParam,resMetricFile,resParamsFile,flag,thflag ,''); 
 %%      (4) CLAHE
    enhancement = 'CLAHE'; col = 4; ename ='CLAHE'; ne = 1; n = ne + ns + thflag;
    [ModHD,ModHDParam] = genaticCombo(I,target,img,skeleton,enhancement,row,col,n,p,t,sname,ename,ModHD,ModHDParam,resMetricFile,resParamsFile,flag,thflag ,''); 
 %%      (5) vesselness
    enhancement = 'vesselness';col = 5; ename ='V'; ne = 7; n = ne + ns + thflag;
    [ModHD,ModHDParam] = genaticCombo(I,target,img,skeleton,enhancement,row,col,n,p,t,sname,ename,ModHD,ModHDParam,resMetricFile,resParamsFile,flag,thflag ,''); 
 %%      (6) localTensorVesselness
    enhancement = 'localTensorVesselness'; col = 6; ename ='LTV'; ne = 8; n = ne + ns + thflag;
    [ModHD,ModHDParam] = genaticCombo(I,target,img,skeleton,enhancement,row,col,n,p,t,sname,ename,ModHD,ModHDParam,resMetricFile,resParamsFile,flag,thflag ,''); 
 %%      (7) phaseVesselnessFilter
    enhancement = 'phaseVesselnessFilter'; col = 7; ename ='PCTV'; ne = 8; n = ne + ns + thflag;
    [ModHD,ModHDParam] = genaticCombo(I,target,img,skeleton,enhancement,row,col,n,p,t,sname,ename,ModHD,ModHDParam,resMetricFile,resParamsFile,flag,thflag ,''); 
 %%      (8) localHistEq
    enhancement = 'localHistEq';col = 8; ename ='LHE'; ne = 2; n = ne + ns + thflag;
    [ModHD,ModHDParam] = genaticCombo(I,target,img,skeleton,enhancement,row,col,n,p,t,sname,ename,ModHD,ModHDParam,resMetricFile,resParamsFile,flag,thflag ,''); 
%%       (9) topHat 
    enhancement = 'topHat'; col = 9; ename ='TH'; ne = 2; n = ne + ns + thflag;
    [ModHD,ModHDParam] = genaticCombo(I,target,img,skeleton,enhancement,row,col,n,p,t,sname,ename,ModHD,ModHDParam,resMetricFile,resParamsFile,flag,thflag ,''); 
%%       (10) adaptiveThresh 
    enhancement = 'adaptiveThresh'; col = 10; ename ='AT'; ne = 1; n = ne + ns + thflag;
    [ModHD,ModHDParam] = genaticCombo(I,target,img,skeleton,enhancement,row,col,n,p,t,sname,ename,ModHD,ModHDParam,resMetricFile,resParamsFile,flag,thflag ,''); 
%%       (11) phaseNeuritenessFilter
    enhancement = 'phaseNeuritenessFilter'; col = 11; ename ='PCTneurit'; ne = 9; n = ne + ns + thflag;
    [ModHD,ModHDParam] = genaticCombo(I,target,img,skeleton,enhancement,row,col,n,p,t,sname,ename,ModHD,ModHDParam,resMetricFile,resParamsFile,flag,thflag ,''); 
%%       (12) fcnBPDFHE
    enhancement = 'fcnBPDFHE'; col = 12; ename ='fcnBPDFHE'; ne = 10; n = ne + ns + thflag;
    [ModHD,ModHDParam] = genaticCombo(I,target,img,skeleton,enhancement,row,col,n,p,t,sname,ename,ModHD,ModHDParam,resMetricFile,resParamsFile,flag,thflag ,''); 
%%       (13) hysteresisThresh
    enhancement = 'hysteresisThresh'; col = 13; ename ='HT'; ne = 3; n = ne + ns + thflag;
    [ModHD,ModHDParam] = genaticCombo(I,target,img,skeleton,enhancement,row,col,n,p,t,sname,ename,ModHD,ModHDParam,resMetricFile,resParamsFile,flag,thflag ,''); 
%%       (14) phaseCongurency
    enhancement = 'phaseCongurency'; col = 14; ename ='PCT'; ne = 9; n = ne + ns + thflag;
    [ModHD,ModHDParam] = genaticCombo(I,target,img,skeleton,enhancement,row,col,n,p,t,sname,ename,ModHD,ModHDParam,resMetricFile,resParamsFile,flag,thflag ,''); 
%%       (15) iuwt
    enhancement = 'iuwt';  col = 15; ename ='iuwt'; ne = 2; n = ne + ns + thflag;
    [ModHD,ModHDParam] = genaticCombo(I,target,img,skeleton,enhancement,row,col,n,p,t,sname,ename,ModHD,ModHDParam,resMetricFile,resParamsFile,flag,thflag ,''); 
%%       (16) neuriteneesFilter
    enhancement = 'neuriteneesFilter'; col = 16; ename ='neurit'; ne = 1; n = ne + ns + thflag;
    [ModHD,ModHDParam] = genaticCombo(I,target,img,skeleton,enhancement,row,col,n,p,t,sname,ename,ModHD,ModHDParam,resMetricFile,resParamsFile,flag,thflag ,''); 
%%       (17) anIsotropicGaussianKernelEnhancement
    enhancement = 'anIsotropicGaussianKernelEnhancement';  col = 17; ename ='IGK';ne = 13; n = ne + ns + thflag;
    [ModHD,ModHDParam] = genaticCombo(I,target,img,skeleton,enhancement,row,col,n,p,t,sname,ename,ModHD,ModHDParam,resMetricFile,resParamsFile,flag,thflag ,''); 
%%       (18) SCIRD
    enhancement = 'SCIRD'; col = 18; ename ='SCIRD'; ne = 12; n = ne + ns + thflag;
    [ModHD,ModHDParam] = genaticCombo(I,target,img,skeleton,enhancement,row,col,n,p,t,sname,ename,ModHD,ModHDParam,resMetricFile,resParamsFile,flag,thflag ,'');  
%%       (19) volumeRatio
    enhancement = 'volumeRatio'; col = 19; ename ='VR'; ne = 6; n = ne + ns + thflag;
    [ModHD,ModHDParam] = genaticCombo(I,target,img,skeleton,enhancement,row,col,n,p,t,sname,ename,ModHD,ModHDParam,resMetricFile,resParamsFile,flag,thflag ,''); 
%% (20) path opening
    enhancement = 'pathOpening'; col = 20; ename ='PO'; ne = 4; n = ne + ns + thflag;
    [ModHD,ModHDParam] = genaticCombo(I,target,img,skeleton,enhancement,row,col,n,p,t,sname,ename,ModHD,ModHDParam,resMetricFile,resParamsFile,flag,thflag ,'');      
%%       <4> morphSkeleton
%    %%-------------------------------------------------------------------------
    skeleton  = 'morphSkeleton';row = 4 ; ns = 1;sname = 'MS'; thflag = 1;
     %%      (1) globalThresh
    enhancement = 'globalThresh'; col = 1; ename ='GT'; ne = 1; n = ne + ns + thflag;
    [ModHD,ModHDParam] = genaticCombo(I,target,img,skeleton,enhancement,row,col,n,p,t,sname,ename,ModHD,ModHDParam,resMetricFile,resParamsFile,flag,thflag ,''); 
 %%      (2) otsuThresh
    enhancement = 'otsuThresh'; col = 2; ename ='OT'; ne = 1; n = ne + ns + thflag;
    [ModHD,ModHDParam] = genaticCombo(I,target,img,skeleton,enhancement,row,col,n,p,t,sname,ename,ModHD,ModHDParam,resMetricFile,resParamsFile,flag,thflag ,''); 
 %%      (3) gaussianSteerableFilters
    enhancement = 'gaussianSteerableFilters'; col = 3; ename ='GS'; ne = 3; n = ne + ns + thflag;
    [ModHD,ModHDParam] = genaticCombo(I,target,img,skeleton,enhancement,row,col,n,p,t,sname,ename,ModHD,ModHDParam,resMetricFile,resParamsFile,flag,thflag ,''); 
 %%      (4) CLAHE
    enhancement = 'CLAHE'; col = 4; ename ='CLAHE'; ne = 1; n = ne + ns + thflag;
    [ModHD,ModHDParam] = genaticCombo(I,target,img,skeleton,enhancement,row,col,n,p,t,sname,ename,ModHD,ModHDParam,resMetricFile,resParamsFile,flag,thflag ,''); 
 %%      (5) vesselness
    enhancement = 'vesselness';col = 5; ename ='V'; ne = 7; n = ne + ns + thflag;
    [ModHD,ModHDParam] = genaticCombo(I,target,img,skeleton,enhancement,row,col,n,p,t,sname,ename,ModHD,ModHDParam,resMetricFile,resParamsFile,flag,thflag ,''); 
 %%      (6) localTensorVesselness
    enhancement = 'localTensorVesselness'; col = 6; ename ='LTV'; ne = 8; n = ne + ns + thflag;
    [ModHD,ModHDParam] = genaticCombo(I,target,img,skeleton,enhancement,row,col,n,p,t,sname,ename,ModHD,ModHDParam,resMetricFile,resParamsFile,flag,thflag ,''); 
 %%      (7) phaseVesselnessFilter
    enhancement = 'phaseVesselnessFilter'; col = 7; ename ='PCTV'; ne = 8; n = ne + ns + thflag;
    [ModHD,ModHDParam] = genaticCombo(I,target,img,skeleton,enhancement,row,col,n,p,t,sname,ename,ModHD,ModHDParam,resMetricFile,resParamsFile,flag,thflag ,''); 
 %%      (8) localHistEq
    enhancement = 'localHistEq';col = 8; ename ='LHE'; ne = 2; n = ne + ns + thflag;
    [ModHD,ModHDParam] = genaticCombo(I,target,img,skeleton,enhancement,row,col,n,p,t,sname,ename,ModHD,ModHDParam,resMetricFile,resParamsFile,flag,thflag ,''); 
%%       (9) topHat 
    enhancement = 'topHat'; col = 9; ename ='TH'; ne = 2; n = ne + ns + thflag;
    [ModHD,ModHDParam] = genaticCombo(I,target,img,skeleton,enhancement,row,col,n,p,t,sname,ename,ModHD,ModHDParam,resMetricFile,resParamsFile,flag,thflag ,''); 
%%       (10) adaptiveThresh 
    enhancement = 'adaptiveThresh'; col = 10; ename ='AT'; ne = 1; n = ne + ns + thflag;
    [ModHD,ModHDParam] = genaticCombo(I,target,img,skeleton,enhancement,row,col,n,p,t,sname,ename,ModHD,ModHDParam,resMetricFile,resParamsFile,flag,thflag ,''); 
%%       (11) phaseNeuritenessFilter
    enhancement = 'phaseNeuritenessFilter'; col = 11; ename ='PCTneurit'; ne = 9; n = ne + ns + thflag;
    [ModHD,ModHDParam] = genaticCombo(I,target,img,skeleton,enhancement,row,col,n,p,t,sname,ename,ModHD,ModHDParam,resMetricFile,resParamsFile,flag,thflag ,''); 
%%       (12) fcnBPDFHE
    enhancement = 'fcnBPDFHE'; col = 12; ename ='fcnBPDFHE'; ne = 10; n = ne + ns + thflag;
    [ModHD,ModHDParam] = genaticCombo(I,target,img,skeleton,enhancement,row,col,n,p,t,sname,ename,ModHD,ModHDParam,resMetricFile,resParamsFile,flag,thflag ,''); 
%%       (13) hysteresisThresh
    enhancement = 'hysteresisThresh'; col = 13; ename ='HT'; ne = 3; n = ne + ns + thflag;
    [ModHD,ModHDParam] = genaticCombo(I,target,img,skeleton,enhancement,row,col,n,p,t,sname,ename,ModHD,ModHDParam,resMetricFile,resParamsFile,flag,thflag ,''); 
%%       (14) phaseCongurency
    enhancement = 'phaseCongurency'; col = 14; ename ='PCT'; ne = 9; n = ne + ns + thflag;
    [ModHD,ModHDParam] = genaticCombo(I,target,img,skeleton,enhancement,row,col,n,p,t,sname,ename,ModHD,ModHDParam,resMetricFile,resParamsFile,flag,thflag ,''); 
%%       (15) iuwt
    enhancement = 'iuwt';  col = 15; ename ='iuwt'; ne = 2; n = ne + ns + thflag;
    [ModHD,ModHDParam] = genaticCombo(I,target,img,skeleton,enhancement,row,col,n,p,t,sname,ename,ModHD,ModHDParam,resMetricFile,resParamsFile,flag,thflag ,''); 
%%       (16) neuriteneesFilter
    enhancement = 'neuriteneesFilter'; col = 16; ename ='neurit'; ne = 1; n = ne + ns + thflag;
    [ModHD,ModHDParam] = genaticCombo(I,target,img,skeleton,enhancement,row,col,n,p,t,sname,ename,ModHD,ModHDParam,resMetricFile,resParamsFile,flag,thflag ,''); 
%%       (17) anIsotropicGaussianKernelEnhancement
    enhancement = 'anIsotropicGaussianKernelEnhancement';  col = 17; ename ='IGK';ne = 13; n = ne + ns + thflag;
    [ModHD,ModHDParam] = genaticCombo(I,target,img,skeleton,enhancement,row,col,n,p,t,sname,ename,ModHD,ModHDParam,resMetricFile,resParamsFile,flag,thflag ,''); 
%%       (18) SCIRD
    enhancement = 'SCIRD'; col = 18; ename ='SCIRD'; ne = 12; n = ne + ns + thflag;
    [ModHD,ModHDParam] = genaticCombo(I,target,img,skeleton,enhancement,row,col,n,p,t,sname,ename,ModHD,ModHDParam,resMetricFile,resParamsFile,flag,thflag ,'');  
%%       (19) volumeRatio
    enhancement = 'volumeRatio'; col = 19; ename ='VR'; ne = 6; n = ne + ns + thflag;
    [ModHD,ModHDParam] = genaticCombo(I,target,img,skeleton,enhancement,row,col,n,p,t,sname,ename,ModHD,ModHDParam,resMetricFile,resParamsFile,flag,thflag ,''); 
%%       (20) path opening
    enhancement = 'pathOpening'; col = 20; ename ='PO'; ne = 4; n = ne + ns + thflag;
    [ModHD,ModHDParam] = genaticCombo(I,target,img,skeleton,enhancement,row,col,n,p,t,sname,ename,ModHD,ModHDParam,resMetricFile,resParamsFile,flag,thflag ,'');      
%%      <5> edgeLindberg
%%%   -------------------------------------------------------------------------
    skeleton  = 'edgeLindberg'; row = 5 ; ns = 2; sname = 'Lindberg'; thflag = 0;
   %%      (1) globalThresh
    enhancement = 'globalThresh'; col = 1; ename ='GT'; ne = 1; n = ne + ns + thflag;
    [ModHD,ModHDParam] = genaticCombo(I,target,img,skeleton,enhancement,row,col,n,p,t,sname,ename,ModHD,ModHDParam,resMetricFile,resParamsFile,flag,thflag ,''); 
 %%      (2) otsuThresh
    enhancement = 'otsuThresh'; col = 2; ename ='OT'; ne = 1; n = ne + ns + thflag;
    [ModHD,ModHDParam] = genaticCombo(I,target,img,skeleton,enhancement,row,col,n,p,t,sname,ename,ModHD,ModHDParam,resMetricFile,resParamsFile,flag,thflag ,''); 
 %%      (3) gaussianSteerableFilters
    enhancement = 'gaussianSteerableFilters'; col = 3; ename ='GS'; ne = 3; n = ne + ns + thflag;
    [ModHD,ModHDParam] = genaticCombo(I,target,img,skeleton,enhancement,row,col,n,p,t,sname,ename,ModHD,ModHDParam,resMetricFile,resParamsFile,flag,thflag ,''); 
 %%      (4) CLAHE
    enhancement = 'CLAHE'; col = 4; ename ='CLAHE'; ne = 1; n = ne + ns + thflag;
    [ModHD,ModHDParam] = genaticCombo(I,target,img,skeleton,enhancement,row,col,n,p,t,sname,ename,ModHD,ModHDParam,resMetricFile,resParamsFile,flag,thflag ,''); 
 %%      (5) vesselness
    enhancement = 'vesselness';col = 5; ename ='V'; ne = 7; n = ne + ns + thflag;
    [ModHD,ModHDParam] = genaticCombo(I,target,img,skeleton,enhancement,row,col,n,p,t,sname,ename,ModHD,ModHDParam,resMetricFile,resParamsFile,flag,thflag ,''); 
 %%      (6) localTensorVesselness
    enhancement = 'localTensorVesselness'; col = 6; ename ='LTV'; ne = 8; n = ne + ns + thflag;
    [ModHD,ModHDParam] = genaticCombo(I,target,img,skeleton,enhancement,row,col,n,p,t,sname,ename,ModHD,ModHDParam,resMetricFile,resParamsFile,flag,thflag ,''); 
 %%      (7) phaseVesselnessFilter
    enhancement = 'phaseVesselnessFilter'; col = 7; ename ='PCTV'; ne = 8; n = ne + ns + thflag;
    [ModHD,ModHDParam] = genaticCombo(I,target,img,skeleton,enhancement,row,col,n,p,t,sname,ename,ModHD,ModHDParam,resMetricFile,resParamsFile,flag,thflag ,''); 
 %%      (8) localHistEq
    enhancement = 'localHistEq';col = 8; ename ='LHE'; ne = 2; n = ne + ns + thflag;
    [ModHD,ModHDParam] = genaticCombo(I,target,img,skeleton,enhancement,row,col,n,p,t,sname,ename,ModHD,ModHDParam,resMetricFile,resParamsFile,flag,thflag ,''); 
%%       (9) topHat 
    enhancement = 'topHat'; col = 9; ename ='TH'; ne = 2; n = ne + ns + thflag;
    [ModHD,ModHDParam] = genaticCombo(I,target,img,skeleton,enhancement,row,col,n,p,t,sname,ename,ModHD,ModHDParam,resMetricFile,resParamsFile,flag,thflag ,''); 
%%       (10) adaptiveThresh 
    enhancement = 'adaptiveThresh'; col = 10; ename ='AT'; ne = 1; n = ne + ns + thflag;
    [ModHD,ModHDParam] = genaticCombo(I,target,img,skeleton,enhancement,row,col,n,p,t,sname,ename,ModHD,ModHDParam,resMetricFile,resParamsFile,flag,thflag ,''); 
%%       (11) phaseNeuritenessFilter
    enhancement = 'phaseNeuritenessFilter'; col = 11; ename ='PCTneurit'; ne = 9; n = ne + ns + thflag;
    [ModHD,ModHDParam] = genaticCombo(I,target,img,skeleton,enhancement,row,col,n,p,t,sname,ename,ModHD,ModHDParam,resMetricFile,resParamsFile,flag,thflag ,''); 
%%       (12) fcnBPDFHE
    enhancement = 'fcnBPDFHE'; col = 12; ename ='fcnBPDFHE'; ne = 10; n = ne + ns + thflag;
    [ModHD,ModHDParam] = genaticCombo(I,target,img,skeleton,enhancement,row,col,n,p,t,sname,ename,ModHD,ModHDParam,resMetricFile,resParamsFile,flag,thflag ,''); 
%%       (13) hysteresisThresh
    enhancement = 'hysteresisThresh'; col = 13; ename ='HT'; ne = 3; n = ne + ns + thflag;
    [ModHD,ModHDParam] = genaticCombo(I,target,img,skeleton,enhancement,row,col,n,p,t,sname,ename,ModHD,ModHDParam,resMetricFile,resParamsFile,flag,thflag ,''); 
%%       (14) phaseCongurency
    enhancement = 'phaseCongurency'; col = 14; ename ='PCT'; ne = 9; n = ne + ns + thflag;
    [ModHD,ModHDParam] = genaticCombo(I,target,img,skeleton,enhancement,row,col,n,p,t,sname,ename,ModHD,ModHDParam,resMetricFile,resParamsFile,flag,thflag ,''); 
%%       (15) iuwt
    enhancement = 'iuwt';  col = 15; ename ='iuwt'; ne = 2; n = ne + ns + thflag;
    [ModHD,ModHDParam] = genaticCombo(I,target,img,skeleton,enhancement,row,col,n,p,t,sname,ename,ModHD,ModHDParam,resMetricFile,resParamsFile,flag,thflag ,''); 
%%       (16) neuriteneesFilter
    enhancement = 'neuriteneesFilter'; col = 16; ename ='neurit'; ne = 1; n = ne + ns + thflag;
    [ModHD,ModHDParam] = genaticCombo(I,target,img,skeleton,enhancement,row,col,n,p,t,sname,ename,ModHD,ModHDParam,resMetricFile,resParamsFile,flag,thflag ,''); 
%%       (17) anIsotropicGaussianKernelEnhancement
    enhancement = 'anIsotropicGaussianKernelEnhancement';  col = 17; ename ='IGK';ne = 13; n = ne + ns + thflag;
    [ModHD,ModHDParam] = genaticCombo(I,target,img,skeleton,enhancement,row,col,n,p,t,sname,ename,ModHD,ModHDParam,resMetricFile,resParamsFile,flag,thflag ,''); 
%%       (18) SCIRD
    enhancement = 'SCIRD'; col = 18; ename ='SCIRD'; ne = 12; n = ne + ns + thflag;
    [ModHD,ModHDParam] = genaticCombo(I,target,img,skeleton,enhancement,row,col,n,p,t,sname,ename,ModHD,ModHDParam,resMetricFile,resParamsFile,flag,thflag ,'');  
%%       (19) volumeRatio
    enhancement = 'volumeRatio'; col = 19; ename ='VR'; ne = 6; n = ne + ns + thflag;
    [ModHD,ModHDParam] = genaticCombo(I,target,img,skeleton,enhancement,row,col,n,p,t,sname,ename,ModHD,ModHDParam,resMetricFile,resParamsFile,flag,thflag ,''); 
%%       (20) path opening
    enhancement = 'pathOpening'; col = 20; ename ='PO'; ne = 4; n = ne + ns + thflag;
    [ModHD,ModHDParam] = genaticCombo(I,target,img,skeleton,enhancement,row,col,n,p,t,sname,ename,ModHD,ModHDParam,resMetricFile,resParamsFile,flag,thflag ,'');      

    %%       <6> stegerSkel(Java version)
%%    -------------------------------------------------------------------------
    skeleton  = 'stegerSkelJava';row = 6 ; ns = 4; sname = 'steger'; thflag = 0;
 %%      (1) globalThresh
    enhancement = 'globalThresh'; col = 1; ename ='GT'; ne = 1; n = ne + ns + thflag;
    [ModHD,ModHDParam] = genaticCombo(I,target,img,skeleton,enhancement,row,col,n,p,t,sname,ename,ModHD,ModHDParam,resMetricFile,resParamsFile,flag,thflag ,'.tif'); 
 %%      (2) otsuThresh
    enhancement = 'otsuThresh'; col = 2; ename ='OT'; ne = 1; n = ne + ns + thflag;
    [ModHD,ModHDParam] = genaticCombo(I,target,img,skeleton,enhancement,row,col,n,p,t,sname,ename,ModHD,ModHDParam,resMetricFile,resParamsFile,flag,thflag ,'.tif'); 
 %%      (3) gaussianSteerableFilters
    enhancement = 'gaussianSteerableFilters'; col = 3; ename ='GS'; ne = 3; n = ne + ns + thflag;
    [ModHD,ModHDParam] = genaticCombo(I,target,img,skeleton,enhancement,row,col,n,p,t,sname,ename,ModHD,ModHDParam,resMetricFile,resParamsFile,flag,thflag ,'.tif'); 
%%       (4) CLAHE
    enhancement = 'CLAHE'; col = 4; ename ='CLAHE'; ne = 1; n = ne + ns + thflag;
    [ModHD,ModHDParam] = genaticCombo(I,target,img,skeleton,enhancement,row,col,n,p,t,sname,ename,ModHD,ModHDParam,resMetricFile,resParamsFile,flag,thflag ,'.tif'); 
 %%      (5) vesselness
    enhancement = 'vesselness';col = 5; ename ='V'; ne = 7; n = ne + ns + thflag;
    [ModHD,ModHDParam] = genaticCombo(I,target,img,skeleton,enhancement,row,col,n,p,t,sname,ename,ModHD,ModHDParam,resMetricFile,resParamsFile,flag,thflag ,'.tif'); 
 %%      (6) localTensorVesselness
    enhancement = 'localTensorVesselness'; col = 6; ename ='LTV'; ne = 8; n = ne + ns + thflag;
    [ModHD,ModHDParam] = genaticCombo(I,target,img,skeleton,enhancement,row,col,n,p,t,sname,ename,ModHD,ModHDParam,resMetricFile,resParamsFile,flag,thflag ,'.tif'); 
 %%      (7) phaseVesselnessFilter
    enhancement = 'phaseVesselnessFilter'; col = 7; ename ='PCTV'; ne = 8; n = ne + ns + thflag;
    [ModHD,ModHDParam] = genaticCombo(I,target,img,skeleton,enhancement,row,col,n,p,t,sname,ename,ModHD,ModHDParam,resMetricFile,resParamsFile,flag,thflag ,'.tif'); 
%%      (8) localHistEq
    enhancement = 'localHistEq';col = 8; ename ='LHE'; ne = 2; n = ne + ns + thflag;
    [ModHD,ModHDParam] = genaticCombo(I,target,img,skeleton,enhancement,row,col,n,p,t,sname,ename,ModHD,ModHDParam,resMetricFile,resParamsFile,flag,thflag ,'.tif'); 
%%       (9) topHat 
    enhancement = 'topHat'; col = 9; ename ='TH'; ne = 2; n = ne + ns + thflag;
    [ModHD,ModHDParam] = genaticCombo(I,target,img,skeleton,enhancement,row,col,n,p,t,sname,ename,ModHD,ModHDParam,resMetricFile,resParamsFile,flag,thflag ,'.tif'); 
%%       (10) adaptiveThresh 
    enhancement = 'adaptiveThresh'; col = 10; ename ='AT'; ne = 1; n = ne + ns + thflag;
    [ModHD,ModHDParam] = genaticCombo(I,target,img,skeleton,enhancement,row,col,n,p,t,sname,ename,ModHD,ModHDParam,resMetricFile,resParamsFile,flag,thflag ,'.tif'); 
%%       (11) phaseNeuritenessFilter
    enhancement = 'phaseNeuritenessFilter'; col = 11; ename ='PCTneurit'; ne = 9; n = ne + ns + thflag;
    [ModHD,ModHDParam] = genaticCombo(I,target,img,skeleton,enhancement,row,col,n,p,t,sname,ename,ModHD,ModHDParam,resMetricFile,resParamsFile,flag,thflag ,'.tif'); 
%%       (12) fcnBPDFHE
    enhancement = 'fcnBPDFHE'; col = 12; ename ='fcnBPDFHE'; ne = 10; n = ne + ns + thflag;
    [ModHD,ModHDParam] = genaticCombo(I,target,img,skeleton,enhancement,row,col,n,p,t,sname,ename,ModHD,ModHDParam,resMetricFile,resParamsFile,flag,thflag ,'.tif'); 
%%       (13) hysteresisThresh
    enhancement = 'hysteresisThresh'; col = 13; ename ='HT'; ne = 3; n = ne + ns + thflag;
    [ModHD,ModHDParam] = genaticCombo(I,target,img,skeleton,enhancement,row,col,n,p,t,sname,ename,ModHD,ModHDParam,resMetricFile,resParamsFile,flag,thflag ,'.tif'); 
%%       (14) phaseCongurency
    enhancement = 'phaseCongurency'; col = 14; ename ='PCT'; ne = 9; n = ne + ns + thflag;
    [ModHD,ModHDParam] = genaticCombo(I,target,img,skeleton,enhancement,row,col,n,p,t,sname,ename,ModHD,ModHDParam,resMetricFile,resParamsFile,flag,thflag ,'.tif'); 
%%       (15) iuwt
    enhancement = 'iuwt';  col = 15; ename ='iuwt'; ne = 2; n = ne + ns + thflag;
    [ModHD,ModHDParam] = genaticCombo(I,target,img,skeleton,enhancement,row,col,n,p,t,sname,ename,ModHD,ModHDParam,resMetricFile,resParamsFile,flag,thflag ,'.tif'); 
%%       (16) neuriteneesFilter
    enhancement = 'neuriteneesFilter'; col = 16; ename ='neurit'; ne = 1; n = ne + ns + thflag;
    [ModHD,ModHDParam] = genaticCombo(I,target,img,skeleton,enhancement,row,col,n,p,t,sname,ename,ModHD,ModHDParam,resMetricFile,resParamsFile,flag,thflag ,'.tif'); 
%%       (17) anIsotropicGaussianKernelEnhancement
    enhancement = 'anIsotropicGaussianKernelEnhancement';  col = 17; ename ='IGK';ne = 13; n = ne + ns + thflag;
    [ModHD,ModHDParam] = genaticCombo(I,target,img,skeleton,enhancement,row,col,n,p,t,sname,ename,ModHD,ModHDParam,resMetricFile,resParamsFile,flag,thflag ,'.tif'); 
%%       (18) SCIRD
    enhancement = 'SCIRD'; col = 18; ename ='SCIRD'; ne = 12; n = ne + ns + thflag;
    [ModHD,ModHDParam] = genaticCombo(I,target,img,skeleton,enhancement,row,col,n,p,t,sname,ename,ModHD,ModHDParam,resMetricFile,resParamsFile,flag,thflag ,'.tif');  
%%       (19) volumeRatio
    enhancement = 'volumeRatio'; col = 19; ename ='VR'; ne = 6; n = ne + ns + thflag;
    [ModHD,ModHDParam] = genaticCombo(I,target,img,skeleton,enhancement,row,col,n,p,t,sname,ename,ModHD,ModHDParam,resMetricFile,resParamsFile,flag,thflag ,'.tif'); 
%%       (20) bowlerHat
    enhancement = 'bowlerHat'; col = 20; ename ='BH'; ne = 3; n = ne + ns + thflag;
    [ModHD,ModHDParam] = genaticCombo(I,target,img,skeleton,enhancement,row,col,n,p,t,sname,ename,ModHD,ModHDParam,resMetricFile,resParamsFile,flag,thflag ,'.tif'); 
    
%%   <7> voronoiSkel :
%%%    -------------------------------------------------------------------------
	skeleton  = 'voronoiSkel'; row = 7 ; ns = 4; sname = 'vd'; thflag = 0;
    %%      (1) globalThresh
    enhancement = 'globalThresh'; col = 1; ename ='GT'; ne = 1; n = ne + ns + thflag;
    [ModHD,ModHDParam] = genaticCombo(I,target,img,skeleton,enhancement,row,col,n,p,t,sname,ename,ModHD,ModHDParam,resMetricFile,resParamsFile,flag,thflag ,''); 
 %%      (2) otsuThresh
    enhancement = 'otsuThresh'; col = 2; ename ='OT'; ne = 1; n = ne + ns + thflag;
    [ModHD,ModHDParam] = genaticCombo(I,target,img,skeleton,enhancement,row,col,n,p,t,sname,ename,ModHD,ModHDParam,resMetricFile,resParamsFile,flag,thflag ,''); 
 %%      (3) gaussianSteerableFilters
    enhancement = 'gaussianSteerableFilters'; col = 3; ename ='GS'; ne = 3; n = ne + ns + thflag;
    [ModHD,ModHDParam] = genaticCombo(I,target,img,skeleton,enhancement,row,col,n,p,t,sname,ename,ModHD,ModHDParam,resMetricFile,resParamsFile,flag,thflag ,''); 
 %%      (4) CLAHE
    enhancement = 'CLAHE'; col = 4; ename ='CLAHE'; ne = 1; n = ne + ns + thflag;
    [ModHD,ModHDParam] = genaticCombo(I,target,img,skeleton,enhancement,row,col,n,p,t,sname,ename,ModHD,ModHDParam,resMetricFile,resParamsFile,flag,thflag ,''); 
 %%      (5) vesselness
    enhancement = 'vesselness';col = 5; ename ='V'; ne = 7; n = ne + ns + thflag;
    [ModHD,ModHDParam] = genaticCombo(I,target,img,skeleton,enhancement,row,col,n,p,t,sname,ename,ModHD,ModHDParam,resMetricFile,resParamsFile,flag,thflag ,''); 
 %%      (6) localTensorVesselness
    enhancement = 'localTensorVesselness'; col = 6; ename ='LTV'; ne = 8; n = ne + ns + thflag;
    [ModHD,ModHDParam] = genaticCombo(I,target,img,skeleton,enhancement,row,col,n,p,t,sname,ename,ModHD,ModHDParam,resMetricFile,resParamsFile,flag,thflag ,''); 
 %%      (7) phaseVesselnessFilter
    enhancement = 'phaseVesselnessFilter'; col = 7; ename ='PCTV'; ne = 8; n = ne + ns + thflag;
    [ModHD,ModHDParam] = genaticCombo(I,target,img,skeleton,enhancement,row,col,n,p,t,sname,ename,ModHD,ModHDParam,resMetricFile,resParamsFile,flag,thflag ,''); 
 %%      (8) localHistEq
    enhancement = 'localHistEq';col = 8; ename ='LHE'; ne = 2; n = ne + ns + thflag;
    [ModHD,ModHDParam] = genaticCombo(I,target,img,skeleton,enhancement,row,col,n,p,t,sname,ename,ModHD,ModHDParam,resMetricFile,resParamsFile,flag,thflag ,''); 
%%       (9) topHat 
    enhancement = 'topHat'; col = 9; ename ='TH'; ne = 2; n = ne + ns + thflag;
    [ModHD,ModHDParam] = genaticCombo(I,target,img,skeleton,enhancement,row,col,n,p,t,sname,ename,ModHD,ModHDParam,resMetricFile,resParamsFile,flag,thflag ,''); 
%%       (10) adaptiveThresh 
    enhancement = 'adaptiveThresh'; col = 10; ename ='AT'; ne = 1; n = ne + ns + thflag;
    [ModHD,ModHDParam] = genaticCombo(I,target,img,skeleton,enhancement,row,col,n,p,t,sname,ename,ModHD,ModHDParam,resMetricFile,resParamsFile,flag,thflag ,''); 
%%       (11) phaseNeuritenessFilter
    enhancement = 'phaseNeuritenessFilter'; col = 11; ename ='PCTneurit'; ne = 9; n = ne + ns + thflag;
    [ModHD,ModHDParam] = genaticCombo(I,target,img,skeleton,enhancement,row,col,n,p,t,sname,ename,ModHD,ModHDParam,resMetricFile,resParamsFile,flag,thflag ,''); 
%%       (12) fcnBPDFHE
    enhancement = 'fcnBPDFHE'; col = 12; ename ='fcnBPDFHE'; ne = 10; n = ne + ns + thflag;
    [ModHD,ModHDParam] = genaticCombo(I,target,img,skeleton,enhancement,row,col,n,p,t,sname,ename,ModHD,ModHDParam,resMetricFile,resParamsFile,flag,thflag ,''); 
%%       (13) hysteresisThresh
    enhancement = 'hysteresisThresh'; col = 13; ename ='HT'; ne = 3; n = ne + ns + thflag;
    [ModHD,ModHDParam] = genaticCombo(I,target,img,skeleton,enhancement,row,col,n,p,t,sname,ename,ModHD,ModHDParam,resMetricFile,resParamsFile,flag,thflag ,''); 
%%       (14) phaseCongurency
    enhancement = 'phaseCongurency'; col = 14; ename ='PCT'; ne = 9; n = ne + ns + thflag;
    [ModHD,ModHDParam] = genaticCombo(I,target,img,skeleton,enhancement,row,col,n,p,t,sname,ename,ModHD,ModHDParam,resMetricFile,resParamsFile,flag,thflag ,''); 
%%       (15) iuwt
    enhancement = 'iuwt';  col = 15; ename ='iuwt'; ne = 2; n = ne + ns + thflag;
    [ModHD,ModHDParam] = genaticCombo(I,target,img,skeleton,enhancement,row,col,n,p,t,sname,ename,ModHD,ModHDParam,resMetricFile,resParamsFile,flag,thflag ,''); 
%%       (16) neuriteneesFilter
    enhancement = 'neuriteneesFilter'; col = 16; ename ='neurit'; ne = 1; n = ne + ns + thflag;
    [ModHD,ModHDParam] = genaticCombo(I,target,img,skeleton,enhancement,row,col,n,p,t,sname,ename,ModHD,ModHDParam,resMetricFile,resParamsFile,flag,thflag ,''); 
%%       (17) anIsotropicGaussianKernelEnhancement
    enhancement = 'anIsotropicGaussianKernelEnhancement';  col = 17; ename ='IGK';ne = 13; n = ne + ns + thflag;
    [ModHD,ModHDParam] = genaticCombo(I,target,img,skeleton,enhancement,row,col,n,p,t,sname,ename,ModHD,ModHDParam,resMetricFile,resParamsFile,flag,thflag ,''); 
%%       (18) SCIRD
    enhancement = 'SCIRD'; col = 18; ename ='SCIRD'; ne = 12; n = ne + ns + thflag;
    [ModHD,ModHDParam] = genaticCombo(I,target,img,skeleton,enhancement,row,col,n,p,t,sname,ename,ModHD,ModHDParam,resMetricFile,resParamsFile,flag,thflag ,'');  
%%       (19) volumeRatio
    enhancement = 'volumeRatio'; col = 19; ename ='VR'; ne = 6; n = ne + ns + thflag;
    [ModHD,ModHDParam] = genaticCombo(I,target,img,skeleton,enhancement,row,col,n,p,t,sname,ename,ModHD,ModHDParam,resMetricFile,resParamsFile,flag,thflag ,''); 
%%       (20) path opening
    enhancement = 'pathOpening'; col = 20; ename ='PO'; ne = 4; n = ne + ns + thflag;
    [ModHD,ModHDParam] = genaticCombo(I,target,img,skeleton,enhancement,row,col,n,p,t,sname,ename,ModHD,ModHDParam,resMetricFile,resParamsFile,flag,thflag ,'');      

%       <8> IMAskel
%    -------------------------------------------------------------------------
    skeleton  = 'afmmskel'; row = 8 ;  ns = 1; sname = 'afmm'; thflag = 1;
    %%      (1) globalThresh
    enhancement = 'globalThresh'; col = 1; ename ='GT'; ne = 1; n = ne + ns + thflag;
    [ModHD,ModHDParam] = genaticCombo(I,target,img,skeleton,enhancement,row,col,n,p,t,sname,ename,ModHD,ModHDParam,resMetricFile,resParamsFile,flag,thflag ,'.pgm'); 
 %%      (2) otsuThresh
    enhancement = 'otsuThresh'; col = 2; ename ='OT'; ne = 1; n = ne + ns + thflag;
    [ModHD,ModHDParam] = genaticCombo(I,target,img,skeleton,enhancement,row,col,n,p,t,sname,ename,ModHD,ModHDParam,resMetricFile,resParamsFile,flag,thflag ,'.pgm'); 
 %%      (3) gaussianSteerableFilters
    enhancement = 'gaussianSteerableFilters'; col = 3; ename ='GS'; ne = 3; n = ne + ns + thflag;
    [ModHD,ModHDParam] = genaticCombo(I,target,img,skeleton,enhancement,row,col,n,p,t,sname,ename,ModHD,ModHDParam,resMetricFile,resParamsFile,flag,thflag ,'.pgm'); 
 %%      (4) CLAHE
    enhancement = 'CLAHE'; col = 4; ename ='CLAHE'; ne = 1; n = ne + ns + thflag;
    [ModHD,ModHDParam] = genaticCombo(I,target,img,skeleton,enhancement,row,col,n,p,t,sname,ename,ModHD,ModHDParam,resMetricFile,resParamsFile,flag,thflag ,'.pgm'); 
 %%      (5) vesselness
    enhancement = 'vesselness';col = 5; ename ='V'; ne = 7; n = ne + ns + thflag;
    [ModHD,ModHDParam] = genaticCombo(I,target,img,skeleton,enhancement,row,col,n,p,t,sname,ename,ModHD,ModHDParam,resMetricFile,resParamsFile,flag,thflag ,'.pgm'); 
 %%      (6) localTensorVesselness
    enhancement = 'localTensorVesselness'; col = 6; ename ='LTV'; ne = 8; n = ne + ns + thflag;
    [ModHD,ModHDParam] = genaticCombo(I,target,img,skeleton,enhancement,row,col,n,p,t,sname,ename,ModHD,ModHDParam,resMetricFile,resParamsFile,flag,thflag ,'.pgm'); 
 %%      (7) phaseVesselnessFilter
    enhancement = 'phaseVesselnessFilter'; col = 7; ename ='PCTV'; ne = 8; n = ne + ns + thflag;
    [ModHD,ModHDParam] = genaticCombo(I,target,img,skeleton,enhancement,row,col,n,p,t,sname,ename,ModHD,ModHDParam,resMetricFile,resParamsFile,flag,thflag ,'.pgm'); 
 %%      (8) localHistEq
    enhancement = 'localHistEq';col = 8; ename ='LHE'; ne = 2; n = ne + ns + thflag;
    [ModHD,ModHDParam] = genaticCombo(I,target,img,skeleton,enhancement,row,col,n,p,t,sname,ename,ModHD,ModHDParam,resMetricFile,resParamsFile,flag,thflag ,'.pgm'); 
%%       (9) topHat 
    enhancement = 'topHat'; col = 9; ename ='TH'; ne = 2; n = ne + ns + thflag;
    [ModHD,ModHDParam] = genaticCombo(I,target,img,skeleton,enhancement,row,col,n,p,t,sname,ename,ModHD,ModHDParam,resMetricFile,resParamsFile,flag,thflag ,'.pgm'); 
%%       (10) adaptiveThresh 
    enhancement = 'adaptiveThresh'; col = 10; ename ='AT'; ne = 1; n = ne + ns + thflag;
    [ModHD,ModHDParam] = genaticCombo(I,target,img,skeleton,enhancement,row,col,n,p,t,sname,ename,ModHD,ModHDParam,resMetricFile,resParamsFile,flag,thflag ,'.pgm'); 
%%       (11) phaseNeuritenessFilter
    enhancement = 'phaseNeuritenessFilter'; col = 11; ename ='PCTneurit'; ne = 9; n = ne + ns + thflag;
    [ModHD,ModHDParam] = genaticCombo(I,target,img,skeleton,enhancement,row,col,n,p,t,sname,ename,ModHD,ModHDParam,resMetricFile,resParamsFile,flag,thflag ,'.pgm'); 
%%       (12) fcnBPDFHE
    enhancement = 'fcnBPDFHE'; col = 12; ename ='fcnBPDFHE'; ne = 10; n = ne + ns + thflag;
    [ModHD,ModHDParam] = genaticCombo(I,target,img,skeleton,enhancement,row,col,n,p,t,sname,ename,ModHD,ModHDParam,resMetricFile,resParamsFile,flag,thflag ,'.pgm'); 
%%       (13) hysteresisThresh
    enhancement = 'hysteresisThresh'; col = 13; ename ='HT'; ne = 3; n = ne + ns + thflag;
    [ModHD,ModHDParam] = genaticCombo(I,target,img,skeleton,enhancement,row,col,n,p,t,sname,ename,ModHD,ModHDParam,resMetricFile,resParamsFile,flag,thflag ,'.pgm'); 
%%       (14) phaseCongurency
    enhancement = 'phaseCongurency'; col = 14; ename ='PCT'; ne = 9; n = ne + ns + thflag;
    [ModHD,ModHDParam] = genaticCombo(I,target,img,skeleton,enhancement,row,col,n,p,t,sname,ename,ModHD,ModHDParam,resMetricFile,resParamsFile,flag,thflag ,'.pgm'); 
%%       (15) iuwt
    enhancement = 'iuwt';  col = 15; ename ='iuwt'; ne = 2; n = ne + ns + thflag;
    [ModHD,ModHDParam] = genaticCombo(I,target,img,skeleton,enhancement,row,col,n,p,t,sname,ename,ModHD,ModHDParam,resMetricFile,resParamsFile,flag,thflag ,'.pgm'); 
%%       (16) neuriteneesFilter
    enhancement = 'neuriteneesFilter'; col = 16; ename ='neurit'; ne = 1; n = ne + ns + thflag;
    [ModHD,ModHDParam] = genaticCombo(I,target,img,skeleton,enhancement,row,col,n,p,t,sname,ename,ModHD,ModHDParam,resMetricFile,resParamsFile,flag,thflag ,'.pgm'); 
%%       (17) anIsotropicGaussianKernelEnhancement
    enhancement = 'anIsotropicGaussianKernelEnhancement';  col = 17; ename ='IGK';ne = 13; n = ne + ns + thflag;
    [ModHD,ModHDParam] = genaticCombo(I,target,img,skeleton,enhancement,row,col,n,p,t,sname,ename,ModHD,ModHDParam,resMetricFile,resParamsFile,flag,thflag ,'.pgm'); 
%%       (18) SCIRD
    enhancement = 'SCIRD'; col = 18; ename ='SCIRD'; ne = 12; n = ne + ns + thflag;
    [ModHD,ModHDParam] = genaticCombo(I,target,img,skeleton,enhancement,row,col,n,p,t,sname,ename,ModHD,ModHDParam,resMetricFile,resParamsFile,flag,thflag ,'.pgm');  
%%      (19) volumeRatio
    enhancement = 'volumeRatio'; col = 19; ename ='VR'; ne = 6; n = ne + ns + thflag;
    [ModHD,ModHDParam] = genaticCombo(I,target,img,skeleton,enhancement,row,col,n,p,t,sname,ename,ModHD,ModHDParam,resMetricFile,resParamsFile,flag,thflag ,'.pgm'); 
%%       (20) path opening
    enhancement = 'pathOpening'; col = 20; ename ='PO'; ne = 4; n = ne + ns + thflag;
    [ModHD,ModHDParam] = genaticCombo(I,target,img,skeleton,enhancement,row,col,n,p,t,sname,ename,ModHD,ModHDParam,resMetricFile,resParamsFile,flag,thflag ,'');      
end