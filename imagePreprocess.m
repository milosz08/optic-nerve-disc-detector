clc;
clear;
close all;

r=2;
c=2;

[~,gImg,gfImg,sgImg,dlImg]=processImage('01_h.jpg');

figure;
subImg(r,c,1,gImg,'oryginał');
subImg(r,c,2,gfImg,'filtr uśredniający');
subImg(r,c,3,sgImg,'maska');
subImg(r,c,4,dlImg,'detekcja krawędzi');