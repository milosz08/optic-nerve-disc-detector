function showImgHist(img,r,c,i,t)
    subplot(r,c,i);
    imshow(img);
    title(t);
    subplot(r,c,i+1);
    imhist(img);
end