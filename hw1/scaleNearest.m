%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%
% CSCI 5722 - HW1
% Jianxiang Fan
% jianxiang.fan@colorado.edu
%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

function [ out_img ] = scaleNearest( img, factor )
    [m,n,~] = size(img);
    x = round(m*factor); % height of out image
    y = round(n*factor); % width of out image
    out_img = uint8(zeros(x,y,3));
    a = min(max(round((1:x)/factor),1),m); % round to nearest x
    b = min(max(round((1:y)/factor),1),n); % round to nearest y
    for i=1:x
        for j=1:y
            out_img(i,j,:) = img(a(i),b(j),:);
        end
    end
end
