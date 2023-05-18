%% Transforms the cordinates based on the parameter vector
function [wrapLocX,wrapLocY]  = Transloc(xlistV,ylistV,paramVect, p)
lx = length(xlistV);
ly = length(ylistV);
wrapLocX = zeros(ly,lx);
wrapLocY = wrapLocX;

scalingCenter = p.scalingCenterImage;
for i = 1:lx
    for j= 1:ly
        xIn = [xlistV(i) - scalingCenter(1) , ylistV(j) - scalingCenter(2) , 1]';
        cord = paramVect * xIn;
        cord = cord + scalingCenter;
        wrapLocX(j,i) = cord(1);
        wrapLocY(j,i) = cord(2);
    end
end
end