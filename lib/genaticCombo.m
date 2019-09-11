function  [ModHD,ModHDParam] = genaticCombo(I,target,img,skeleton,enhancement,row,col,n,p,t,sname,ename,ModHD,ModHDParam,resMetricFile,resParamsFile,flag,thflag ,ext)

    myMetric = str2func('ModHausdorffDist');
    %%  Objective Functions
    function fval = objectiveFunc(val)
                fval = myMetric(myFun(val),target);
    end
    imageDir = '/mnt/storage/home/haifa/curvilinear-methods/code/results/images/visualisation/';
    mn1 = findvarname(ModHD); mn2 = findvarname(ModHDParam);
    myFun = @(x)methodsCombinations(I,skeleton,enhancement,x,thflag);
    options = gaoptimset('PopulationSize',p,'InitialPopulation', rand(p,n),'TimeLimit',t,'UseParallel', true, 'Vectorized', 'off');
    [x,fval] = ga(@objectiveFunc,n,[],[],[],[], (zeros(1,n)), (ones(1,n)), [], options);
    ModHD(row,col,img) = fval;
    save(resMetricFile,mn1,'-append');
   [params,~,~]= newnormliseParams(x,skeleton,enhancement,thflag);
    ModHDParam{row,col,img} = params;
    if flag ==1
    out = methodsCombinations(I,skeleton,enhancement,x,thflag);
    imagename = fullfile(imageDir,strcat(sname,'+',ename,'=',num2str(fval),'.png'));
    imwrite(out,imagename);
    end
    save(resParamsFile,mn2,'-append'); 
    %% clean up
    if ~strcmp(ext,'')
        delete(strcat('/mnt/storage/home/haifa/curvilinear-methods/code/tmp/*.',ext));
    end
end
