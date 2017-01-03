%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%
% CSCI 5722 - HW4
% Jianxiang Fan
% jianxiang.fan@colorado.edu
%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

function [ ssd ] = ssdCost( img1, img2, x, y1, y2, window_radius )
    [m,n] = size(img1);
    r = window_radius;
    ssd = 0;
    for i=-r:r
       for j=-r:r
           % Check the boundary
           if x+i <= m && x+i >= 1 && y1+j <= n && y2+j <= n && y1+j >= 1 && y2+j >= 1
               ssd = ssd + ((img1(x+i,y1+j)-img2(x+i,y2+j))/(2*r+1))^2;
           end
       end
    end
end
