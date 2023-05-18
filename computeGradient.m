% Gradient Computation
function [gx,gy]= computeGradient(wrappedImage)
filteR = -[-1 0 1];
gx=conv2(wrappedImage,filteR);
gx=gx(:,2:end-1);
gy=conv2(wrappedImage,filteR');
gy=gy(2:end-1,:);
end