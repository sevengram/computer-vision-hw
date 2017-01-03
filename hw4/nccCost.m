%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%
% CSCI 5722 - HW4
% Jianxiang Fan
% jianxiang.fan@colorado.edu
%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

function [ ncc ] = nccCost( img1, img2, x, y1, y2, window_radius )
    [m,n] = size(img1);
    r = window_radius;
    i1_i2 = 0;
    i1_2 = 0;
    i2_2 = 0;
    for i=-r:r
        for j=-r:r
            % Check the boundary
            if x+i <= m && x+i >= 1 && y1+j <= n && y2+j <= n && y1+j >= 1 && y2+j >= 1
                a = img1(x+i, y1+j);
                b = img2(x+i, y2+j);
                i1_i2 = i1_i2 + a*b;
                i1_2 = i1_2 + a^2;
                i2_2 = i2_2 + b^2;
            end
        end
    end
    ncc = i1_i2 / sqrt(i1_2 * i2_2);
end