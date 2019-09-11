close all, clc, clear
load('/Users/haifa/curvilinear-methods/code/results/matFiles/ModHDAll/lastVersionExp1/3Dform/MHD.mat')
load('/Users/haifa/curvilinear-methods/code/results/matFiles/ModHDAll/lastVersionExp1/3Dform/MHD.mat')
%% calcuates 


[tbl, mu_ij, sigma_ij, sigma,interactions] = anovatwo2(MHD);


save('/Users/haifa/curvilinear-methods/code/results/matFiles/dataGUFI.mat','data');