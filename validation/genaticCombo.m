function  [ModHD,ModHDParam] = genaticCombo(I,target,img,skeleton,enhancement,row,col,n,p,t,sname,ename,ModHD,ModHDParam,resMetricFile,resParamsFile,flag,thflag ,ext,imageDir)
    %% description:
    % gentic-driven enhancement-skeletonisation combination function 
    %%
    myMetric = str2func('ModHausdorffDist');
    %%  Objective Functions
    function fval = objectiveFunc(val)
                fval = myMetric(myFun(val),target);
    end
    %imageDir = '/mnt/storage/home/haifa/curvilinear-methods/code/results/images/visualisation/';
    mn1 = findvarname(ModHD); mn2 = findvarname(ModHDParam);
    myFun = @(x)methodsCombinations(I,skeleton,enhancement,x,thflag);
    %% setting of genatic function
    options = gaoptimset('PopulationSize',p,'InitialPopulation', rand(p,n),'TimeLimit',t,'UseParallel', true, 'Vectorized', 'off');
    [x,fval] = ga(@objectiveFunc,n,[],[],[],[], (zeros(1,n)), (ones(1,n)), [], options);
    %% Save the result
    ModHD(row,col,img) = fval;
    save(resMetricFile,mn1,'-append');
    %% re-Normalize paramerters
   [params,~,~]= newnormliseParams(x,skeleton,enhancement,thflag);
    ModHDParam{row,col,img} = params;
    save(resParamsFile,mn2,'-append'); 
    %% Save the resulted image if flag =1
    if flag ==1
    out = methodsCombinations(I,skeleton,enhancement,x,thflag);
    imagename = fullfile(imageDir,strcat(sname,'+',ename,'=',num2str(fval),'.png'));
    imwrite(out,imagename);
    end
    
    %% clean up (can be used if the algorithm has three-party).
    temp_dir = '/mnt/storage/home/haifa/curvilinear-methods/code/tmp/'; 
   if ~isempty( dir(temp_dir))
       delete(strcat(temp_dir,'*',ext));
   end
end
