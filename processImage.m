function [cImg,gImg,gfImg,sgImg,dlImg]=processImage(imgName)
    cImg=imread(imgName);
    gImg=cImg(:,:,2); % składowa zielona
    
    % filtr uśredniający
    mS=5; % rozmiar
    fm=ones(mS)/(mS^2); % maska
    gfImg = imfilter(gImg,fm);

    % progowanie
    prNr=20; % liczba progów
    levels=multithresh(gImg,prNr);
    sgImg=imquantize(gfImg,levels);
    % zaaplikowanie maski i binaryzacja
    mask=sgImg<(prNr-5);
    sgImg=imbinarize(sgImg.*~mask);
    
    % detekcja krawędzi
    sgImg=imdilate(sgImg,strel('disk',30)); % pogrubienie krawędzi
    edImg=edge(sgImg,'Canny'); % detekcja krawędzi
    dlImg=imdilate(edImg,strel('disk',5)); % pogrubienie krawędzi
end