%% Bilinear Interpolation
function wrappedImage= bilinearInterpolation(searchImage,wrapLocX,wrapLocY)
[r, c]=size(wrapLocX);
wrapXint = floor(wrapLocX);% extracting Integer part
wrapYint = floor(wrapLocY);
wrapXdec = rem(wrapLocX,1);% extracting decimal part
wrapYdec = rem(wrapLocY,1);

wrappedImage = zeros(r,c);
for i = 1:r
    for j= 1:c
        x1 = wrapXint(i,j);
        y1 = wrapYint(i,j);
        decX = wrapXdec(i,j);
        decY = wrapYdec(i,j);
        IPX1 = (1-decX)*double(searchImage(y1, x1  )) + decX*double(searchImage(y1,   x1+1));
        IPX2 = (1-decX)*double(searchImage(y1+1, x1)) + decX*double(searchImage(y1+1, x1+1));
        wrappedImage(i,j) = (1-decY)*IPX1+decY*IPX2;  
    end
end
end