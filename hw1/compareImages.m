%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%
% CSCI 5722 - HW1
% Jianxiang Fan
% jianxiang.fan@colorado.edu
%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

function compareImages( img1, img2 )
    figure;
    subplot(1,2,1);
    imagesc(img1);
    subplot(1,2,2)
    imagesc(img2);
    if size(img1, 3) == 1
        colormap gray
    end
end

