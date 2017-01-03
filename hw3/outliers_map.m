%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%
% CSCI 5722 - HW3
% Jianxiang Fan
% jianxiang.fan@colorado.edu
%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

% Check if |d_lr(x,y) - d_rl(x-d_lr(x,y))| <= threshold
function [ result ] = outliers_map( disp_lr, disp_rl, threshold )
[m,n] = size(disp_lr);
result = uint8(zeros(m,n));
for x=1:m
    for y=1:n
        t = disp_lr(x, y);
        if x-round(t) >= 1 && x-round(t) <= m && abs(t - disp_rl(x-round(t), y)) > threshold
            result(x,y) = 1;
        end
    end
end
end
