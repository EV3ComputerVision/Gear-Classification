function resultado=feb(Ib,se,s)

if s==1
    Ib=not(Ib);
end
[fila,columna]=size(Ib);
[filaSe,columnaSe]=size(se);
padding=(filaSe-1)/2;
Ip=logical(zeros(fila+2*padding,columna+2*padding));
Ip(padding+1:fila+padding,padding+1:columna+padding)=Ib(1:fila,1:columna);
Io=logical(zeros(size(Ib)));


for c=padding+1:columna+padding
    for f=padding+1:fila+padding
        Io(f-padding,c-padding)=any(and(recortar(Ip,c-padding,f-padding,c+padding,f+padding),logical(se)),'all');
    end
end

if s==1
    resultado=not(Io);
else
    resultado=Io;
end