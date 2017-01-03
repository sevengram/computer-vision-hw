%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%
% CSCI 5722 - HW4
% Jianxiang Fan
% jianxiang.fan@colorado.edu
%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

% Task 2 - Part A
% Disparity matching using dynamic programing
function [ M ] = stereoDP( e1, e2, maxDisp, occ )
    [~, m] = size(e1);
    [~, n] = size(e2);
    D = Inf(m+1, n+1);
    M = zeros(m, n);
    D(1,:) = (0:n) * occ;
    D(:,1) = (0:m)'* occ;
    D(2,2) = (e1(1) - e2(1))^2;
    for i=1:m
        for j=max(1,i-maxDisp):min(n,i+maxDisp)
            if i ~= 1 || j ~= 1
                m1 = D(i,j) + (e1(i) - e2(j))^2;
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

