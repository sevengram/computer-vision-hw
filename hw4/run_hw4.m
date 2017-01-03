%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%
% CSCI 5722 - HW4
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

%figure;
%imshow(stereoAnaglyph(frameLeftRect, frameRightRect));
%title('Rectified Video Frames');

%% Compute Disparity
% In rectified stereo images any pair of corresponding points are located 
% on the same pixel row. For each pixel in the left image compute the
% distance to the corresponding pixel in the right image. This distance is
% called the disparity, and it is proportional to the distance of the
% corresponding world point from the camera.
frameLeftGray  = rgb2gray(frameLeftRect);
frameRightGray = rgb2gray(frameRightRect);

% Task 2. Dynamic Programming
dm1 = disparityMap(frameLeftGray, frameRightGray, 1, 0, 32, 0.01);
% SSD
% dm1 = disparityMap(frameLeftGray, frameRightGray, 2, 1, 32, 0.01);
% NCC
% dm1 = disparityMap(frameLeftGray, frameRightGray, 3, 1, 32, 0.01);
figure;
imshow(dm1);
title('Task 2');

% Task 3
frameLeftGray = rgb2gray(imread('cone_1.png'));
frameRightGray = rgb2gray(imread('cone_2.png'));
dm2 = disparityMap(frameLeftGray, frameRightGray, 1, 0, 64, 0.005);
figure;
imshow(dm2);
title('Task 3');

% Task 4
frameLeftGray = rgb2gray(imread('teddy_1.png'));
frameRightGray = rgb2gray(imread('teddy_2.png'));
dm3 = disparityMap(frameLeftGray, frameRightGray, 1, 0, 64, 0.005);
figure;
imshow(dm3);
title('Task 4');

