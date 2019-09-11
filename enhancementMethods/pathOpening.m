function out = pathOpening(I, params)
%% Desicription:
%  Ranking the Orientation Responses of Path Operators
%% Reference:
%  [1] Merveille, Odyssée, et al. "2D Filtering of Curvilinear Structures by Ranking the Orientation
%      Responses of Path Operators (RORPO)." Image Processing On Line 7 (2017): 246-261.‏
%% Code
name1= '/home/haifa/curvilinear-methods/code/lib/RORPO2D/RORPO2D-src/';
name2 = tempname;
[temp1, rand_string] = fileparts(name2);
name3 ='lib/RORPO2D/RORPO2D-src/';
filename =strcat('images/',rand_string,'.png');
namer = tempname;
[tempr, rand_stringr] = fileparts(namer);

filename2 =strcat('results/',rand_string,rand_stringr,'.png');
imwrite(I,strcat('lib/RORPO2D/RORPO2D-src/',filename));
xx1= [' ',num2str(params(1)),' ',num2str(params(2)),' ',num2str(params(3)),' ',num2str(params(4)),' '];
commd= ['./RORPO2D ' filename xx1 filename2];
oldpath1 = cd (name1);
    try
    status = system(commd);
     out= imread(filename2);
     delete(strcat(name1,filename));
     delete(strcat(name1,'results/',rand_string,rand_stringr,'*','.png'));
    catch
    out = zeros(size(I));
    delete(strcat(name1,filename));
    end


cd(oldpath1);
end