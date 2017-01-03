%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%
% CSCI 5722 - HW4
% Jianxiang Fan
% jianxiang.fan@colorado.edu
%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

% Task 2 - Part B
% Find the optimal alignment (and thus the disparity) by backtracking.
function [ d ] = backTracking( M )
[m, n] = size(M);
d = NaN(1,n);
while m >= 1 && n >= 1
    if M(m,n) == 0
        d(n) = abs(m - n);
        m = m - 1;
        n = n - 1;
    elseif M(m,n) == 1
        m = m - 1;
    else
        n = n - 1;
    end
end
end

