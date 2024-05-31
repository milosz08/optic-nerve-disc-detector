clc;
clear;
close all;

images={
    'images/01_h.jpg'
    'images/02_h.jpg'
    'images/07_h.jpg'
    'images/10_h.jpg'
    'images/12_h.jpg'
    'images/13_h.jpg'
    'images/14_h.jpg'
    'images/15_h.jpg'
};

c=4;
r=length(images)/c;

figure;
for i=1:length(images)
    name=images{i};
    % przetworzenie obrazu
    [cImg,~,~,~,dlImg]=processImage(name);
    % transformata Hougha
    [circCent,circRad]=houghTransform(dlImg,30,65,20,20,0.8);
    % znajdowanie optymalnego okręgu
    [x,y]=findOptimalCircle(circCent,circRad,dlImg);
    subImgHough(r,c,i,cImg,x,y,name);
end