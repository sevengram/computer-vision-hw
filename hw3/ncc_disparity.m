%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%
% CSCI 5722 - HW3
% Jianxiang Fan
% jianxiang.fan@colorado.edu
%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

function [ result ] = ncc_disparity( left_image, right_image, window_radius, disparity_range, right_ref)
[m,n] = size(left_image);
result = zeros(m,n);
r = window_radius;
left_image = double(left_image);
right_image = double(right_image);
for x=1+r:m-r
    for y=1+r:n-r
        max_ncc = -Inf;
        for d= disparity_range(1):disparity_range(2)  % Search in the disparity range
            if (right_ref && y+r+d <= n) || (~right_ref && y-r-d >= 1)
                % Compute NCC of the windows
                i1_i2 = 0;
                i1_2 = 0;
                i2_2 = 0;
                for i=-r:r
                    for j=-r:r
                        if right_ref
                            % Use right image as reference
                            i1_i2 = i1_i2 + right_image(x+i, y+j)*left_image(x+i, y+j+d);
                            i1_2 = i1_2 + right_image(x+i, y+j)^2;
                            i2_2 = i2_2 + left_image(x+i, y+j+d)^2;
                        else
                            % Use left image as reference
                            i1_i2 = i1_i2 + right_image(x+i, y+j-d)*left_image(x+i, y+j);
                            i1_2 = i1_2 + right_image(x+i, y+j-d)^2;
                            i2_2 = i2_2 + left_image(x+i, y+j)^2; 
                        end
                    end
                end
                ncc = i1_i2 / sqrt(i1_2 * i2_2);
                if ncc > max_ncc
                    result(x,y) = d;
                    max_ncc = ncc;
                end
            end
        end
    end
end
end

