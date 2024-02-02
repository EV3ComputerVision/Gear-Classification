function figcrt=crt(I)

Ig=uint8(ones(size(I)));

Ig=0.2125*I(:,:,1)+0.7154*I(:,:,2)+0.0721*I(:,:,3);
figcrt=Ig;

end