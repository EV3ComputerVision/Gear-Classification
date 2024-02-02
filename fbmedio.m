function fbwmedio=fbmedio(Ig)
profundidad=8;
u=((2^profundidad))/2;
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

fbwmedio=Ig2;

end