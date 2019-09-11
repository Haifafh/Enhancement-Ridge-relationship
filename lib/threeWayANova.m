clc; clear all;close all; 
localDir ='/Users/haifa/';
addpath(genpath(strcat(localDir,'curvilinear-methods/code/')));
load('results/matFiles/dataDRIVE.mat');
DRIVEST= zeros(9,20);
%% Calculate the total 3-Way ANOVA
[p,tbl,stats] = anovan(data(:,4),{data(:,1),data(:,2),data(:,3)});
results = multcompare(stats,'Dimension',[1 2 ]);

%% Calculate the end column

for j=1:8
    datask=zeros(1,4);
    a=find(data(:,1)==j);
    for m=1:size(a,1)
        datask(m,:)=data(a(m,1),:);
    end
 
[p,~,~] = anovan(datask(:,4),{datask(:,1),datask(:,2),datask(:,3)});
DRIVEST(j,20)=p(2);
end

%% Calculate the end column

for j=1:19
    datask=zeros(1,4);
    a=find(data(:,2)==j);
    for m=1:size(a,1)
        datask(m,:)=data(a(m,1),:);
    end
 
[p,~,~] = anovan(datask(:,4),{datask(:,1),datask(:,2),datask(:,3)});
DRIVEST(9,j)=p(1);
end

%% Calculate for each row and column

for n=1:8
for j=1:19
    datask=zeros(1,4);
    a=find(data(:,2)==j&data(:,1)==n);
    for m=1:size(a,1)
        datask(m,:)=data(a(m,1),:);
    end
[p,~,~] = anovan(datask(:,4),{datask(:,1),datask(:,2),datask(:,3)});
DRIVEST(n,j)=p(3);
end
end