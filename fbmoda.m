function fbwmoda=fbmoda(Ig)

u=uint8(mode(Ig, "all"));

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

fbwmoda=Ig2;

end