%% Clear ALL
clc; clear all; close all;
%% Java paths
javaaddpath('/home/phil/STEGER/BOMatlabImageJ/jar/ij.jar');
javaaddpath('/home/phil/STEGER/BOMatlabImageJ/jar/bomij.jar');
%% RUN
BOMatlabImageJ.start(false);
%% Help
BOMatlabImageJ.help;
%% Image
ims = zeros(100,100,100);
ims(30:70,30:70,20:80) = 255;
ims = im2uint8(ims);
%% Create an ImagePlus from the image
IP = BOMatlabImageJ.createImage('image',ims);
%% Create an image from the ImagePlus
ims2 = BOMatlabImageJ.getImage(IP);
%% CAST class
ims2 = cast(ims2,class(ims));
%% Save ImagePlus
BOMatlabImageJ.saveImage(IP,'IP.tif');
%% Open image file
IP2 = BOMatlabImageJ.openImage([pwd '/' 'IP.tif']);