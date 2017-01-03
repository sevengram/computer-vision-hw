%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%
% CSCI 5722 - HW4
% Jianxiang Fan
% jianxiang.fan@colorado.edu
%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

% Task 1: Longest common subsequence
function [ result ] = lcs( x, y )
    [~,m] = size(x);
    [~,n] = size(y);
    L = zeros(m+1,n+1);
    for i=1:m
        for j=1:n
            if x(i) == y(j)
                L(i+1,j+1) = L(i,j) + 1;
            else
                L(i+1,j+1) = max(L(i+1,j), L(i,j+1));
            end
        end
    end
    l = L(m+1,n+1);
    result = blanks(l);
    while (l > 0 && i > 0 && j > 0)
        if x(i) == y(j)
            result(l) = x(i);
            l = l - 1;
            i = i - 1;
            j = j - 1;
        else
            if L(i+1,j) > L(i,j+1)
                j = j - 1;
            else
                i = i - 1;
            end
        end
    end
end

