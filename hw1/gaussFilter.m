%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%
% CSCI 5722 - HW1
% Jianxiang Fan
% jianxiang.fan@colorado.edu
%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

function [ out_img ] = gaussFilter( img, sigma )
    [m,n,~] = size(img);

    % Kernel size
    k = 2 * ceil(2 * sigma) + 1;
    r = fix(k / 2);

    % Precomputation, then G(x,y) = a*b^(x^2+y^2)
    a = 0.5 / (pi * sigma^2);
    b = exp(-0.5 / sigma^2);

    % Gassian weight matrix
    G = zeros(k, k, 3);
    for i = 1:k
        for j = 1:k
            G(i,j,:) = a*b^((i-r-1)^2 + (j-r-1)^2);
        end
    end

    % Padding with NaN
    out_img = img;
    img = NaN(m+k, n+k, 3);
    img(1+r:m+r, 1+r:n+r, :) = out_img;

    for i=1:m
        for j=1:n
            u = img(i:i+k-1, j:j+k-1, :);
            w = G .* ~isnan(u);
            out_img(i, j, :) = nansum(nansum(u .* w))/ sum(sum(w(:,:,1)));
        end
    end
end

