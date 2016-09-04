%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%
% CSCI 5722 - HW1
% Jianxiang Fan
% jianxiang.fan@colorado.edu
%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

function [ out_img ] = meanFilter( img, kernel_size )
    [m,n,~] = size(img);
    out_img = img;
    k = kernel_size;
    r = fix(k/2);
    img = NaN(m+k, n+k, 3); % padding with NaN
    img(1+r:m+r, 1+r:n+r, :) = out_img;
    for i=1:m
        for j=1:n
            out_img(i, j, :) = nanmean(nanmean(img(i:i+k, j:j+k, :)));
        end
    end
end
