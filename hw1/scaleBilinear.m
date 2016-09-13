%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%
% CSCI 5722 - HW1
% Jianxiang Fan
% jianxiang.fan@colorado.edu
%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

function [ out_img ] = scaleBilinear( img, factor )
    [m,n,~] = size(img);
    x = round(m*factor); % height of out image
    y = round(n*factor); % width of out image
    padded_img = pad_border(img);
    out_img = uint8(zeros(x,y,3));
    a = (1:x)/factor;
    a2 = ceil(a);
    a1 = a2 - 1;
    wa1 = a2 - a; % weights of a1
    wa2 = a - a1; % weights of a2
    b = (1:y)/factor;
    b2 = ceil(b);
    b1 = b2 - 1;
    wb1 = b2 - b; % weights of b1
    wb2 = b - b1; % weights of b2
    for i=1:x
        for j=1:y
            % Bilinear interpolation
            v1 = wa1(i)*padded_img(a1(i)+1,b1(j)+1,:) + wa2(i)*padded_img(a2(i)+1,b1(j)+1,:);
            v2 = wa1(i)*padded_img(a1(i)+1,b2(j)+1,:) + wa2(i)*padded_img(a2(i)+1,b2(j)+1,:);
            out_img(i,j,:) = wb1(j)*v1 + wb2(j)*v2;
        end
    end
end

% Pad each border with one pixel
function [out_img] = pad_border( img )
    [m,n,~] = size(img);
    out_img = zeros(m+2, n+2, 3);
    out_img(2:m+1, 2:n+1, :) = img;

    out_img(1,2:n+1,:) = img(1,:,:);
    out_img(m+2,2:n+1,:) = img(m,:,:);
    out_img(2:m+1,1,:) = img(:,1,:);
    out_img(2:m+1,n+2,:) = img(:,n,:);

    out_img(1,1,:) = img(1,1,:);
    out_img(1,n+2,:) = img(1,n,:);
    out_img(m+2,1,:) = img(m,1,:);
    out_img(m+2,n+2,:) = img(m,n,:);
end