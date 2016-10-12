%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%
% CSCI 5722 - HW2
% Jianxiang Fan
% jianxiang.fan@colorado.edu
%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

% Load images
image_choice = menu('Choose an image', 'uttower', 'mountain', 'field');
switch image_choice
    case 1
        filename = 'uttower';
    case 2
        filename = 'mountain';
    case 3
        filename = 'field';
end

img1 = imread(strcat(filename,'2.jpg'));
img2 = imread(strcat(filename,'1.jpg'));

% Show images
figure;
subplot(1,2,1);
imagesc(img1);
subplot(1,2,2)
imagesc(img2);

% Pick 5 corresponding points in two images alternately
n = 5;
points1 = zeros(n,2);
points2 = zeros(n,2);
for i=1:n
    [x1,y1] = ginput(1);
    hold on;
    plot(x1,y1,'g.','MarkerSize',15);
    points1(i,:) = [y1, x1];
    hold off;
    [x2,y2] = ginput(1);
    hold on;
    plot(x2,y2,'r.','MarkerSize',15);
    points2(i,:) = [y2, x2];
    hold off;
end

h = msgbox('Merging...');

% Estimate the homography
H = estimate_homography(points1, points2);
% Merge the image
output_img = merge_images(img1, img2, H);

delete(h);

% Show and save the mosaics
figure;
imagesc(output_img);
imwrite(output_img,strcat(filename,'_mosaics.jpg'));
