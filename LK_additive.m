%% Lucas Kanadae Additive algorithm
close all;clear all

prevImage   = imread("0.png");
searchImage = imread("1.png");

imshow(prevImage);
templateCords = floor(getrect());% to select template patch
close all;
template = prevImage(templateCords(1,2):templateCords(1,2)+templateCords(1,4),templateCords(1,1):templateCords(1,1)+templateCords(1,3));


p1=0;p2=0;p3=0;p4=0;p5=5;p6=5; % parameter initial values

paramVect= [1+p1 p3   p5;
            p2  1+p4  p6];

xlist = templateCords(1,1):templateCords(1,1)+templateCords(1,3);% horizontal
ylist = templateCords(1,2):templateCords(1,2)+templateCords(1,4);% vertical

scP = [length(xlist)/2, length(ylist)/2];
scI = [0.5*(xlist(floor(scP(1))) + xlist(ceil(scP(1)))), 0.5*(ylist(floor(scP(2))) + ylist(ceil(scP(2))))];

params.scalingCenterPatch = scP';
params.scalingCenterImage = scI';


for k =1:500
    % Transforms the cordinates based on the parameter vector    
    [wrapLocX,wrapLocY] = Transloc(xlist,ylist,paramVect, params);
    
    
     % wrap/bilinear interpolate searchimage using the new cordinates --> [wrapLocX,wrapLocY]
     wrappedImage = bilinearInterpolation(searchImage,wrapLocX,wrapLocY); % I in the paper
     
     % Gradient Computation
     [gx,gy] =computeGradient(wrappedImage);
     
     %Error Image
     error = double(template) - double(wrappedImage); 
     
     figure(1);subplot(321);imshow(template);xlabel('Reference Image');
     subplot(322);imshow(uint8(wrappedImage));xlabel('warped Image');
     subplot(323);imshow(uint8(gx));xlabel('warped Image grad x');
     subplot(324);imshow(uint8(gy));xlabel('warped Image grad y');
     subplot(325);imshow(uint8(max(error,0)));xlabel('Error Image +');
     subplot(326);imshow(uint8(max(-error,0)));xlabel('Error Image -');
     
     
     %Steepeset Decent Images -->  delta(I)* partial derivative of warps
     [SD,HessianM] = steepDescentCompute(gx,gy, params); 
     
     
     
     % steepest descent imnmages * Error
     steepetDescentImagesXerror = [sum(sum(SD.s1.*error)),sum(sum(SD.s2.*error)),sum(sum(SD.s3.*error))...
                              sum(sum(SD.s4.*error)),sum(sum(SD.s5.*error)),sum(sum(SD.s6.*error))];
     
     
     
     HInv = pinv(HessianM);
     sprintf('Iteration %i', k )
     deltaP = steepetDescentImagesXerror*HInv

    % ParameterVector update
      paramVect = paramVect +reshape(deltaP, 2, 3);

     if sum(abs(deltaP))< 1e-5
         break;
     end
    
    
end
