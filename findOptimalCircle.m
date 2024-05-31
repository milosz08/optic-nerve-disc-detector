function [x,y]=findOptimalCircle(c,r,img)
    circNum=length(r);
    coverage=zeros(circNum, 1);

    % znalezienie współrzędnych które mają okrąg
    [rI,cI]=find(img==1);

    % przejście przez wszystkie okręgi
    for i=1:circNum
        [xF,yF]=circlePoints(i);    
        commonX=length(intersect(xF,rI));
        commonY=length(intersect(yF,cI));
        coverage(i)=commonX+commonY;
    end

    bC=[];
    bR=[];

    % pobranie okręgu o największym pokryciu
    if (size(coverage)>0)
        maxIdx=find(coverage==max(coverage));
        bC=c(maxIdx(1),:);
        bR=r(maxIdx(1));
    end

    % przekształcenie na współrzędne x,y
    thF=linspace(0,2*pi,360);
    x=bC(2)+bR*cos(thF);
    y=bC(1)+bR*sin(thF);

    % wyznaczenie współrzędnych x i y na podstawie indeksu
    function [x,y]=circlePoints(i)
        th=linspace(0,2*pi,100);
        x=round(c(i,1)+r(i)*cos(th));
        y=round(c(i,2)+r(i)*sin(th));
    end
end