clear all, clc, close all
gpuDevice;

%Inicialización y ajuste de cámara
camara = webcam('OsmoAction3');
camara.Resolution = '1280x720';

dimF=196; margen=-14;
cX=(1280-dimF)/2;
cY=(720-dimF)/2;
cuadro=recortar(snapshot(camara),cX,cY+margen,cX+dimF-1,cY+margen+dimF-1);
imshow(cuadro);
metodo=["media" "luminosidad" "crt" "crto" "g"];
ecualizacion=["EczNA" "EczUniforme" "EczHipercubica" "EczHiperbolica"];

se=gpuArray(ones(7));

Ig=uint8(zeros(dimF,dimF,5));
Ecz=uint8(zeros(dimF,dimF,20));
Ig(:,:,1)=media(cuadro);
Ig(:,:,2)=luminosidad(cuadro);
Ig(:,:,3)=crt(cuadro);
Ig(:,:,4)=crto(cuadro);
Ig(:,:,5)=g(cuadro);

for capa=1:5
    Ecz(:,:,1+4*(capa-1))=Ig(:,:,capa);
    Ecz(:,:,2+4*(capa-1))=funiformeh(Ig(:,:,capa));
    Ecz(:,:,3+4*(capa-1))=fhipercubicah(Ig(:,:,capa));
    Ecz(:,:,4+4*(capa-1))=fhiperbolicah(Ig(:,:,capa));
end

nMet=0;
for capa=1:20
    nEc=mod(capa,4);
    if nEc==0
        nEc=4;
    elseif nEc==1
        nMet=nMet+1;
    end
    imwrite(fbmedia(Ecz(:,:,capa)),"media-"+ecualizacion(nEc)+"-"+metodo(nMet)+".bmp",'bmp');
    imwrite(fbcentro(Ecz(:,:,capa)),"centro-"+ecualizacion(nEc)+"-"+metodo(nMet)+".bmp",'bmp');
    imwrite(fbequil(Ecz(:,:,capa)),"equilibrio-"+ecualizacion(nEc)+"-"+metodo(nMet)+".bmp",'bmp');
    imwrite(fbmedio(Ecz(:,:,capa)),"medio-"+ecualizacion(nEc)+"-"+metodo(nMet)+".bmp",'bmp');
    imwrite(fbmoda(Ecz(:,:,capa)),"moda-"+ecualizacion(nEc)+"-"+metodo(nMet)+".bmp",'bmp');
end
%
iGpu=gpuArray(snapshot(camara));
cuadro=recortar(iGpu,cX,cY+margen,cX+dimF-1,cY+margen+dimF-1);
I=imopen(arrayfun(@medioCrtGpu,cuadro(:,:,1),cuadro(:,:,2),cuadro(:,:,3)),se);
imshow(I);