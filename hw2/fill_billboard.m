%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%
% CSCI 5722 - HW2
% Jianxiang Fan
% jianxiang.fan@colorado.edu
%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

img1 = imread('billboard.jpg');
img2 = imread('les_miserables.jpg');
[m,n,~] = size(img2);

figure;
imagesc(img1);
title('Select the billboard starting from left top corner in clockwise order');
points1 = zeros(4,2);
points2 = [1,1; 1,n; m,n; m,1];
for i=1:4
    [x1,y1] = ginput(1);
    hold on;
    plot(x1,y1,'g.','MarkerSize',15);
    points1(i,:) = [y1, x1];
    hold off;
end

h = msgbox('Merging...');

% Estimate the homography
H = estimate_homography(points1, points2);
% Merge the image
output_img = merge_images(img1, img2, H);

delete(h);

% Show and save the output image
figure;
imagesc(output_img);
imwrite(output_img, strcat('modified_billboard.jpg'));


