function resultado=fhiperbolicah(Ig)

[fila,columna]=size(Ig);
I=uint8(zeros(size(Ig)));
tabla=uint8(zeros(256,2));
tabla(1:256)=0:255;
rMin=double(min(Ig,[],"all")); rMax=double(max(Ig,[],"all"));
S=sumatoria(Ig);
tabla(1:256,2)=uint8(round((rMax)*S(1:256,2)));
for c=1:columna
    for f=1:fila
        I(f,c)=tabla(Ig(f,c)+1,2);
    end
end
resultado=I;