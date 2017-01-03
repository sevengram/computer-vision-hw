%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%
% CSCI 5722 - HW3
% Jianxiang Fan
% jianxiang.fan@colorado.edu
%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

% Depth = Focal_length * Baseline / Disparity
% Focal_length : in pixels
% Baseline : in metres
% Disparity : in pixels
function [ depth_map ] = compute_depth( disparityMap, stereoParams )
    baseline = abs(stereoParams.TranslationOfCamera2(1)) / 1000; % in metres
    focal_length = stereoParams.CameraParameters1.FocalLength(1) / 0.25; % in pixels
    depth_map = focal_length * baseline ./ disparityMap;
end