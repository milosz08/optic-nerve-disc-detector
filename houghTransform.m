function [circCent,circRad]=houghTransform(img,rMin,rMax,rNr,pNr,thr)
    N=rNr*pNr; % liczba możliwych okręgów
    circCent=zeros(N,2); % środki okręgów
    circRad=zeros(N,1); % promienie okręgów
    
    rN=0; % ilość znalezionych okręgów
    for radius=rMin:(rMax-rMin)/4:rMax
        acc=calcDimAcc();

        hoodSize=floor(size(acc)/100.0)*2+1; % rozmiar sąsiedztwa
        peaks=zeros(pNr,2); % współrzędne szczytów

        currPkNr=0;
        % dopóki nie znajdzie przewidywanej liczby szczytów
        while currPkNr<pNr
            maxAcc=max(acc(:)); % maksimum akumulatora
            % przerwij, jeśli nie zostanie przekroczony próg
            if (maxAcc<thr*maxAcc)
                break;
            end
            currPkNr=currPkNr+1;

            % Znajdź największą wartość akumulatora
            [~,accIdx]=max(acc(:));
            [mR,mC]=ind2sub(size(acc), accIdx);
            % dodaj szczyt
            peaks(currPkNr,:)=[mR,mC];

            % usuwanie piksele w otoczeniu szczytu akumulatora
            for cR=calcStart(mR,1):calcEnd(mR,1)
                for cC=calcStart(mC,2):calcEnd(mC,2)
                    acc(cR,cC) = 0;
                end
            end
        end

        peaks=peaks(1:currPkNr,:);   
        
        % jeśli znaleziono szczyty, dodaj je oraz promienie do tablicy
        if (size(peaks,1)>0)
            rNAcc=rN+size(peaks,1);
            circCent(rN+1:rNAcc,:)=peaks;
            circRad(rN+1:rNAcc)=radius;
            rN=rNAcc;
        end
    end

    circCent=circCent(1:rN,:); % wyznaczone współrzędne
    circRad=circRad(1:rN); % wyznaczone promienie

    % wyznaczenie współrzędnych dla promienia
    function acc=calcDimAcc()
        acc=zeros(size(img)); % akumulator
        for i=1:size(img,2)
            for j=1:size(img,1)
                % jeśli jest to tło, pomiń
                if (~img(j,i))
                    continue;
                end
                for th=linspace(0,2*pi,360)
                    y=round(i+radius*cos(th));
                    x=round(j+radius*sin(th));
                    % dodaj do akumulatora tylko dla zakresu 0->max
                    if (y>0 && y<=size(acc,2) && x>0 && x<=size(acc,1))
                        acc(x,y)=acc(x,y)+1;
                    end
                end
            end
        end
    end

    % początkowy indeks pętli iterującej po sąsiedztwie piksela
    function d=calcStart(s,i)
        d=max(1,s-(hoodSize(i)-1)/2);
    end

    % końcowy indeks pętli iterującej po sąsiedztwie piksela
    function d=calcEnd(s,i)
        d=min(size(acc,i),s+(hoodSize(i)-1)/2);
    end
end

