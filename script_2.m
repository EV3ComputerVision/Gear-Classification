clear all, clc, close all
gpuDevice(1);

%Inicialización y ajuste de cámara
camara=videoinput('winvideo',2,'MJPG_1280x720');
triggerconfig(camara, 'manual');
start(camara)
pause(2);

%Configuraciones del robot
robot = legoev3('USB');
faja = motor(robot,'A');
desviador = motor(robot,'D');
faja.Speed = 20;
lampara=motor(robot,'B');
start(lampara,100)
stop(lampara,1)

%Ajuste de cuadro
dimF=196; margen=-11; %la variable margen sirve para encuadrar el fotograma. 
cX=(1280-dimF)/2;
cY=(720-dimF)/2;
iGpu=gpuArray(getsnapshot(camara));

%
%imshow(recortar(iGpu,cX,cY+margen,cX+dimF-1,cY+margen+dimF-1));
%base=edge(crt(recortar(iGpu,cX,cY+margen,cX+dimF-1,cY+margen+dimF-1)),"Sobel");
%imshow(base);
%imwrite(base,t+".bmp",'bmp');
%

%Elemento estructural
se=gpuArray(ones(7));

%Variables
activar1=logical(1);
activar2=logical(0);
activar3=logical([0 0 0 0]);
angulo=int32(30);
expulsar=int32([0 0 0 0]);
n=1;
c=1;
m=1;
resetRotation(faja);
resetRotation(desviador);
fajaAbs=readRotation(faja);
start(faja);



for t=1:300
    clase="en espera";
    figure(1)
    while readRotation(faja)<angulo
        if readRotation(faja)>=expulsar(m) && activar3(m)
            activarDesviador(desviador,n);
            n=n+1;
            activar3(m)=logical(0);
            if m<4
                m=m+1;
            else
                m=1;
            end
        end
    end
    angulo=angulo+int32(30);
    iGpu=gpuArray(getsnapshot(camara));
    cuadro=recortar(iGpu,cX,cY+margen,cX+dimF-1,cY+margen+dimF-1); 
    cuadroGris=arrayfun(@CrtGpu,cuadro(:,:,1),cuadro(:,:,2),cuadro(:,:,3));
    I=imopen(arrayfun(@medioGpu,cuadroGris),se);
    subplot(1,3,1);
    imshow(cuadro);
    title('RGB')
    subplot(1,3,2);
    imshow(cuadroGris);
    title('Escala de grises')
    subplot(1,3,3);
    imshow(I);
    title('Apertura')
    if activar1
        if any(I(98,:))
            activar1=logical(0);
            activar2=logical(1);
        end
    end
    if activar2
        if ~any(I(:,1))
            A=any(I);
            medida=size(nonzeros((A)'),1);
            margen2=find(A,1,'first');
            if medida>=120
                img=edge(cuadroGris,"Sobel");
                subplot(1,3,3);
                imshow(img);
                title('Sobel')
                clase = classify(trainedNetwork_5, img);
                disp(['clase: ', char(clase)]);
                if char(clase)=="coronado"
                    activar3(c)=logical(1);
                    descentrado=round(((dimF/2)-(round(medida/2)+margen2))*40/66);
                    expulsar(c)=readRotation(faja)+220+descentrado;
                    if c<4
                        c=c+1;
                    else
                        c=1;
                    end
                end  
            end
            angulo=angulo+int32(round((dimF-margen2)*40/66));
            activar2=logical(0);
            activar1=logical(1);
        end
    end
    sgtitle("Engranaje "+char(clase))
end
stop(faja);
stop(desviador,0);
stop(camara);
delete(camara);