%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%
% CSCI 5722 - HW3
% Jianxiang Fan
% jianxiang.fan@colorado.edu
%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

%% Depth Estimation From Stereo Video
% This example shows how to detect people in video taken with a calibrated
% stereo camera and determine their distances from the camera.
%
%   Copyright 2013-2014 The MathWorks, Inc.

%% Load the Parameters of the Stereo Camera
% Load the |stereoParameters| object, which is the result of calibrating
% the camera using either the |stereoCameraCalibrator| app or the
% |estimateCameraParameters| function.

% Load the stereoParameters object.
load('handshakeStereoParams.mat');

% Visualize camera extrinsics.
% showExtrinsics(stereoParams);

%% Create Video File Readers and the Video Player
% Create System Objects for reading and displaying the video
videoFileLeft = 'handshake_left.avi';
videoFileRight = 'handshake_right.avi';

readerLeft = vision.VideoFileReader(videoFileLeft, 'VideoOutputDataType', 'uint8');
readerRight = vision.VideoFileReader(videoFileRight, 'VideoOutputDataType', 'uint8');
player = vision.VideoPlayer('Position', [20, 400, 850, 650]);

%% Read and Rectify Video Frames
% The frames from the left and the right cameras must be rectified in order
% to compute disparity and reconstruct the 3-D scene. Rectified images 
% have horizontal epipolar lines, and are row-aligned. This simplifies 
% the computation of disparity by reducing the search space for matching
% points to one dimension.  Rectified images can also be combined into an
% anaglyph, which can be viewed using the stereo red-cyan glasses to see
% the 3-D effect.
frameLeft = readerLeft.step();
frameRight = readerRight.step();

[frameLeftRect, frameRightRect] = ...
    rectifyStereoImages(frameLeft, frameRight, stereoParams);

% figure;
% imshow(stereoAnaglyph(frameLeftRect, frameRightRect));
% title('Rectified Video Frames');

%% Compute Disparity
% In rectified stereo images any pair of corresponding points are located 
% on the same pixel row. For each pixel in the left image compute the
% distance to the corresponding pixel in the right image. This distance is
% called the disparity, and it is proportional to the distance of the
% corresponding world point from the camera.
frameLeftGray  = rgb2gray(frameLeftRect);
frameRightGray = rgb2gray(frameRightRect);

frameLeftGray = frameLeftGray(1:7,:);
frameRightGray = frameRightGray(1:7,:);

%frameLeftGray = imread('tsukubaleft.jpg');
%frameRightGray = imread('tsukubaright.jpg');

disparityRange = [0, 64];
%d1 = disparity(frameLeftGray, frameRightGray, 'DisparityRange', disparityRange);

%% Task 1: Calculate disparity using the SSD algorithm
d2 = ssd_disparity(frameLeftGray, frameRightGray, 0, disparityRange, true); % window size=1, radius=0
d3 = ssd_disparity(frameLeftGray, frameRightGray, 1, disparityRange, true); % window size=3, radius=1
d4 = ssd_disparity(frameLeftGray, frameRightGray, 2, disparityRange, true); % window size=5, radius=2

%figure
%subplot(2, 2, 1)
%imshow(d1, disparityRange)
%title('Matlab Disparity')
%colormap jet
%colorbar

subplot(2, 2, 2)
imshow(d2, disparityRange)
title('SSD Disparity window=1')
colormap jet
colorbar

subplot(2, 2, 3)
imshow(d3, disparityRange)
title('SSD Disparity window=3')
colormap jet
colorbar

subplot(2, 2, 4)
imshow(d4, disparityRange)
title('SSD Disparity window=5')
colormap jet
colorbar

%% Task 2: Calculate disparity using the NCC algorithm
d5 = ncc_disparity(frameLeftGray, frameRightGray, 1, disparityRange, true); % window size=3, radius=1
d6 = ncc_disparity(frameLeftGray, frameRightGray, 2, disparityRange, true); % window size=5, radius=2
d7 = ncc_disparity(frameLeftGray, frameRightGray, 3, disparityRange, true); % window size=7, radius=3

% figure
% subplot(2, 2, 1)
% imshow(d1, disparityRange)
% title('Matlab Disparity')
% colormap jet
% colorbar

subplot(2, 2, 2)
imshow(d5, disparityRange)
title('NCC Disparity window=3')
colormap jet
colorbar

subplot(2, 2, 3)
imshow(d6, disparityRange)
title('NCC Disparity window=5')
colormap jet
colorbar

subplot(2, 2, 4)
imshow(d7, disparityRange)
title('NCC Disparity window=7')
colormap jet
colorbar


%% Task 3: Generate outliers map
disp_lr1 = ssd_disparity(frameLeftGray, frameRightGray, 1, disparityRange, false);
disp_rl1 = d3;
outliners1 = outliers_map(disp_lr1, disp_rl1, 5);

disp_lr2 = ncc_disparity(frameLeftGray, frameRightGray, 1, disparityRange, false);
disp_rl2 = d5;
outliners2 = outliers_map(disp_lr2, disp_rl2, 5);

figure
subplot(1,2,1)
imshow(outliners1, [0,1])
title('Outliners Map (SSD)')
colorbar

subplot(1,2,2)
imshow(outliners2, [0,1])
title('Outliners Map (NCC)')
colorbar

%% Task 4: Compute depth from disparity
depth_map = compute_depth(d4, stereoParams);
figure
imshow(depth_map, [0, 30])
title('Depth Map (metre)')
colormap jet
colorbar
