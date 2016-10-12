%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%
% CSCI 5722 - HW1
% Jianxiang Fan
% jianxiang.fan@colorado.edu
%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

% Swirl Filter
function [ out_img ] = funFilter( img )
    [m,n,~] = size(img);
    out_img = uint8(zeros(m,n,3));
    
    % Compute the center
    a = m/2;
    b = n/2;
    
    alpha = 5;
    for i=1:m
        for j=1:n
            x = i-a;
            y = j-b;
            r = sqrt(x^2 + y^2);
            theta = arctan(y,x) + r*alpha/m;
            x = r * cos(theta);
            y = r * sin(theta);
            
            % Sample nearest
            x = min(max(round(x+a),1), m);
            y = min(max(round(y+b),1), n);
            
            out_img(i,j,:) = img(x,y,:);
        end
    end
end

function v = arctan(y, x)
    if x > 0
        v = atan(y/x);
    elseif x < 0
        v = pi + atan(y/x);
    elseif x == 0 && y >= 0 
        v = pi/2;
    elseif x == 0 && y < 0
        v = -pi/2;
    end
end
