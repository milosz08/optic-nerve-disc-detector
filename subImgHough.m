function subImgHough(r,c,i,img,x,y,t)
    subplot(r,c,i);
    imshow(img);
    title(t);
    hold on;
    plot(x,y,'g','LineWidth',1);
    hold off;
end