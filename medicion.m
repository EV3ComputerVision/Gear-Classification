clear all, clc, close all
gpuDevice;

%Inicialización y ajuste de cámara
camara=videoinput('winvideo', 1, 'MJPG_1280x720');
triggerconfig(camara, 'manual');
start(camara)
pause(2);
%Ajuste de cuadro
dimF=196; margen=-14;
cX=(1280-dimF)/2;
cY=(720-dimF)/2;
%Elemento estructural
se=gpuArray(ones(7));

I=recortar(getsnapshot(camara),cX,cY+margen,cX+dimF-1,cY+margen+dimF-1);
imshow(I)
Igpu=gpuArray(I);
H=medioCrtGpu(I(:,:,1),I(:,:,2),I(:,:,3));

%%
Imp=timeit(@() fab(H,se));
Nat=timeit(@() imopen(H,se));

bar(categorical(["Implementada" "Nativa"]), ...
    [Imp Nat], ...
    "grouped")
ylabel("Tiempo de ejecución (s)")
legend("Implementada","Nativa")

%%
iGpu=gpuArray(getsnapshot(camara));
cuadro=recortar(iGpu,cX,cY+margen,cX+dimF-1,cY+margen+dimF-1);
I=imopen(arrayfun(@medioCrtGpu,cuadro(:,:,1),cuadro(:,:,2),cuadro(:,:,3)),se);



figure
subplot(2,2,1);
histograma(I);
title('Histograma engranaje coronado')
subplot(2,2,3);
imshow(I);


disp('uu')
pause (10)

iGpu=gpuArray(getsnapshot(camara));
cuadro=recortar(iGpu,cX,cY+margen,cX+dimF-1,cY+margen+dimF-1);
I=imopen(arrayfun(@medioCrtGpu,cuadro(:,:,1),cuadro(:,:,2),cuadro(:,:,3)),se);
subplot(2,2,2);

histograma(I);
title('Histograma engranaje recto')
subplot(2,2,4);

imshow(I);
