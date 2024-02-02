function fhist=histograma(Ig)

a=Ig;
b=sort(reshape(a,1,[]),'ascend');
contador=0;
fila=1;
c(fila,1)=double(b(1,1));
for col = 1:size(b,2)
    if b(1,col) == c(fila,1)
        contador=contador+1;
        c(fila,2)=contador;
    else
        contador=1;
        fila=fila+1;
        c(fila,1)=b(1,col);
        c(fila,2)=contador;
    end
end

fhist=c;
stem(c(:,1),c(:,2))
end