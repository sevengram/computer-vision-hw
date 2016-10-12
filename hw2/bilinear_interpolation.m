%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%
% CSCI 5722 - HW2
% Jianxiang Fan
% jianxiang.fan@colorado.edu
%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

% Use bilinear interpolation to compute pixel value of img(a,b)
function [ pixel ] = bilinear_interpolation( img, a, b )
    a2 = ceil(a);
    a1 = a2 - 1;
    wa1 = a2 - a; % weights of a1
    wa2 = a - a1; % weights of a2
    b2 = ceil(b);
    b1 = b2 - 1;
    wb1 = b2 - b; % weights of b1
    wb2 = b - b1; % weights of b2
    v1 = wa1*img(a1,b1,:) + wa2*img(a2,b1,:);
    v2 = wa1*img(a1,b2,:) + wa2*img(a2,b2,:);
    pixel = wb1*v1 + wb2*v2;   
end
