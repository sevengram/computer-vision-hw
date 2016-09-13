%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%
% CSCI 5722 - HW1
% Jianxiang Fan
% jianxiang.fan@colorado.edu
%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

% Swirl Filter
% Convert to polar co-ordinates
% mapping function: new[theta, rho] = old[theta + rho / k, rho]
function [ out_img ] = funFilter( img )
    [m,n,~] = size(img);
    out_img = uint8(zeros(m,n,3));
    
    % Compute the center
    a = m/2;
    b = n/2;
    
    k = m / 5;
    for i=1:m
        for j=1:n
            [theta,rho] = cart2pol(i-a,j-b);
            [x,y] = pol2cart(theta + rho / k, rho);
            
            % Sample nearest
            x = min(max(round(x+a),1),m);
            y = min(max(round(y+b),1),n);
            
            out_img(i,j,:) = img(x,y,:);
        end
    end
end

