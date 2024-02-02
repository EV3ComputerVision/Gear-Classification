function figluminosidad=luminosidad(I)

Ib=I;
Ig=uint8(ones(size(Ib)));

Ig=0.2989*Ib(:,:,1)+0.5870*Ib(:,:,2)+0.1140*Ib(:,:,3);
figluminosidad=Ig;

end