%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%
% CSCI 5722 - HW2
% Jianxiang Fan
% jianxiang.fan@colorado.edu
%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

function [ out_img, offset ] = wrap_image( img1, img2, H )
    % Compute the size of the destination image
    [a,b,~] = size(img1);
    [m,n,~] = size(img2);
    corners = zeros(6,2);
    p = H\[1;1;1];
    corners(1,:) = p(1:2)/p(3);
    p = H\[1;n;1];
    corners(2,:) = p(1:2)/p(3);
    p = H\[m;1;1];
    corners(3,:) = p(1:2)/p(3);
    p = H\[m;n;1];
    corners(4,:) = p(1:2)/p(3);
    corners(5,:) = [1,1];
    corners(6,:) = [a,b];
    left_top = min(corners);
    right_bottom = max(corners);
    s = round(right_bottom - left_top);
    
    % Compute the out image
    out_img = NaN(s(1),s(2),3);
    for i=1:s(1)
        for j=1:s(2)
             p = H * [i+left_top(1); j+left_top(2); 1];
             p = p / p(3);
             if p(1)>=1 && p(2)>=1 && p(1)<=m && p(2)<=n
                 out_img(i,j,:) = bilinear_interpolation(img2, p(1), p(2));
             end
        end
    end
    offset = floor([1,1]-left_top);
end
