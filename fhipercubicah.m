function resultado=fhipercubicah(Ig)

[fila,columna]=size(Ig);
I=uint8(zeros(size(Ig)));
tabla=uint8(zeros(256,2));
tabla(1:256)=0:255;
rMin=double(min(Ig,[],"all")); rMax=double(max(Ig,[],"all"));
S=sumatoria(Ig);
tabla(1:256,2)=uint8(((nthroot(rMax,3)-nthroot(rMin,3))*S(1:256,2)+nthroot(rMin,3)).^3);
for c=1:columna
    for f=1:fila
        I(f,c)=tabla(Ig(f,c)+1,2);
    end
end
resultado=I;