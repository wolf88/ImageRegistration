%% steepDescentCompute() -> computes Hessian matrix and Steepest descent Images
% gx,gy - image gradients, error -Error Image
function [SD,HessianM] = steepDescentCompute(gx,gy, params)
[r,c] = size(gx);
[y,x] = ndgrid(1:r,1:c); % Jacobian
scP = params.scalingCenterPatch;
x=x-scP(1); y=y-scP(2);% centering

SD.s1 = x.*gx;
SD.s2 = x.*gy;
SD.s3 = y.*gx;
SD.s4 = y.*gy;
SD.s5 = gx;
SD.s6 = gy;
                        
%Hessian Matrix                        
HessianM = [sum(sum(SD.s1.*SD.s1)),sum(sum(SD.s1.*SD.s2)),sum(sum(SD.s1.*SD.s3)),sum(sum(SD.s1.*SD.s4)),sum(sum(SD.s1.*SD.s5)),sum(sum(SD.s1.*SD.s6)); ...
            sum(sum(SD.s2.*SD.s1)),sum(sum(SD.s2.*SD.s2)),sum(sum(SD.s2.*SD.s3)),sum(sum(SD.s2.*SD.s4)),sum(sum(SD.s2.*SD.s5)),sum(sum(SD.s2.*SD.s6)); ...
            sum(sum(SD.s3.*SD.s1)),sum(sum(SD.s3.*SD.s2)),sum(sum(SD.s3.*SD.s3)),sum(sum(SD.s3.*SD.s4)),sum(sum(SD.s3.*SD.s5)),sum(sum(SD.s3.*SD.s6)); ...
            sum(sum(SD.s4.*SD.s1)),sum(sum(SD.s4.*SD.s2)),sum(sum(SD.s4.*SD.s3)),sum(sum(SD.s4.*SD.s4)),sum(sum(SD.s4.*SD.s5)),sum(sum(SD.s4.*SD.s6)); ...
            sum(sum(SD.s5.*SD.s1)),sum(sum(SD.s5.*SD.s2)),sum(sum(SD.s5.*SD.s3)),sum(sum(SD.s5.*SD.s4)),sum(sum(SD.s5.*SD.s5)),sum(sum(SD.s5.*SD.s6)); ...
            sum(sum(SD.s6.*SD.s1)),sum(sum(SD.s6.*SD.s2)),sum(sum(SD.s6.*SD.s3)),sum(sum(SD.s6.*SD.s4)),sum(sum(SD.s6.*SD.s5)),sum(sum(SD.s6.*SD.s6))];
end