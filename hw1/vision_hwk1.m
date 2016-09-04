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
    'Display Image', 'Mean Filter');  % as you develop functions, add buttons for them here

% Choice 1 is to exit the program
while choice ~= 1
    switch choice
        case 0
            disp('Error - please choose one of the options.')
            % Display a menu and get a choice
            choice = menu('Choose an option', 'Exit Program', 'Load Image', ...
                'Display Image', 'Mean Filter');  % as you develop functions, add buttons for them here
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
            
            % 1. Ask the user for size of kernel
            user_input = inputdlg('Size of kernel');
            kernel_size = str2double(user_input{:});
            
            % 2. Call the appropriate function
            new_image = meanFilter(current_img, kernel_size); % create your own function for the mean filter
            
            % 3. Display the old and the new image using subplot
            compareImages(current_img, new_image);
            
            % 4. Save the newImage to a file
            imwrite(new_image, strcat('mean_',filename));
            
        case 5
            %....
            
            %....
    end
    % Display menu again and get user's choice
    choice = menu('Choose an option', 'Exit Program', 'Load Image', ...
        'Display Image', 'Mean Filter');  % as you develop functions, add buttons for them here
end
