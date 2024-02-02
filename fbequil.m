function fbwequil=fbequil(Ig)

a=Ig;
b=sort(reshape(a,1,[]),'ascend');
contador=0;
fila=1;
c(fila,1)=b(1,1);
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
for f = 1:size(c,1)
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
md=median(a,"all");
suma=0;
indice=0;
for m = 1:size(c,1)
   if c(m,1)==md
       indice=m;
       for s=m:size(c,1)
           suma=suma+c(m,2);
       end
   end
end
suma2=0;
for m = 1:indice-1
   suma2=suma2+c(m,2);
end
u=0;
if suma > suma2
    u=(c(indice)+c(indice-1))/2;
elseif suma2==suma
    u=c(indice);
elseif suma<suma2
    u=(c(indice)+c(indice+1))/2;
end



[filas,columnas] = size(Ig);
for c = 1:columnas
    for f = 1:filas
        if Ig(f,c) >= u
            Ig(f,c) = 1;
        else
            Ig(f,c) = 0;
        end
    end
end

Ig2=logical(Ig);

fbwequil=Ig2;

end