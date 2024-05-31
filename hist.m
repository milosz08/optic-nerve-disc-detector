clc;
clear;
close all;

cImg=imread('01_h.jpg');
r=3;
c=2;

rImg=cImg(:,:,1);
gImg=cImg(:,:,2);
bImg=cImg(:,:,3);

figure;
showImgHist(rImg,r,c,1,'red');
showImgHist(gImg,r,c,3,'green');
showImgHist(bImg,r,c,5,'blue');