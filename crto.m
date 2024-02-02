function figcrto=crto(I)

Ib=I;
Ig=uint8(ones(size(Ib)));

Ig=0.76*Ib(:,:,1)+0.151*Ib(:,:,2)+0.28*Ib(:,:,3);

figcrto=Ig;

end