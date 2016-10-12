%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%
% CSCI 5722 - HW2
% Jianxiang Fan
% jianxiang.fan@colorado.edu
%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

% Merge two images with computed homography
function [ out_img ] = merge_images( img1, img2, H )
    [out_img, offset] = wrap_image(img1, img2, H);
    [a,b,~] = size(img1);
    [m,n,~] = size(out_img);
    for i=1:a
        for j=1:b
            x = i + offset(1);
            y = j + offset(2);
            if x <= m && y <= n && isnan(out_img(x,y,1))
                out_img(x,y,:) = img1(i, j, :);
            end
        end
    end
    out_img = uint8(out_img);
end

