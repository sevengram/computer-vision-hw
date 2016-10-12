%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%
% CSCI 5722 - HW2
% Jianxiang Fan
% jianxiang.fan@colorado.edu
%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

% Estimate Homography
% We can set up a solution using a system of linear equations Ax=b, where the 8
% unknowns of H are stacked into an 8-vector x (H(3,3)=1), the 2n-vector b contains 
% image points from one view, and the 2nx8 matrix A is filled appropriately.
function [ H ] = estimate_homography( points1, points2 )
    [n,~] = size(points1);
    A = zeros(2*n, 8);
    for i=1:n
        p1 = points1(i,:);
        p2 = points2(i,:);
        A(2*i-1,:) = [p1(1),p1(2),1,0,0,0,-p1(1)*p2(1),-p1(2)*p2(1)];
        A(2*i,:)   = [0,0,0,p1(1),p1(2),1,-p1(1)*p2(2),-p1(2)*p2(2)];
    end
    b = reshape(points2',[2*n, 1]);
    x = ones(9, 1);
    x(1:8) = A\b;
    H = reshape(x, [3,3])';
end

