clc; clear all;close all; 
localDir ='/Users/haifa/';
addpath(genpath(strcat(localDir,'curvilinear-methods/code/')));
load('results/matFiles/ModHDAll/lastVersionExp1/3Dform/MHDGUFI.mat');
data = ModHD;
[I,J,K] = size(data);
%% 1-Way Anova - Matlab's
% J
pj = zeros(J,1);
msj = zeros(J,1);
for j=1:J
    [p, tbl,~] = anova1(squeeze(data(:,j,:))');
    pj(j) = p;
    msj(j) = tbl{3,4};
    close all;
end
% I
pi = zeros(I,1);
msi = zeros(I,1);
for i=1:I
    [p, tbl,~] = anova1(squeeze(data(i,:,:))');
    pi(i) = p;
    msi(i) = tbl{3,4};
    close all;
end
%% Interactions of I and J
[tbl, mu_ij, mu, sigma_ij, sigma,interactions] = anovatwo2(data);
%% interaction p-vaule and total MSE
load('results/matFiles/ModHDAll/lastVersionExp1/2Dform/GUFI2d.mat');
[p,tbl2,stats] = anova2(Gufi2d,10);
MSE = tbl2{5,4};
overall_p = p(3);
%% 

tbl_allone= [interactions,pi,msi;[pj.',overall_p,0];[msj.',0,MSE]];
