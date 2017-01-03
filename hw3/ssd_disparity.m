%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%
% CSCI 5722 - HW3
% Jianxiang Fan
% jianxiang.fan@colorado.edu
%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

function [ result ] = ssd_disparity( left_image, right_image, window_radius, disparity_range, right_ref )
[m,n] = size(left_image);
result = zeros(m,n);
r = window_radius;
left_image = double(left_image);
right_image = double(right_image);
g = fspecial('gaussian', 2*r+1, 1); % Gaussian Filter Matrix
for x=1+r:m-r
    for y=1+r:n-r
        min_ssd = Inf;
        for d= disparity_range(1):disparity_range(2) % Search in the disparity range
            if (right_ref && y+r+d <= n) || (~right_ref && y-r-d >= 1)
                % Compute SSD of the windows
                ssd = 0;
                for i=-r:r
                   for j=-r:r
                       if right_ref
                           % Use right image as reference
                           ssd = ssd + g(i+r+1,j+r+1)*(right_image(x+i,y+j)-left_image(x+i,y+j+d))^2;
                       else
                           % Use left image as reference
                           ssd = ssd + g(i+r+1,j+r+1)*(right_image(x+i,y+j-d)-left_image(x+i,y+j))^2;
                       end
                   end
                end
                if ssd < min_ssd
                    result(x,y) = d;
                    min_ssd = ssd;
                end
            end
        end
    end
end
end
