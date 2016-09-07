%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%
% CSCI 5722 - HW1
% Jianxiang Fan
% jianxiang.fan@colorado.edu
%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

function [ out_img ] = meanFilter( img, kernel_size )
    [m,n,~] = size(img);
    k = kernel_size;
    r = fix(k/2);
    
    % Padding with NaN
    out_img = img;
    img = NaN(m+k, n+k, 3); 
    img(1+r:m+r, 1+r:n+r, :) = out_img;
    
    for i=1:m
        for j=1:n
            out_img(i, j, :) = nanmean(nanmean(img(i:i+k-1, j:j+k-1, :)));
        end
    end
end
