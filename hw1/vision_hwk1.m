% This script creates a menu driven application

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%
% CSCI 5722 - HW1
% Jianxiang Fan
% jianxiang.fan@colorado.edu
%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
clear all;close all;clc;

% Display a menu and get a choice
choice = menu('Choose an option', 'Exit Program', 'Load Image', ...
    'Display Image', 'Mean Filter', 'Gaussian Filter', 'Scale Nearest', ...
    'Scale Bilinear');

% Choice 1 is to exit the program
while choice ~= 1
    switch choice
        case 0
            disp('Error - please choose one of the options.')
        case 2
            % Load an image
            image_choice = menu('Choose an image', 'lena1', 'mandrill1', 'sully', 'yoda', 'shrek');
            switch image_choice
                case 1
                    filename = 'lena1.jpg';
                case 2
                    filename = 'mandrill1.jpg';
                case 3
                    filename = 'sully.bmp';
                case 4
                    filename = 'yoda.bmp';
                case 5
                    filename = 'shrek.bmp';
            end
            current_img = imread(filename);
        case 3
            % Display image
            figure;
            imagesc(current_img);
            if size(current_img, 3) == 1
                colormap gray
            end
        case 4
            % Mean Filter
            user_input = inputdlg('Size of kernel');
            kernel_size = str2double(user_input{:});
            new_image = meanFilter(current_img, kernel_size);
            compareImages(current_img, new_image);
            imwrite(new_image, strcat('mean_',filename));
        case 5
            % Gaussian Filter
            user_input = inputdlg('sigma');
            sigma = str2double(user_input{:});
            new_image = gaussFilter(current_img, sigma);
            compareImages(current_img, new_image);
            imwrite(new_image, strcat('gaussian_',filename));
        case 6
            % Scale	Nearest
            user_input = inputdlg('factor');
            factor = str2double(user_input{:});
            new_image = scaleNearest(current_img, factor);
            compareImages(current_img, new_image);
            imwrite(new_image, strcat('scale_nearest_',filename));
        case 7
            % Scale	Bilinear
            user_input = inputdlg('factor');
            factor = str2double(user_input{:});
            new_image = scaleBilinear(current_img, factor);
            compareImages(current_img, new_image);
            imwrite(new_image, strcat('scale_bilinear_',filename));
    end
    % Display menu again and get user's choice
    choice = menu('Choose an option', 'Exit Program', 'Load Image', ...
        'Display Image', 'Mean Filter', 'Gaussian Filter', 'Scale Nearest', ...
        'Scale Bilinear');
end
