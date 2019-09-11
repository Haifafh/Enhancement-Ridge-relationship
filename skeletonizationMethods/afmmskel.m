
function out = afmmskel(I,params)
%% Discription:
 %% An augmented fast marching method for computing skeletons and centerlines.
 %% Reference:
 % Ebert, D., P. Brunet, and I. Navazo. 
 % "An augmented fast marching method for computing skeletons and centerlines." 
 % Proceedings of VisSym, Barcelona, Spain (2002).
%% Save image as pgm file
% it says in Readme file: the object should be black and the bacground
% should be white.
% switch params(1) 
%     case 1
%         p1 = ' +';
%     case 0
%         p1 = ' -';
% end
% switch params(2) 
%     case -2
%         p2 = 'p';
%     case -1
%         p2 = 't ';
%         p3 =num2str(params(3));
%         p2 = [p2 p3];
%     case 0
%         p2 = 's ';
%         p3 =num2str(round(max(1,params(3)*10)));
%         p2 = [p2 p3];
%     case 1
%         p2 = 'm ';
%         p3 = num2str(round(params(3)*2));
%         p2 = [p2 p3];
%     case 2
%         p2 = 'o ';
%     case 3
%         p2 = 'v';
% end
I= imcomplement(I);
projectDir = '/mnt/storage/home/haifa/curvilinear-methods/code';
filename = tempname;
ext = '.pgm';
imwrite(I,strcat(projectDir,filename,ext),'pgm');
%% recall the pgm file
%% Delete
if exist([projectDir filename '_sk' ext],'file')==2
  delete([projectDir filename '_sk' ext]);
end
%% Call
filename2 = strcat('.',filename,ext);
% options = [ p1 p2];
% s = system(['./lib/afmmstarvdt/skeleton ' filename2 options])
s = system(['./lib/afmmstarvdt/skeleton ' filename2 ])
if s~= 0
    out = zeros(size(I));
    delete(strcat(projectDir,filename,ext));
    return
end
%% Load
[m,n] = size(I);
out = dlmread([projectDir filename '_sk' ext],'',10);
out = reshape(out,m,n)';
delete(strcat(projectDir,filename,ext));
delete(strcat(projectDir,filename,'_sk',ext));
% We should also delete the skeleton file
end