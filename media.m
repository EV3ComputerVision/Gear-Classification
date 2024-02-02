function figmedia=media(I)

Ib=I;
Ig=double(ones(size(Ib)));

Ig=(double(Ib(:,:,1))+double(Ib(:,:,2))+double(Ib(:,:,3)))/3;
Ig2=uint8(Ig);
figmedia=Ig2;

end