%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%
% CSCI 5722 - HW4
% Jianxiang Fan
% jianxiang.fan@colorado.edu
%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

% Task 2 - Part B
% Display the disparity map
function [ result ] = disparityMap( img1, img2, method, window_radius, maxDisp, occ )
    img1 = im2double(img1);
    img2 = im2double(img2);
    [x,y] = size(img1);
    result = zeros(x,y,3);
    d = zeros(x,y);
    for i=1:x
        % Different cost functions
        if method == 1
            M = stereoDP(img1(i,:), img2(i,:), maxDisp, occ);
        elseif method == 2
            M = stereoSSD(img1, img2, i, window_radius, maxDisp, occ);
        else
            M = stereoNCC(img1, img2, i, window_radius, maxDisp, occ);
        end
        
        % Do backtracking to find the disparity
        d(i,:) = backTracking(M);
    end
    
    % Generate the graph
    d = d / max(d(:));
    r = d;
    g = d;
    b = d;
    idx = isnan(d);
    r(idx) = 1;
    g(idx) = 0;
    b(idx) = 0;
    result(:,:,1) = r;
    result(:,:,2) = g;
    result(:,:,3) = b;
end
