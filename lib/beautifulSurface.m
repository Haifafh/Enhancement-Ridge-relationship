function beautifulSurface()
%%Old
% P is a vector e.g. [3,1,9]
% D is a 2D image of the distances, the axes Y is the height e.g.
% hausdorffDistance
%   the axis X and Z may be e.g. the parameters

% consider creating a custom colormap, e.g. with linspace on 3 hard coded
% colors
%% Create new matrics
% hausdorff = zeros(6,18,1);
% imAbsDiff = zeros(6,18,1);
% jaccardI = zeros(6,18,1);
%% Load mat files
outputDir = 'C:\Users\haifa\Documents\curvilinear-methods\';
hausdorff = load(fullfile(outputDir, 'HD.mat'));
imAbsDiff = load(fullfile(outputDir, 'AbsDif.mat'));
%% Means and Std of metrics ( In case of 20 Images)
% hausdorffMeans = mean(hausdorff.resMetrics,3);
% %hausdorffStds  = std(hausdorff.resMetrics,0,3);
% imAbsDiffMeans = mean(imAbsDiff.resMetrics,3);
%imAbsDiffStds  = std(imAbsDiff.resMetrics,0,3);
%% Delete zeros in Steger's not not-applicable algorithms
hausdorff.resMetrics(5,1:2)=NaN;
hausdorff.resMetrics(5,5:6)=NaN;
jaccardI.resMetrics(5,1:2)=NaN;
jaccardI.resMetrics(5,5:6)=NaN;
%% Color map
%a = makeColorMap([105,126,184]/255,[255,229,204]/255,[255,51,51]/255);
a = makeColorMap([55,126,184]/255,[255,204,153]/255,[152,78,163]/255);
%a = makeColorMap([100,206,164]/255,[255,222,199]/255,[255,59,51]/255);
%% Figures
figure(1);
s11 = surf(hausdorff.resMetrics,'FaceAlpha',0.8);colormap(a);
s11.EdgeColor = 'none';
title('Hausdroff Distance');
ylabel('Skeletonization','FontSize',12,'FontWeight','bold','Color','r'); % y-axis label
xlabel('Enhancement','FontSize',12,'FontWeight','bold','Color','r'); % x-axis label
set(gca,'XTick',(1:1:18),'ZScale', 'log','YTick',(1:1:6));
xticklabels({'AT','Otsu','TH','CLAHE','GT','HT','LHE','V','N','PN','PC','VR','BH','PV','LTV','GSF','fcnBPDFHE','IGK'});
yticklabels({'ZS','TS','SG','MS','Steger','Voroni'})
xtickangle(45);
ytickangle(45);
box on
%%
figure(2);
s31 = surf(imAbsDiff.resMetrics,'FaceAlpha',0.8);colormap(a);
s31.EdgeColor = 'none';
title('Absloute Difference');
ylabel('Skeletonization','FontSize',12,'FontWeight','bold','Color','r'); % y-axis label
xlabel('Enhancement','FontSize',12,'FontWeight','bold','Color','r'); % x-axis label
set(gca,'XTick',(1:1:18),'ZScale', 'log','YTick',(1:1:6));
xticklabels({'AT','Otsu','TH','CLAHE','GT','HT','LHE','V','N','PN','PC','VR','BH','PV','LTV','GSF','fcnBPDFHE','IGK'});
yticklabels({'ZS','TS','SG','MS','Steger','Voroni'})
xtickangle(45);
ytickangle(45);
box on
%% Plots
% figure(1);plot3(s11);
% figure(2);plot3(s21);
% figure(3);plot3(s31);


end