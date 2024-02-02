function fbwcentro=fbcentro(Ig)

u=(uint8(min(Ig,[],"all"))+uint8(max(Ig,[],"all")))/2;

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

fbwcentro=Ig2;

end