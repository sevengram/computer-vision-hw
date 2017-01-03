%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%
% CSCI 5722 - HW4
% Jianxiang Fan
% jianxiang.fan@colorado.edu
%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

% Task 2 - Part C
% Disparity matching using dynamic programing (NCC as cost metrics)

function [ M ] = stereoNCC( img1, img2, x, window_radius, maxDisp, occ)
    [~, m] = size(img1);
    [~, n] = size(img2);
    D = Inf(m+1, n+1);
    M = zeros(m, n);
    D(1,:) = (0:n) * occ;
    D(:,1) = (0:m)'* occ;
    D(2,2) = nccCost(img1,img2,x,1,1,window_radius);
    for i=1:m
        for j=max(1,i-maxDisp):min(n,i+maxDisp)
            if i ~= 1 || j ~= 1
                m1 = D(i,j) + 1 - nccCost(img1,img2,x,i,j,window_radius);
                m2 = D(i,j+1) + occ;
                m3 = D(i+1,j) + occ;
                if m1 < min(m2, m3)
                    D(i+1, j+1) = m1;
                    M(i,j) = 0;
                elseif m2 < m3
                    D(i+1, j+1) = m2;
                    M(i,j) = 1;
                else
                    D(i+1, j+1) = m3;
                    M(i,j) = -1;
                end
            end
        end
    end
end

