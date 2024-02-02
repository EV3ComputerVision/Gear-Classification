function resultado=sumatoria(Ig)
nivel=double(zeros(256,4));
nivel(1:256,1)=0:255;
[fila,columna]=size(Ig);
totalPix=fila*columna;
for c=1:columna
    for f=1:fila
        nivel(Ig(f,c)+1,2)=nivel(Ig(f,c)+1,2)+1;
    end
end
nivel(1:256,3)=nivel(1:256,2)/totalPix;
nivel(1,4)=nivel(1,3);
for j=2:256
    nivel(j,4)=nivel(j-1,4)+nivel(j,3);
end
resultado=nivel(1:256,1:3:4);